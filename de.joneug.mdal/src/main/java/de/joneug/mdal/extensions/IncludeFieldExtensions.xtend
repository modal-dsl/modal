package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.DocumentHeader
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.LedgerEntry
import de.joneug.mdal.mdal.Master
import de.joneug.mdal.mdal.Supplemental

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
			// Master entity is automatically included in LedgerEntry and DocumentHeader
			if(includeField.entity instanceof Master && (containerEntity instanceof LedgerEntry || containerEntity instanceof DocumentHeader)) {
				return ''''''
			}
			// DocumentHeader entity is automatically included in LedgerEntry
			if(includeField.entity instanceof DocumentHeader && containerEntity instanceof LedgerEntry) {
				return ''''''
			}
			
			return '''
				field(«management.getNewFieldNo(containerEntity)»; «includeField.name.saveQuote»; Code[20])
				{
					Caption = '«includeField.name»';
					TableRelation = «includeField.entity.tableName.saveQuote»;
				}
			'''
		} else if(field === null && includeField.fieldName == 'Code') {
			// IncludeFields for Supplemental entities are handled in DocumentHeaderExtensions
			if(includeField.entity instanceof Supplemental && containerEntity instanceof DocumentHeader) {
				return ''''''
			}
			
			return '''
				field(«management.getNewFieldNo(containerEntity)»; «includeField.name.saveQuote»; Code[10])
				{
					Caption = '«includeField.name»';
					TableRelation = «includeField.entity.tableName.saveQuote»;
				}
			'''
		} else if(field instanceof CustomField) {
			return field.doGenerateTableField(includeField)
		} else {
			return includeField.field.doGenerateTableField(includeField)
		}
	}

	def static doGeneratePageField(IncludeField includeField) {
		return includeField.field.doGeneratePageField
	}

}
