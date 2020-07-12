package de.joneug.mdal.generator

import com.google.inject.Inject
import de.joneug.mdal.mdal.Model
import de.joneug.mdal.test.util.GeneratorContextStub
import de.joneug.mdal.tests.MdalInjectorProvider
import de.joneug.mdal.util.ExampleContentGenerator
import org.eclipse.xtext.generator.InMemoryFileSystemAccess
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertTrue

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.InMemoryFileSystemAccessExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*

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

		// Tables
		checkFileContains(
			"Table/SEMSeminarSetup.Table.al",
			#[
				'table 123456700 "SEM Seminar Setup"',
				'field(1; "Primary Key"; Code[10])',
				'DrillDownPageID = "SEM Seminar Setup";',
				'AccessByPermission = TableData "SEM Pstd. Seminar Reg. Header" = R;'
			]
		)
		checkFileContains(
			"Table/SEMSeminar.Table.al",
			#[
				'table 123456702 "SEM Seminar"',
				'DataCaptionFields = Description, "No.";',
				'DrillDownPageID = "SEM Seminar List";',
				'field(3; "Description"; Text[100])',
				'field(6; "Duration Days"; Decimal)',
				'key(Key2; "Search Description") { }',
				'fieldgroup(DropDown; Description, "Description 2", "No.") { }',
				'fieldgroup(Brick; Description, "No.") { }',
				'SeminarRegHeader: Record "SEM Seminar Reg. Header";',
				'if NoSeriesMgt.SelectSeries(SemSetup."Seminar Nos.", OldSem."No. Series", "No. Series") then begin',
				'local procedure OnAfterGetSemSetup(var SemSetup: Record "SEM Seminar Setup")'
			]
		)
		
		// Pages
		checkFileContains(
			"Page/SEMSeminarSetup.Page.al",
			#[
				'page 123456700 "SEM Seminar Setup"',
				'SourceTable = "SEM Seminar Setup";',
				'group(General)',
				'field("Copy Comments"; "Copy Comments")',
				'group("Number Series")'
			]
		)
	}

	def doGenerate(String modelString) {
		val model = parseHelper.parse(modelString)
		logDebug(model.dump())
		generator.doGenerate(model.eResource, fsa, new GeneratorContextStub)
		logDebug(fsa.allFiles)
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
		
		expectedContents.forEach[
			assertTrue('''File at path "«filePath»" doesn't contain the expected content "«it»"".''', fileContents.contains(it))
		]
	}

	def checkFileExists(String filePath) {
		assertTrue(
			'''File at path "«filePath»" doesn't exist."''',
			fsa.hasFileInDefaultOutput(filePath)
		)
	}

}
