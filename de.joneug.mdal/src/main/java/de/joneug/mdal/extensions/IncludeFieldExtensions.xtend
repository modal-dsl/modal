package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.IncludeField

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.FieldExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class IncludeFieldExtensions {

	static GeneratorManagement management = GeneratorManagement.getInstance()

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
	
	def static CharSequence doGenerateTableField(IncludeField includeField) {
		val containerEntity = includeField.getContainerOfType(Entity)
		val field = includeField.field
		
		if(field === null && includeField.fieldName == 'No.') {
			return '''
				field(«management.getNewFieldNo(containerEntity)»; «includeField.name.saveQuote»; Code[20])
				{
					Caption = '«includeField.name»';
					TableRelation = «includeField.entity.tableName.saveQuote»;
				}
			'''
		} else if(field === null && includeField.fieldName == 'Code') {
			return '''
				field(«management.getNewFieldNo(containerEntity)»; «includeField.name.saveQuote»; Code[10])
				{
					Caption = '«includeField.name»';
					TableRelation = «includeField.entity.tableName.saveQuote»;
				}
			'''
		} else if(field instanceof CustomField) {
			return field.doGenerateTableField(includeField.name, containerEntity)
		} else {
			return includeField.field.doGenerateTableField(containerEntity)
		}
	}

	def static doGeneratePageField(IncludeField includeField) {
		return includeField.field.doGeneratePageField
	}

}
