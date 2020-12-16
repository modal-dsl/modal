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
class CustomFieldValidatorTest {

	@Inject
	ParseHelper<Model> parseHelper

	@Inject extension ValidationTestHelper

	@Test
	def void testUnknownTableRelation() {
		// Tests method "checkTableRelation"
		val model = parseHelper.parse('''
			solution "Seminar Management" {
				Prefix = "SEM";
				
				master "Seminar" {
					ShortName = "Sem.";
					
					fields {
						field("Language Code"; Code[10]) {
							TableRelation = "Language1";
						}
					}
				}
			}
		''')
		assertNotNull(model)
		model.assertWarning(MdalPackage.eINSTANCE.customField, MdalValidator.CUSTOM_FIELD_UNKNOWN_TABLE)
	}

}
