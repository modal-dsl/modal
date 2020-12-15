package de.joneug.mdal

import com.google.inject.Inject
import de.joneug.mdal.mdal.Model
import de.joneug.mdal.tests.MdalInjectorProvider
import de.joneug.mdal.util.ExampleContentGenerator
import org.eclipse.xtext.diagnostics.Severity
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertFalse
import static org.junit.Assert.assertNotNull
import static org.junit.Assert.assertTrue

import static extension de.joneug.mdal.extensions.ObjectExtensions.*

@ExtendWith(InjectionExtension)
@InjectWith(MdalInjectorProvider)
class MdalParsingTest {

	@Inject
	ParseHelper<Model> parseHelper

	@Inject extension ValidationTestHelper

	@Test
	def void testMinimalModel() {
		val model = parseHelper.parse(ExampleContentGenerator.generateMinimalModel)

		assertNotNull(model)
		val errors = model.eResource.errors
		assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		model.assertNoIssues
	}

	@Test
	def void testCorrectModel() {
		val model = parseHelper.parse(ExampleContentGenerator.generateCorrectModel)

		assertNotNull(model)
		val errors = model.eResource.errors
		assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		model.assertNoIssues
	}

	@Test
	def void testIncorrectModel() {
		val model = parseHelper.parse("abc")
		assertFalse(model.eResource.errors.isEmpty)
	}

	@Test
	def void testModelWithIssues() {
		val model = parseHelper.parse(ExampleContentGenerator.generateModelWithErrors)
		assertNotNull(model)

		// Validate number of issues
		val issues = model.validate
		logDebug(issues)
		assertEquals(11, issues.length)
		assertEquals(8, issues.filter[it.severity == Severity.ERROR].length)
		assertEquals(3, issues.filter[it.severity == Severity.WARNING].length)
	}

}
