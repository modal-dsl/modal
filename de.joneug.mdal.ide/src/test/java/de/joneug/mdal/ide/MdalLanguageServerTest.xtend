package de.joneug.mdal.ide

import de.joneug.mdal.util.ExampleContentGenerator
import org.eclipse.lsp4j.DiagnosticSeverity
import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.jupiter.api.Test

import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertFalse
import static org.junit.Assert.assertTrue

import static extension de.joneug.mdal.extensions.ObjectExtensions.*

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
		assertEquals(11, diagnostics.length)
		assertEquals(8, diagnostics.filter[it.severity == DiagnosticSeverity.Error].length)
		assertEquals(3, diagnostics.filter[it.severity == DiagnosticSeverity.Warning].length)
	}
	
	@Test
	def void testIncludeFieldEntityCompletion() {
    	testCompletion [
	        model = '''
	        	solution "Seminar Management" {
	        		master "Seminar" {
	        			ShortName = "Sem.";
	        			
	        			fields { 
	        				template("Description" ; Description)
	        				field("Minimum Participants"; Integer)
	        			}
	        		}
	        		
	        		supplemental "Seminar Room" {
	        			ShortName = "Sem. Room";
	        			
	        			fields {
	        				template("Name"; Name)
	        			}
	        		}
	        		
	        		supplemental "Instructor" {
	        			ShortName = "Inst.";
	        			
	        			fields {
	        				template("Name"; Name)
	        			}
	        		}
	        		
	        		document "Seminar Registration" {
	        			ShortName = "Sem. Reg.";
	        			
	        			header "Seminar Registration Header" {
	        				ShortName = "Seminar Reg. Header";
	        				StatusCaptions = ["Planning", "Registration", "Closed", "Canceled"];
	        			}
	        			
	        			line "Seminar Registration Line" {
	        				ShortName = "Seminar Reg. Line";
	        			}
	        		}
	        		
	        		ledgerEntry "Seminar Ledger Entry" {
	        			ShortName = "Sem. Ledger Entry";
	        			
	        			fields {
	        				include("Language Code"; "Seminar"."Language Code")
	        			}
	        		}
	        	}
	        '''
	        line = 43
	        column = 28
	        expectedCompletionItems = '''
	            Seminar Registration Header -> Seminar Registration Header [[«line», «column - 7»] .. [«line», «column»]]
	            Seminar Registration Line -> Seminar Registration Line [[«line», «column - 7»] .. [«line», «column»]]
	            Seminar Room -> Seminar Room [[«line», «column - 7»] .. [«line», «column»]]
	            Seminar -> Seminar [[«line», «column - 7»] .. [«line», «column»]]
	        '''
    	]
	}
	
	@Test
	def void testIncludeFieldFieldCompletion() {
		testCompletion [
	        model = '''
	        	solution "Seminar Management" {
	        		master "Seminar" {
	        			ShortName = "Sem.";
	        			
	        			fields { 
	        				template("Description" ; Description)
	        				field("Minimum Participants"; Integer)
	        			}
	        		}
	        		
	        		ledgerEntry "Seminar Ledger Entry" {
	        			ShortName = "Sem. Ledger Entry";
	        			
	        			fields {
	        				include("Language Code"; "Seminar".)
	        			}
	        		}
	        	}
	        '''
	        line = 14
	        column = 38
	        expectedCompletionItems = '''
	            "Description" -> "Description" [[«line», «column»] .. [«line», «column»]]
	            "Minimum Participants" -> "Minimum Participants" [[«line», «column»] .. [«line», «column»]]
	            "No." -> "No." [[«line», «column»] .. [«line», «column»]]
	            . -> . [[«line», «column - 1»] .. [«line», «column»]]
	        '''
    	]
	}
	
	@Test
	def void testHoverOnKeyword() {
		testHover[
			model = '''
				solution "Seminar Management" {}
			'''
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
			model = '''
				solution "Seminar Management" {
					master "Seminar" {
						ShortName = "Sem.";
						
						fields { 
							field("Picture"; Media)
							template("Description" ; Description)
							field("Duration Days"; Decimal)
							field("Minimum Participants"; Integer)
							field("Maximum Participants"; Integer)
							field("Language Code"; Code[10])
							field("Seminar Price"; Decimal)
						}
					}
				}
			'''
			line = 1
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
			model = '''
				solution "Seminar Management" {
					master "Seminar" {
						ShortName = "Sem.";
						
						fields { 
							field("Language Code"; Code[10]) {
								TableRelation = "Language1";
							}
						}
					}
				}
			'''
			expectedCodeActions = '''
				title : Add Description field.
				kind : quickfix
				command : 
				codes : e-name-description
				edit : changes :
				    MyModel.mdal : template("Description"; Description)
				                 [[5, 3] .. [5, 3]]
				documentChanges : 
				title : Add Name field.
				kind : quickfix
				command : 
				codes : e-name-description
				edit : changes :
				    MyModel.mdal : template("Name"; Name)
				                 [[5, 3] .. [5, 3]]
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
