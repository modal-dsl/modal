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
class IncludeFieldValidatorTest {

	@Inject
	ParseHelper<Model> parseHelper

	@Inject extension ValidationTestHelper

	@Test
	def void testEntityUnknown() {
		// Tests method "checkEntityAndField"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
					
					fields {
						template("Description"; Description)
					}
				}
				
				document "Seminar Registration" {
					ShortName = "Sem. Reg.";
					
					header "Seminar Registration Header" {
						ShortName = "Sem. Reg. Header";
						StatusCaptions = ["Open", "Closed"];
						
						fields {
							include("Description"; "Seminar1"."Description")
						}
					}
					
					line "Seminar Registration Line" {
						ShortName = "Sem. Reg. Line";
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertError(MdalPackage.eINSTANCE.includeField, MdalValidator.INCLUDE_FIELD_UNKNOWN_ENTITY)
	}

	@Test
	def void testFieldUnknown() {
		// Tests method "checkEntityAndField"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
					
					fields {
						template("Description"; Description)
					}
				}
				
				document "Seminar Registration" {
					ShortName = "Sem. Reg.";
					
					header "Seminar Registration Header" {
						ShortName = "Sem. Reg. Header";
						StatusCaptions = ["Open", "Closed"];
						
						fields {
							include("Description"; "Seminar"."Description1")
						}
					}
					
					line "Seminar Registration Line" {
						ShortName = "Sem. Reg. Line";
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertError(MdalPackage.eINSTANCE.includeField, MdalValidator.INCLUDE_FIELD_UNKNOWN_FIELD)
	}

}
