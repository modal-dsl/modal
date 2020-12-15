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
class SolutionValidatorTest {

	@Inject
	ParseHelper<Model> parseHelper

	@Inject extension ValidationTestHelper

	@Test
	def void testDocumentMissingMaster() {
		// Tests method "checkRequiredEntites"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
			    Prefix = "SEM";
			    
			    document "Seminar Registration" {
			    	ShortName = "Sem. Reg.";
			    	header "Seminar Registration Header" {
			    		ShortName = "Sem. Reg. Header";
			    		StatusCaptions = ["Planning", "Registration", "Closed", "Canceled"];
			    		
			    		fields {
			    			field("Starting Date"; Date)
			    		}
			    	}
			    	
			    	line "Seminar Registration Line" {
			    		ShortName = "Sem. Reg. Line";
			    		
			    		fields {
			    			field("Bill-to Customer No."; Code[20])
			    		}
			    	}
			    }
			}
		''')
		assertNotNull(model)
		model.assertError(MdalPackage.eINSTANCE.solution, MdalValidator.DOCUMENT_NO_MASTER)
	}
	
	@Test
	def void testLedgerEntryMissingDocument() {
		// Tests method "checkRequiredEntites"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				ledgerEntry "Seminar Ledger Entry" {
					ShortName = "Sem. Ledger Entry";
					
					fields {
						field("Entry Type"; Enum["Registration"])
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertError(MdalPackage.eINSTANCE.solution, MdalValidator.LEDGER_ENTRY_NO_DOCUMENT)
	}

}
