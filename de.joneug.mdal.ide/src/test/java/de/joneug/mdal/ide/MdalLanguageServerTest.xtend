package de.joneug.mdal.ide

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.jupiter.api.Test

import static org.junit.Assert.assertTrue
import de.joneug.mdal.test.util.ExampleContentGenerator

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

		val file = 'hello.mdal'.writeFile("")
		file.open(ExampleContentGenerator.generateCorrectModel.toString)
		assertTrue(diagnostics.get(file).empty)
	}

}
