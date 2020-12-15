package de.joneug.mdal.validation

import com.google.inject.Inject
import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.Model
import de.joneug.mdal.tests.MdalInjectorProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.junit.Assert.assertNotNull

@ExtendWith(InjectionExtension)
@InjectWith(MdalInjectorProvider)
class EntityValidatorTest {

	@Inject
	ParseHelper<Model> parseHelper

	@Inject extension ValidationTestHelper

	@Test
	def void testNamesNotUnique() {
		// Tests method "checkNamesAreUnique"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
					
					fields {
						template("Description"; Description)
					}
				}
				
				supplemental "Seminar" {
					ShortName = "Sem.";
					
					fields {
						template("Name"; Name)
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertError(MdalPackage.eINSTANCE.master, MdalValidator.ENTITY_NAME_EXISTS)
		model.assertError(MdalPackage.eINSTANCE.supplemental, MdalValidator.ENTITY_NAME_EXISTS)
	}

	@Test
	def void testMissingNameOrDescription() {
		// Tests method "checkHasNameOrDescription"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
					
					fields {
						field("Duration Days"; Decimal)
					}
				}
				
				supplemental "Instructor" {
					ShortName = "Inst.";
					
					fields {
						field("Contact No."; Code[20])
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertWarning(MdalPackage.eINSTANCE.master, MdalValidator.ENTITY_NAME_DESCRIPTION)
		model.assertWarning(MdalPackage.eINSTANCE.supplemental, MdalValidator.ENTITY_NAME_DESCRIPTION)
	}

	@Test
	def void testDuplicateFieldNamesWithinRegularFields() {
		// Tests method "checkFieldNamesAreUnique"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				supplemental "Seminar Room" {
					ShortName = "Sem. Room";
					
					fields {
						template("Name"; Name)
						field("Resource No."; Code[20])
						field("Resource No."; Code[20])
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertError(MdalPackage.eINSTANCE.customField, MdalValidator.FIELD_NAME_EXISTS)
	}

	@Test
	def void testDuplicateFieldNamesBetweenRegularAndIncludeFields() {
		// Tests method "checkFieldNamesAreUnique"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
					
					fields {
						template("Description"; Description)
						field("Seminar Price"; Decimal)
					}
				}
				
				document "Seminar Registration" {
					ShortName = "Sem. Reg.";
					
					header "Seminar Registration Header" {
						ShortName = "Sem. Reg. Header";
						StatusCaptions = ["Open", "Closed"];
						
						fields {
							field("Seminar Price"; Decimal)
							include("Seminar Price"; "Seminar"."Seminar Price")
						}
					}
					
					line "Seminar Registration Line" {
						ShortName = "Sem. Reg. Line";
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertError(MdalPackage.eINSTANCE.customField, MdalValidator.FIELD_NAME_EXISTS)
	}

	@Test
	def void testDuplicateFieldNamesWithinIncludeFields() {
		// Tests method "checkFieldNamesAreUnique"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
					
					fields {
						template("Description"; Description)
						field("Seminar Price"; Decimal)
					}
				}
				
				document "Seminar Registration" {
					ShortName = "Sem. Reg.";
					
					header "Seminar Registration Header" {
						ShortName = "Sem. Reg. Header";
						StatusCaptions = ["Open", "Closed"];
						
						fields {
							include("Seminar Price"; "Seminar"."Seminar Price")
							include("Seminar Price"; "Seminar"."Seminar Price")
						}
					}
					
					line "Seminar Registration Line" {
						ShortName = "Sem. Reg. Line";
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertError(MdalPackage.eINSTANCE.includeField, MdalValidator.FIELD_NAME_EXISTS)
	}

	@Test
	def void testMasterDuplicatePageFields() {
		// Tests method "checkDuplicatePageFields"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
					
					fields {
						template("Description"; Description)
						field("Seminar Price"; Decimal)
					}
					
					cardPage {
						group("General") {
							field("Seminar Price")
							field("Seminar Price")
						}
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertWarning(MdalPackage.eINSTANCE.pageField, MdalValidator.PAGE_FIELD_NAME_EXISTS)
	}

	@Test
	def void testSupplementalDuplicatePageFields() {
		// Tests method "checkDuplicatePageFields"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				supplemental "Instructor" {
					ShortName = "Inst.";
					
					fields {
						template("Name"; Name)
					}
					
					listPage {
						field("Name")
						field("Name")
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertWarning(MdalPackage.eINSTANCE.pageField, MdalValidator.PAGE_FIELD_NAME_EXISTS)
	}

	@Test
	def void testDocumentHeaderDuplicatePageFields() {
		// Tests method "checkDuplicatePageFields"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
				}
				
				document "Seminar Registration" {
					ShortName = "Sem. Reg.";
					
					header "Seminar Registration Header" {
						ShortName = "Sem. Reg. Header";
						StatusCaptions = ["Open", "Closed"];
						
						fields {
							field("Starting Date"; Date)
						}
						
						listPage {
							field("Starting Date")
							field("Starting Date")
						}
					}
					
					line "Seminar Registration Line" {
						ShortName = "Sem. Reg. Line";
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertWarning(MdalPackage.eINSTANCE.pageField, MdalValidator.PAGE_FIELD_NAME_EXISTS)
	}

	@Test
	def void testDocumentLineDuplicatePageFields() {
		// Tests method "checkDuplicatePageFields"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
				}
				
				document "Seminar Registration" {
					ShortName = "Sem. Reg.";
					
					header "Seminar Registration Header" {
						ShortName = "Sem. Reg. Header";
						StatusCaptions = ["Open", "Closed"];
					}
					
					line "Seminar Registration Line" {
						ShortName = "Sem. Reg. Line";
						
						fields {
							field("Bill-to Customer No."; Code[20])
						}
						
						listPartPage {
							field("Bill-to Customer No.")
							field("Bill-to Customer No.")
						}
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertWarning(MdalPackage.eINSTANCE.pageField, MdalValidator.PAGE_FIELD_NAME_EXISTS)
	}

	@Test
	def void testLedgerEntryDuplicatePageFields() {
		// Tests method "checkDuplicatePageFields"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
				}
				
				document "Seminar Registration" {
					ShortName = "Sem. Reg.";
					
					header "Seminar Registration Header" {
						ShortName = "Sem. Reg. Header";
						StatusCaptions = ["Open", "Closed"];
					}
					
					line "Seminar Registration Line" {
						ShortName = "Sem. Reg. Line";
					}
				}
				
				ledgerEntry "Seminar Ledger Entry" {
					ShortName = "Sem. Ledger Entry";
					
					fields {
						field("Entry Type"; Enum["Registration"])
					}
					
					listPage {
						field("Entry Type")
						field("Entry Type")
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertWarning(MdalPackage.eINSTANCE.pageField, MdalValidator.PAGE_FIELD_NAME_EXISTS)
	}

}
