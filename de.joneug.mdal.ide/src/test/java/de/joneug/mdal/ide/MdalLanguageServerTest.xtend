package de.joneug.mdal.ide

import de.joneug.mdal.util.ExampleContentGenerator
import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.jupiter.api.Test

import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertFalse
import static org.junit.Assert.assertTrue

import static extension de.joneug.mdal.extensions.ObjectExtensions.*
import org.eclipse.lsp4j.DiagnosticSeverity

class MdalLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("mdal")
	}

	@Test
	def void testInitialize() {
		val capabilities = initialize().capabilities
		assertTrue(capabilities.definitionProvider && capabilities.documentFormattingProvider)
	}

	@Test
	def void testCorrectModel() {
		initialize()

		val file = 'seminar.mdal'.writeFile("")
		file.open(ExampleContentGenerator.generateCorrectModel.toString)
		val diagnostics = diagnostics.get(file)
		assertTrue('''Unexpected errors: «diagnostics»''', diagnostics.empty)
	}
	
	@Test
	def void testIncorrectModel() {
		initialize()

		val file = 'seminar.mdal'.writeFile("")
		file.open(ExampleContentGenerator.generateModelWithErrors.toString)
		val diagnostics = diagnostics.get(file)
		assertFalse('Incorrect model should have errors', diagnostics.empty)
		logDebug(diagnostics)
		assertEquals(8, diagnostics.length)
		assertEquals(7, diagnostics.filter[it.severity == DiagnosticSeverity.Error].length)
		assertEquals(1, diagnostics.filter[it.severity == DiagnosticSeverity.Warning].length)
	}
	
	@Test
	def void testCompletion() {
    	testCompletion [
	        model = ExampleContentGenerator.generateCorrectModel.toString
	        line = 65
	        column = 44
	        expectedCompletionItems = '''
	            "Instructor" -> "Instructor" [[«line», «column»] .. [«line», «column»]]
	            "Seminar Registration Header" -> "Seminar Registration Header" [[«line», «column»] .. [«line», «column»]]
	            "Seminar Registration Line" -> "Seminar Registration Line" [[«line», «column»] .. [«line», «column»]]
	            "Seminar Room" -> "Seminar Room" [[«line», «column»] .. [«line», «column»]]
	            "Seminar" -> "Seminar" [[«line», «column»] .. [«line», «column»]]
	            . -> . [[«line», «column»] .. [«line», «column»]]
	        '''
    	]
	}
	
	@Test
	def void testHoverOnKeyword() {
		testHover[
			model = ExampleContentGenerator.generateCorrectModel.toString
			line = 0
			column = 0
			expectedHover = '''
				[[«line», «column»] .. [«line», «column + 8»]]
				kind: markdown
				value: The `solution` keyword starts a solution definition.
			'''
		]
	}
	
	@Test
	def void testHoverOnEntity() {
		testHover[
			model = ExampleContentGenerator.generateCorrectModel.toString
			line = 3
			column = 1
			expectedHover = '''
				[[«line», «column»] .. [«line», «column + 6»]]
				kind: markdown
				value: ```mdal
				master Seminar
				
				Picture                            Media
				Description                        template
				"Duration Days"                    Decimal
				"Minimum Participants"             Integer
				"Maximum Participants"             Integer
				"Language Code"                    Code[10]
				"Seminar Price"                    Decimal
				```
			'''
		]
	}
	
	@Test
	def void testCodeAction() {
		testCodeAction[
			model = ExampleContentGenerator.generateModelWithErrors.toString
			expectedCodeActions = '''
				title : Add Description field.
				kind : quickfix
				command : 
				codes : e-name-description
				edit : changes :
				    MyModel.mdal : template("Description"; Description)
				                 [[7, 3] .. [7, 3]]
				documentChanges : 
				title : Add Name field.
				kind : quickfix
				command : 
				codes : e-name-description
				edit : changes :
				    MyModel.mdal : template("Name"; Name)
				                 [[7, 3] .. [7, 3]]
				documentChanges : 
				title : Load symbol references.
				kind : quickfix
				command : Command [
				  title = "Load symbol references."
				  command = "mdal.loadSymbolReferences.proxy"
				  arguments = null
				]
				codes : cf-unknown-table
				edit : 
			'''
		]
	}

}
