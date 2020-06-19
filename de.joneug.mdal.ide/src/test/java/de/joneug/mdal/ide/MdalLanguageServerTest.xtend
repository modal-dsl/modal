package de.joneug.mdal.ide

import de.joneug.mdal.ide.test.util.ExampleContentGenerator
import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.jupiter.api.Test

import static org.junit.Assert.assertTrue

class MdalLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("mdal")
	}

	@Test
	def void testInitialize() {
		val capabilities = initialize().capabilities
		print(capabilities)
		assertTrue(capabilities.definitionProvider && capabilities.documentFormattingProvider)
	}

	@Test
	def void testCorrectModel() {
		initialize()

		val file = 'seminar.mdal'.writeFile("")
		file.open(ExampleContentGenerator.generateCorrectModel.toString)
		assertTrue(diagnostics.get(file).empty)
	}

}
