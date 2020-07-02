package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.TemplateField
import de.joneug.mdal.mdal.TemplateType

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
		var name = entity.solution.constructObjectName(entity.name)
		if(name.length > 30) {
			name = entity.solution.constructObjectName(entity.shortName)
		}
		return name
	}
	
	static def getTableVariableName(Entity entity) {
		return entity.cleanedShortName
	}

	static def getCardPageName(Entity entity) {
		var name = entity.solution.constructObjectName(entity.name + ' Card')
		if(name.length > 30) {
			name = entity.solution.constructObjectName(entity.shortName + ' Card')
		}
		return name
	}

	static def getListPageName(Entity entity) {
		var name = entity.solution.constructObjectName(entity.name + ' List')
		if(name.length > 30) {
			name = entity.solution.constructObjectName(entity.shortName + ' List')
		}
		return name
	}
	
	static def getCustomFields(Entity entity) {
		return entity.fields.filter(CustomField)
	}

	static def getTemplateFields(Entity entity) {
		return entity.fields.filter(TemplateField)
	}
	
	static def <T extends TemplateType> hasTemplateOfType(Entity entity, Class<T> templateType) {
		entity.templateFields.exists[templateType.isInstance(it.type)]
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
	
	static def doGenerateFields(Entity entity) '''
		«FOR field : entity.fields»
			«IF field instanceof CustomField»
				«field.doGenerate»
			«ELSEIF field instanceof TemplateField »
				«field.doGenerate»
			«ENDIF»
		«ENDFOR»
	'''

}