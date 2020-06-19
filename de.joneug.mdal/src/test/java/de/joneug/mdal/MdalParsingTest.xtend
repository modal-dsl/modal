package de.joneug.mdal

import com.google.inject.Inject
import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.Model
import de.joneug.mdal.test.util.ExampleContentGenerator
import de.joneug.mdal.tests.MdalInjectorProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.junit.Assert.assertNotNull
import static org.junit.Assert.assertTrue

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import de.joneug.mdal.validation.MdalValidator

@ExtendWith(InjectionExtension)
@InjectWith(MdalInjectorProvider)
class MdalParsingTest {
	
	@Inject
	ParseHelper<Model> parseHelper
	
	@Inject extension
	ValidationTestHelper

	@Test
	def void testCorrectModel() {
		val model = parseHelper.parse(ExampleContentGenerator.generateCorrectModel)
		
		assertNotNull(model)
		print(model.dump())

		val errors = model.eResource.errors
		assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
	}

	@Test
	def void testIncorrectModel() {
		val model = parseHelper.parse(ExampleContentGenerator.generateModelWithErrors)

		assertNotNull(model)
		
		// Unknown field
		model.assertError(MdalPackage.eINSTANCE.includeField, MdalValidator.INCLUDE_FIELD_UNKNOWN_FIELD)
	}
	
}
