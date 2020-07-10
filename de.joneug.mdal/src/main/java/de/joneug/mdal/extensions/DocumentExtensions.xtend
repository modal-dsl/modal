package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.Document

import static extension de.joneug.mdal.extensions.DocumentHeaderExtensions.*
import static extension de.joneug.mdal.extensions.DocumentLineExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class DocumentExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
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
	
	static def getStatusEnumName(Document document) {
		var name = document.solution.constructObjectName(document.name + ' Status')
		if(name.length > 30) {
			name = document.solution.constructObjectName(document.shortName + ' Status')
		}
		
		return name
	}
	
	static def getInitialStatus(Document document) {
		return document.header.statusCaptions.get(0)
	}
	
	static def codeunitNamePost(Document document) {
		val master = document.solution.master
		var name = document.solution.constructObjectName(master.name + '-Post')
		if(name.length > 30) {
			name = document.solution.constructObjectName(master.shortName + '-Post')
		}
		
		return name
	}
	
	static def codeunitNamePostYesNo(Document document) {
		val master = document.solution.master
		var name = document.solution.constructObjectName(master.name + '-Post (Yes/No)')
		if(name.length > 30) {
			name = document.solution.constructObjectName(master.shortName + '-Post (Yes/No)')
		}
		
		return name
	}
	
	static def codeunitVariableNamePostYesNo(Document document) {
		return document.codeunitNamePostYesNo.clean
	}
	
	static def codeunitNameJnlCheckLine(Document document) {
		val master = document.solution.master
		var name = document.solution.constructObjectName(master.name + ' Jnl.-Check Line')
		if(name.length > 30) {
			name = document.solution.constructObjectName(master.shortName + ' Jnl.-Check Line')
		}
		
		return name
	}
	
	static def codeunitNameJnlPostLine(Document document) {
		val master = document.solution.master
		var name = document.solution.constructObjectName(master.name + ' Jnl.-Post Line')
		if(name.length > 30) {
			name = document.solution.constructObjectName(master.shortName + ' Jnl.-Post Line')
		}
		
		return name
	}
	
	static def void doGenerate(Document document) {
		document.saveEnum(document.statusEnumName, document.doGenerateStatusEnum)
		document.header.doGenerate
		document.line.doGenerate
	}
	
	static def doGenerateStatusEnum(Document document) '''
		enum «management.newEnumNo» «document.statusEnumName.saveQuote»
		{
		    Extensible = true;
		    AssignmentCompatibility = true;
			
			«FOR statusCaption : document.header.statusCaptions»
				value(«management.getNewFieldNo(document)»; «statusCaption.saveQuote») { Caption = '«statusCaption»'; }
			«ENDFOR»
		}
	'''
	
}