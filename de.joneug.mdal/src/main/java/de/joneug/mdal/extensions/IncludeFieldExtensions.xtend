package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.IncludeField

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.FieldExtensions.*

class IncludeFieldExtensions {

	def static Entity getEntity(IncludeField includeField) {
		for (entity : includeField.getAllContentsOfTypeFromRoot(Entity)) {
			if(entity.name == includeField.entityName) {
				return entity
			}
		}

		return null
	}
	
	def static getField(IncludeField includeField) {
		val matchingFields = includeField.entity.fields.filter[it.name == includeField.fieldName]
		
		if(matchingFields.empty) {
			return null
		} else {
			return matchingFields.get(0)
		}
	}
	
	def static doGenerateTableField(IncludeField includeField) {
		return includeField.field.doGenerateTableField
	}

	def static doGeneratePageField(IncludeField includeField) {
		return includeField.field.doGeneratePageField
	}

}
