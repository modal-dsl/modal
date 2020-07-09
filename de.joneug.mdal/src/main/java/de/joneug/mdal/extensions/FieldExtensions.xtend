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
import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*
import static extension de.joneug.mdal.extensions.TemplateTypeExtensions.*

class FieldExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	def static Entity getEntity(Field field) {
		return field.getContainerOfType(Entity)
	}
	
	static def dispatch doGenerateTableField(TemplateField templateField) {
		doGenerateTableField(templateField, null)
	}
	
	static def dispatch doGenerateTableField(CustomField customField) {
		doGenerateTableField(customField, null)
	}
	
	static def dispatch doGenerateTableField(TemplateField templateField, IncludeField includeField) {
		return templateField.type.doGenerateTableFields(includeField)
	}
	
	static def dispatch doGenerateTableField(CustomField customField, IncludeField includeField) {
		var entity = customField.entity
		var fieldName = customField.name
		var prefix = ''
		if(includeField !== null) {
			entity = includeField.getContainerOfType(Entity)
			prefix = includeField.entity.shortName + ' '
			fieldName = includeField.name
		}
		
		return '''
			field(«management.getNewFieldNo(entity)»; "«prefix»«fieldName»"; «customField.type.doGenerate»)
			{
				Caption = '«prefix»«fieldName»';
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
