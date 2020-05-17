package de.joneug.mdal.tests

import com.google.inject.Inject
import de.joneug.mdal.mdal.Model
import de.joneug.mdal.tests.util.GeneratorContextStub
import org.eclipse.xtext.generator.IGenerator2
import org.eclipse.xtext.generator.InMemoryFileSystemAccess
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertTrue

import static extension de.joneug.mdal.tests.util.InMemoryFileSystemAccessExtensions.*
import static extension de.joneug.mdal.util.ObjectExtensions.*
import static org.junit.Assert.fail

@ExtendWith(InjectionExtension)
@InjectWith(MdalInjectorProvider)
class MdalGeneratorTest {
	
	@Inject
	ParseHelper<Model> parseHelper
	
	@Inject
	IGenerator2 generator
	
	InMemoryFileSystemAccess fsa
	
	@BeforeEach
    def void setUp() {
        fsa = new InMemoryFileSystemAccess()
    }
    
    @Test
	def void testMinimalModel() {
		doGenerate('''
	        extension "Seminar Module" {
	        	idRanges [50000]
	        }
        ''')
        
        val basePath = "seminar_module"
        
        checkFileContains(basePath + "/app.json", #['"id": "'])
        fail()
	}
	
	@Test
	def void testAppJson() {		
		doGenerate('''
	        extension "Seminar Module" {
	        	id "ddfc04f8-5bda-4e9c-9d84-89aeb970caf2"
	        	idRanges [50000, 50000..100000]
	        }
        ''')
        
        val basePath = "seminar_module"
        
        checkFileContents(basePath + "/app.json", '''
			{
				"id": "ddfc04f8-5bda-4e9c-9d84-89aeb970caf2",
				"name": "Seminar Module",
				"publisher": "Default publisher",
				"version": "1.0.0.0",
				"brief": "",
				"description": "",
				"privacyStatement": "",
				"EULA": "",
				"help": "",
				"url": "",
				"logo": "",
				"dependencies": [
					{
					"id": "63ca2fa4-4f03-4f2b-a480-172fef340d3f",
					"publisher": "Microsoft",
					"name": "System Application",
					"version": "16.0.0.0"
					},
					{
					"id": "437dbf0e-84ff-417a-965d-ed2bb9650972",
					"publisher": "Microsoft",
					"name": "Base Application",
					"version": "16.0.0.0"
					}
				],
				"screenshots": [],
				"platform": "",
				"idRanges": [
					{
					"from": 50100,
					"to": 50149
					}
				],
				"contextSensitiveHelpUrl": "https://SeminarModule.com/help/",
				"showMyCode": true,
				"runtime": "16.0.0.0"
			}
        ''')
	}
	
	def doGenerate(String modelString) {
		val model = parseHelper.parse(modelString)
		generator.doGenerate(model.eResource, fsa, new GeneratorContextStub)
	}
	
	def checkFileContents(String filePath, String expectedContent) {
		logInfo('''Checking contents of file at path "«filePath»" in default output.''')
		checkFileExists(filePath)
		logDebug(fsa.getFileInDefaultOutput(filePath))
		
		assertEquals(
			'''File at path "«filePath»" doesn't contain the expected content.''',
			expectedContent,
			fsa.getFileInDefaultOutput(filePath).toString
		)
	}
	
	def checkFileContains(String filePath, String[] expectedContents) {
		logInfo('''Checking contents of file at path "«filePath»" in default output.''')
		checkFileExists(filePath)
		logDebug(fsa.getFileInDefaultOutput(filePath))
		
		val fileContents = fsa.getFileInDefaultOutput(filePath).toString
		
		assertTrue(
			'''File at path "«filePath»" doesn't contain all expected contents."''',
			expectedContents.forall[fileContents.contains(it)]			
		)
	}
	
	def checkFileExists(String filePath) {
		assertTrue(
			'''File at path "«filePath»" doesn't exist."''',
			fsa.hasFileInDefaultOutput(filePath)
		)
	}
	
}
