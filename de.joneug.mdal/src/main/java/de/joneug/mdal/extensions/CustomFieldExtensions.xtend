package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.TypeEnum

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class CustomFieldExtensions {
	
	static def getEnumName(CustomField customField) {
		if(!(customField.type instanceof TypeEnum)) {
			throw new IllegalArgumentException("CustomField must be of type TypeEnum")
		}
		
		return customField.solution.constructObjectName(customField.name)
	}

	static def getEnumFileName(CustomField customField) {
		if(!(customField.type instanceof TypeEnum)) {
			throw new IllegalArgumentException("CustomField must be of type TypeEnum")
		}
		return customField.enumName.toEnumFileName
	}

}
