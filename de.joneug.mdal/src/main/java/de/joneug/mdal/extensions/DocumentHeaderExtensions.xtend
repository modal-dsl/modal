package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.DocumentHeader

import static extension de.joneug.mdal.extensions.StringExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*

class DocumentHeaderExtensions {
	
	static def getNamePosted(DocumentHeader header) {
		return 'Posted ' + header.name
	}
	
	static def getShortNamePosted(DocumentHeader header) {
		return 'Posted ' + header.shortName
	}
	
	static def getCleanedNamePosted(DocumentHeader header) {
		return header.namePosted.toOnlyAlphabetic.removeSpaces
	}
	
	static def getCleanedShortNamePosted(DocumentHeader header) {
		return header.shortNamePosted.toOnlyAlphabetic.removeSpaces
	}

	static def getTableNamePosted(DocumentHeader header) {
		var name = header.solution.constructObjectName(header.namePosted)
		if(name.length > 30) {
			name = header.solution.constructObjectName(header.shortNamePosted)
		}
		return name
	}
	
	static def getTableVariableNamePosted(DocumentHeader header) {
		return header.cleanedShortNamePosted
	}
	
}