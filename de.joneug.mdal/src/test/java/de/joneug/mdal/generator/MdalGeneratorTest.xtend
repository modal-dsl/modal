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
import org.junit.jupiter.api.Assertions
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
	def void testOnlyMaster() {
		doGenerate('''
			solution "Seminar Management" {
				Prefix = "SEM";
				master "Seminar" {
					ShortName = "Sem.";
					fields {
						template("Description"; Description)
					}
				}
			}
		''')
		checkFileExists("EnumExt/SEMCommentLineTableNameExt.EnumExt.al")
		checkFileExists("Page/SEMSeminarCard.Page.al")
		checkFileExists("Page/SEMSeminarList.Page.al")
		checkFileExists("Page/SEMSeminarSetup.Page.al")
		checkFileExists("Table/SEMSeminar.Table.al")
		checkFileExists("Table/SEMSeminarSetup.Table.al")
		checkFileExists("TableExt/SEMCommentLineExt.TableExt.al")
	}

	@Test
	def void testOnlySupplemental() {
		doGenerate('''
			solution "Seminar Management" {
			    Prefix = "SEM";
				supplemental "Seminar Room" {
					ShortName = "Sem. Room";
					fields {
						template("Name"; Name)
					}
				}
			}
		''')
		checkFileExists("Page/SEMSeminarRooms.Page.al")
		checkFileExists("Table/SEMSeminarRoom.Table.al")
	}
	
	@Test
	def void testMasterDocument() {
		doGenerate('''
			solution "Seminar Management" {
				Prefix = "SEM";
				master "Seminar" {
					ShortName = "Sem.";
					fields {
						template("Description"; Description)
					}
				}
				document "Seminar Registration" {
					ShortName = "Sem. Reg.";
					header "Seminar Registration Header" {
						ShortName = "Sem. Reg. Header";
						StatusCaptions = ["Planning", "Registration", "Closed", "Canceled"];
						fields {
							field("Starting Date"; Date)
						}
					}
					line "Seminar Registration Line" {
						ShortName = "Sem. Reg. Line";
						fields {
							field("Bill-to Customer No."; Code[20])
						}
					}
				}
			}
		''')
		checkFileExists("Codeunit/SEMNavigateEventSub.Codeunit.al")
		checkFileExists("Enum/SEMSeminarCommentDocumentType.Enum.al")
		checkFileExists("Enum/SEMSemRegStatus.Enum.al")
		checkFileExists("EnumExt/SEMCommentLineTableNameExt.EnumExt.al")
		checkFileExists("Page/SEMPostedSemReg.Page.al")
		checkFileExists("Page/SEMPostedSemRegList.Page.al")
		checkFileExists("Page/SEMPostedSemRegSubf.Page.al")
		checkFileExists("Page/SEMSeminarCard.Page.al")
		checkFileExists("Page/SEMSeminarCommentList.Page.al")
		checkFileExists("Page/SEMSeminarCommentSheet.Page.al")
		checkFileExists("Page/SEMSeminarList.Page.al")
		checkFileExists("Page/SEMSeminarRegistration.Page.al")
		checkFileExists("Page/SEMSeminarRegistrationList.Page.al")
		checkFileExists("Page/SEMSeminarSetup.Page.al")
		checkFileExists("Page/SEMSemRegSubf.Page.al")
		checkFileExists("PageExt/SEMSourceCodeSetupExt.PageExt.al")
		checkFileExists("Table/SEMPstdSemRegHeader.Table.al")
		checkFileExists("Table/SEMPstdSemRegLine.Table.al")
		checkFileExists("Table/SEMSeminar.Table.al")
		checkFileExists("Table/SEMSeminarCommentLine.Table.al")
		checkFileExists("Table/SEMSeminarSetup.Table.al")
		checkFileExists("Table/SEMSemRegHeader.Table.al")
		checkFileExists("Table/SEMSemRegLine.Table.al")
		checkFileExists("TableExt/SEMCommentLineExt.TableExt.al")
		checkFileExists("TableExt/SEMSourceCodeSetupExt.TableExt.al")
	}

	@Test
	def void testCorrectModel() {
		doGenerate(ExampleContentGenerator.generateCorrectModel.toString)

		// Tables
		checkFileContains(
			"Table/SEMSeminarSetup.Table.al",
			#[
				'table 123456700 "SEM Seminar Setup"',
				'field(1; "Primary Key"; Code[10])',
				'DrillDownPageID = "SEM Seminar Setup";',
				'AccessByPermission = TableData "SEM Pstd. Sem. Reg. Header" = R;'
			]
		)
		checkFileContains(
			"Table/SEMSeminar.Table.al",
			#[
				'table 123456702 "SEM Seminar"',
				'DataCaptionFields = Description, "No.";',
				'DrillDownPageID = "SEM Seminar List";',
				'field(2; "Description"; Text[100])',
				'field(5; "Duration Days"; Decimal)',
				'key(Key2; "Search Description") { }',
				'fieldgroup(DropDown; Description, "Description 2", "No.") { }',
				'fieldgroup(Brick; Description, "No.") { }',
				'SemRegHeader: Record "SEM Sem. Reg. Header";',
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

	@Test
	def void testIncorrectModel() {
		Assertions.assertThrows(IllegalArgumentException, [
			doGenerate(ExampleContentGenerator.generateModelWithErrors.toString)
		])
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

		expectedContents.forEach [
			assertTrue('''File at path "«filePath»" doesn't contain the expected content "«it»"".''',
				fileContents.contains(it))
		]
	}

	def checkFileExists(String filePath) {
		assertTrue(
			'''File at path "«filePath»" doesn't exist."''',
			fsa.hasFileInDefaultOutput(filePath)
		)
	}

}
