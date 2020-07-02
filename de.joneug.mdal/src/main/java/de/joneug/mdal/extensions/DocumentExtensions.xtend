package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.Document
import org.eclipse.xtext.generator.IFileSystemAccess2

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class DocumentExtensions {
	
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