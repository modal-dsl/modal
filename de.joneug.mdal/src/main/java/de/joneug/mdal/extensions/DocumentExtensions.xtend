package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.Document
import org.eclipse.xtext.generator.IFileSystemAccess2

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class DocumentExtensions {
	
	static def getCleanedName(Document document) {
		return document.name.toOnlyAlphabetic.removeSpaces
	}
	
	static def getNamePosted(Document document) {
		return 'Posted ' + document.name
	}
	
	static def getShortNamePosted(Document document) {
		return 'Posted ' + document.shortName
	}
	
	static def getDocumentPageName(Document document) {
		var name = document.solution.constructObjectName(document.name)
		if(name.length > 30) {
			name = document.solution.constructObjectName(document.shortName)
		}
		return name
	}
	
	static def getDocumentPageNamePosted(Document document) {
		var name = document.solution.constructObjectName('Posted ' + document.name)
		if(name.length > 30) {
			name = document.solution.constructObjectName('Posted ' + document.shortName)
		}
		return name
	}
	
	static def getListPageName(Document document) {
		var name = document.solution.constructObjectName(document.name + ' List')
		if(name.length > 30) {
			name = document.solution.constructObjectName(document.shortName + ' List')
		}
		return name
	}
	
	static def getListPageNamePosted(Document document) {
		var name = document.solution.constructObjectName('Posted ' + document.name + ' List')
		if(name.length > 30) {
			name = document.solution.constructObjectName('Posted ' + document.shortName + ' List')
		}
		return name
	}
	
	static def getSubformPageName(Document document) {
		var name = document.solution.constructObjectName(document.name + ' Subform')
		if(name.length > 30) {
			name = document.solution.constructObjectName(document.shortName + ' Subform')
		}
		return name
	}
	
	static def getSubformPageNamePosted(Document document) {
		var name = document.solution.constructObjectName('Posted ' + document.name + ' Subform')
		if(name.length > 30) {
			name = document.solution.constructObjectName('Posted ' + document.shortName + ' Subform')
		}
		return name
	}
	
	static def void doGenerate(Document document, IFileSystemAccess2 fsa) {
		// Table
		//document.solution.saveTable(fsa, document.tableName, document.doGenerateTables(fsa))
		
		// List Page
		// Card Page
	}
	
	static def doGenerateTables(Document document, IFileSystemAccess2 fsa) {
		return ""
	}
	
	
}