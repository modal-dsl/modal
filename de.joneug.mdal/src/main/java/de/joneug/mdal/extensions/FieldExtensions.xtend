package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Field
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.TemplateField
import de.joneug.mdal.mdal.TypeOption

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.FieldTypeExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*
import static extension de.joneug.mdal.extensions.TemplateTypeExtensions.*

class FieldExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	def static Entity getEntity(Field field) {
		return field.getContainerOfType(Entity)
	}
	
	static def dispatch doGenerateTableField(TemplateField templateField) {
		return doGenerateTableField(templateField, null)
	}
	
	static def dispatch doGenerateTableField(CustomField customField) {
		return doGenerateTableField(customField, null)
	}
	
	static def dispatch doGenerateTableField(TemplateField templateField, IncludeField includeField) {
		return templateField.type.doGenerateTableFields(includeField)
	}
	
	static def dispatch doGenerateTableField(CustomField customField, IncludeField includeField) {
		var entity = customField.entity
		var fieldName = customField.name
		if(includeField !== null) {
			entity = includeField.getContainerOfType(Entity)
			fieldName = includeField.name
		}
		
		return '''
			field(«management.getNewFieldNo(entity)»; «fieldName.saveQuote»; «customField.type.doGenerate»)
			{
				Caption = '«fieldName»';
				««« Option
				«IF customField.type instanceof TypeOption»
					OptionCaption = '«FOR member : (customField.type as TypeOption).getMembers() SEPARATOR ','»«member»«ENDFOR»';
					OptionMembers = «FOR member : (customField.type as TypeOption).getMembers() SEPARATOR ','»"«member»"«ENDFOR»;
				«ENDIF»
				««« Table Relation
				«IF !customField.tableRelation.isNullOrEmpty»
					TableRelation = «customField.tableRelation.saveQuote»«IF !customField.tableRelationField.isNullOrEmpty».«customField.tableRelationField.saveQuote»«ENDIF»«IF !customField.whereConditionField.isNullOrEmpty» where(«customField.whereConditionField.saveQuote» = const(«customField.whereConditionConst.saveQuote»))«ENDIF»;
				«ENDIF»
			}
		'''
	}
	
	static def dispatch doGeneratePageField(CustomField customField) {
		return doGeneratePageField(customField, null)
	}
	
	static def dispatch doGeneratePageField(TemplateField templateField) {
		return doGeneratePageField(templateField, null)
	}
	
	static def dispatch doGeneratePageField(CustomField customField, IncludeField includeField) {
		var fieldName = customField.name
		if(includeField !== null) {
			fieldName = includeField.name
		}
		return '''
			field(«fieldName.saveQuote»; «fieldName.saveQuote»)
			{
				ApplicationArea = All;
			}
		'''
	}
	
	static def dispatch doGeneratePageField(TemplateField templateField, IncludeField includeField) {
		return templateField.type.doGeneratePageFields(includeField)
	}
	
}
