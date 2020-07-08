package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Field
import de.joneug.mdal.mdal.TemplateField
import de.joneug.mdal.mdal.TypeOption

import static extension de.joneug.mdal.extensions.CustomFieldExtensions.*
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
		doGenerateTableField(templateField, templateField.type.field.entity)
	}
	
	static def dispatch doGenerateTableField(CustomField customField) {
		doGenerateTableField(customField, customField.entity)
	}
	
	static def dispatch doGenerateTableField(TemplateField templateField, Entity entity) {
		return templateField.type.doGenerateTableFields(entity)
	}
	
	static def dispatch doGenerateTableField(CustomField customField, Entity entity) {
		return doGenerateTableField(customField, customField.name, entity)
	}
	
	static def doGenerateTableField(CustomField customField, String filedName, Entity entity) '''
		field(«management.getNewFieldNo(entity)»; «filedName.saveQuote»; «customField.type.doGenerate»)
		{
			Caption = '«customField.inferredCaption»';
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
	
	static def dispatch doGeneratePageField(CustomField customField) '''
	field(«customField.name.saveQuote»; «customField.name.saveQuote»)
	{
		ApplicationArea = All;
	}
	'''
	
	static def dispatch doGeneratePageField(TemplateField templateField) {
		return templateField.type.doGeneratePageFields
	}
	
}
