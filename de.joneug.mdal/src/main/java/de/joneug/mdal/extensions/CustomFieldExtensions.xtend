package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.TypeEnum
import de.joneug.mdal.mdal.TypeOption

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.FieldExtensions.*
import static extension de.joneug.mdal.extensions.FieldTypeExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class CustomFieldExtensions {

	static GeneratorManagement management = GeneratorManagement.getInstance()
	
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
	
	static def getInferredCaption(CustomField customField) {
		if(customField.caption.isNullOrEmpty) {
			return customField.name			
		} else {
			return customField.caption
		}
	}

	static def doGenerate(CustomField customField) '''
		field(«management.getNewFieldNo(customField.entity)»; "«customField.getName()»"; «customField.type.doGenerate»)
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

}
