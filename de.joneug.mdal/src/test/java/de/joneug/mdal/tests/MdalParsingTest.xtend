package de.joneug.mdal.tests

import com.google.inject.Inject
import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.Model
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static de.joneug.mdal.validation.IssueCodes.*
import static org.junit.Assert.assertNotNull
import static org.junit.Assert.assertTrue

@ExtendWith(InjectionExtension)
@InjectWith(MdalInjectorProvider)
class MdalParsingTest {
	
	@Inject
	ParseHelper<Model> parseHelper
	
	@Inject extension
	ValidationTestHelper
	
	@Test
	def void testCorrectModel() {
		val model = parseHelper.parse('''
			extension "Seminar Module" {
				idRanges [50000, 50000..100000]
			}
		''')

		assertNotNull(model)
		val errors = model.eResource.errors
		assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
	}
	
	@Test
	def void testIncorrectModel() {
		val model = parseHelper.parse('''
			extension "Seminar Module" {
				id "abcd"
				idRanges [50000]
			}
		''')

		assertNotNull(model)
		
		// Invalid ID
		model.assertWarning(MdalPackage.eINSTANCE.alExtension, INVALID_ID)
	}
	
}
