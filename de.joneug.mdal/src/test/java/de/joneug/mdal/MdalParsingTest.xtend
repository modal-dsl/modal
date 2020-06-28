package de.joneug.mdal

import com.google.inject.Inject
import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.Model
import de.joneug.mdal.tests.MdalInjectorProvider
import de.joneug.mdal.util.ExampleContentGenerator
import de.joneug.mdal.validation.MdalValidator
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.junit.Assert.assertNotNull
import static org.junit.Assert.assertTrue

import static extension de.joneug.mdal.extensions.EObjectExtensions.*

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
		
		// Master should have name or description
		model.assertWarning(MdalPackage.eINSTANCE.master, MdalValidator.ENTITY_NAME_DESCRIPTION)
		
		// Unknown field
		model.assertError(MdalPackage.eINSTANCE.includeField, MdalValidator.INCLUDE_FIELD_UNKNOWN_FIELD)
		
		// Unknown table
		model.assertError(MdalPackage.eINSTANCE.customField, MdalValidator.CUSTOM_FIELD_UNKNOWN_TABLE)
		
		// Entity name already exists
		model.assertError(MdalPackage.eINSTANCE.documentHeader, MdalValidator.ENTITY_NAME_EXISTS)
		model.assertError(MdalPackage.eINSTANCE.documentLine, MdalValidator.ENTITY_NAME_EXISTS)
	}
	
}
