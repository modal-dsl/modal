package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.TemplateDimensions
import de.joneug.mdal.mdal.TemplateField
import org.eclipse.xtext.generator.IFileSystemAccess2

import static extension de.joneug.mdal.extensions.CustomFieldExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*
import static extension de.joneug.mdal.extensions.TemplateFieldExtensions.*

class EntityExtensions {
	
	static def getCleanedName(Entity entity) {
		return entity.name.toOnlyAlphabetic.removeSpaces
	}
	
	static def getCleanedShortName(Entity entity) {
		return entity.shortName.toOnlyAlphabetic.removeSpaces
	}

	static def getTableName(Entity entity) {
		return entity.solution.constructObjectName(entity.name)
	}

	static def getTableFileName(Entity entity) {
		return constructTableFileName(entity.tableName)
	}
	
	static def getTableVariableName(Entity entity) {
		return entity.cleanedShortName
	}

	static def getCardPageName(Entity entity) {
		return entity.solution.constructObjectName(entity.name + ' Card')
	}

	static def getListPageName(Entity entity) {
		return entity.solution.constructObjectName(entity.name + ' List')
	}
	
	static def getCustomFields(Entity entity) {
		return entity.fields.filter(CustomField)
	}

	static def getTemplateFields(Entity entity) {
		return entity.fields.filter(TemplateField)
	}
	
	static def addDimensions(Entity entity) {
		entity.templateFields.exists[it.type instanceof TemplateDimensions]
	}
	
	static def getDataCaptionFields(Entity entity) {
		val fields = newArrayList
		entity.templateFields.forEach[fields.addAll(it.dataCaptionFields)]
		return fields
	}
	
	static def getKeys(Entity entity) {
		val _keys = newArrayList
		entity.templateFields.forEach[_keys.addAll(it.keys)]
		return _keys
	}
	
	static def getFieldgroupDropDown(Entity entity) {
		val fields = newArrayList
		entity.templateFields.forEach[fields.addAll(it.fieldGroupBrick)]
		return fields
	}
	
	static def getFieldGroupBrick(Entity entity) {
		val fields = newArrayList
		entity.templateFields.forEach[fields.addAll(it.fieldgroupDropDown)]
		return fields
	}
	
	static def doGenerateFields(Entity entity, IFileSystemAccess2 fsa) '''
		«FOR field : entity.fields»
			«IF field instanceof CustomField»
				«field.doGenerate(fsa)»
			«ELSEIF field instanceof TemplateField »
				«field.doGenerate»
			«ENDIF»
		«ENDFOR»
	'''

}