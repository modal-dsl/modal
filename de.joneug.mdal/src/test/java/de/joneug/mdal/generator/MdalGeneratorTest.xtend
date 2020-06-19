package de.joneug.mdal.generator

import com.google.inject.Inject
import de.joneug.mdal.mdal.Model
import de.joneug.mdal.test.util.GeneratorContextStub
import de.joneug.mdal.tests.MdalInjectorProvider
import org.eclipse.xtext.generator.InMemoryFileSystemAccess
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static extension de.joneug.mdal.extensions.ObjectExtensions.*
import static extension de.joneug.mdal.extensions.InMemoryFileSystemAccessExtensions.*
import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertTrue
import de.joneug.mdal.test.util.ExampleContentGenerator

@ExtendWith(InjectionExtension)
@InjectWith(MdalInjectorProvider)
class MdalGeneratorTest {

	@Inject
	ParseHelper<Model> parseHelper

	MdalGenerator generator

	InMemoryFileSystemAccess fsa
	
	GeneratorManagement management

	@BeforeEach
	def void setUp() {
		this.generator = new MdalGenerator()
		this.fsa = new InMemoryFileSystemAccess()
		fsa.generateFile('app.json', ExampleContentGenerator.generateAppJson)
		this.management = GeneratorManagement.getInstance()
    	this.management.initializeFileSystemAccess(fsa)
	}

	@Test
	def void testDoGenerate() {
		doGenerate(ExampleContentGenerator.generateCorrectModel.toString)

		checkFileContains(
			"Table/SEMSeminar.Table.al",
			#[
				'table 123456701 "SEM Seminar"',
				'DrillDownPageID = "SEM Seminar List";',
				'field(10; "Duration Days"; Decimal)',
				'SeminarReg: Record "SEM Seminar Reg. Header";',
				'if NoSeriesMgt.SelectSeries(SemSetup."Seminar Nos.", OldSem."No. Series", "No. Series") then begin',
				'local procedure OnAfterGetSemSetup(var SemSetup: Record "SEM Seminar Setup")'
			]
		)
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
