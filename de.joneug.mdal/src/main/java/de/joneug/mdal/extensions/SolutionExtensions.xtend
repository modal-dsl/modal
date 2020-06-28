package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.generator.MdalGenerator
import de.joneug.mdal.mdal.Solution

import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.MasterExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*
import static extension de.joneug.mdal.generator.SetupGenerator.*

/**
 * This is an extension library for all {@link Solution objects}.
 */
class SolutionExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()

	static def getInferredPrefix(Solution solution) {
		if (solution.prefix.isNullOrEmpty) {
			return solution.master.shortName.toOnlyAlphabetic.toUpperCase
		} else {
			return solution.prefix
		}
	}

	static def String constructObjectName(Solution solution, String objectName) {
		return solution.inferredPrefix + ' ' + objectName
	}

	static def String constructTableFileName(String tableName) {
		return tableName.removeSpaces + '.Table.al'
	}

	static def String constructPageFileName(String pageName) {
		return pageName.removeSpaces + '.Page.al'
	}
	
	static def String constructCodeunitFileName(String pageName) {
		return pageName.removeSpaces + '.Codeunit.al'
	}
	
	static def String constructEnumFileName(String pageName) {
		return pageName.removeSpaces + '.Enum.al'
	}
	
	static def String constructEnumExtFileName(String pageName) {
		return pageName.removeSpaces + '.EnumExt.al'
	}
	
	static def String constructTableExtFileName(String pageName) {
		return pageName.removeSpaces + '.TableExt.al'
	}

	static def saveTable(Solution solution, String fileName, CharSequence fileContent) {
		management.generatorFsa.generateFile(MdalGenerator.TABLE_PATH + '/' + fileName, fileContent)
	}
	
	static def savePage(Solution solution, String fileName, CharSequence fileContent) {
		management.generatorFsa.generateFile(MdalGenerator.PAGE_PATH + '/' + fileName, fileContent)
	}
	
	static def saveCodeunit(Solution solution, String fileName, CharSequence fileContent) {
		management.generatorFsa.generateFile(MdalGenerator.CODEUNIT_PATH + '/' + fileName, fileContent)
	}
	
	static def saveEnum(Solution solution, String fileName, CharSequence fileContent) {
		management.generatorFsa.generateFile(MdalGenerator.ENUM_PATH + '/' + fileName, fileContent)
	}
	
	static def saveTableExt(Solution solution, String fileName, CharSequence fileContent) {
		management.generatorFsa.generateFile(MdalGenerator.TABLE_EXT_PATH + '/' + fileName, fileContent)
	}
	
	static def saveEnumExt(Solution solution, String fileName, CharSequence fileContent) {
		management.generatorFsa.generateFile(MdalGenerator.ENUM_EXT_PATH + '/' + fileName, fileContent)
	}

	/*
	 * Setup related extensions
	 */
	static def String getSetupTableName(Solution solution) {
		return solution.constructObjectName(solution.master.name + ' Setup')
	}

	static def String getSetupTableFileName(Solution solution) {
		return constructTableFileName(solution.setupTableName)
	}

	static def String getSetupTableVariableName(Solution solution) {
		return solution.master.cleanedShortName + 'Setup'
	}
	
	static def String getSetupPageName(Solution solution) {
		return solution.constructObjectName(solution.master.name + ' Setup')
	}

	static def String getSetupPageFileName(Solution solution) {
		return constructPageFileName(solution.getSetupPageName)
	}

	/*
	 * DocumentHeader related extensions
	 */
	static def String getDocumentHeaderTableName(Solution solution) {
		// TODO: Add implementation
		return 'SEM ' + 'Seminar Reg.' + ' Header'
	}
	
	static def String getDocumentHeaderTableFileName(Solution solution) {
		return constructTableFileName(solution.documentHeaderTableName)
	}
	
	static def String getDocumentHeaderTableVariableName(Solution solution) {
		return 'SeminarReg'
	}
	
	/*
	 * Generator extensions
	 */
	 
	static def doGenerate(Solution solution) {
		solution.logInfo('''Generating solution "«solution.name»"''')
		management.reset()
		management.readAppJson()
		management.readSymbolReferences()
		
		// Setup
		solution.logInfo("Generating setup files")
		solution.doGenerateSetup
		
		// Master
		solution.logInfo("Generating master files")
		solution.master.doGenerate
		
		// Supplemental
		
		// Document
		
		// Journal
	}

}
