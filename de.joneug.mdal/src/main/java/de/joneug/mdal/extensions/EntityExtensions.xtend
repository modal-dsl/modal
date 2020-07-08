package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.DocumentHeader
import de.joneug.mdal.mdal.DocumentLine
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Group
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.LedgerEntry
import de.joneug.mdal.mdal.Master
import de.joneug.mdal.mdal.PageField
import de.joneug.mdal.mdal.Supplemental
import de.joneug.mdal.mdal.TemplateField
import de.joneug.mdal.mdal.TemplateType
import java.util.List

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.FieldExtensions.*
import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
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
	
	static def getInferredIncludeFields(Entity entity) {
		var List<IncludeField> includeFields = <IncludeField>newArrayList
		
		if(entity instanceof DocumentHeader) {
			includeFields = entity.includeFields
		} else if(entity instanceof DocumentLine) {
			includeFields = entity.includeFields
		} else if(entity instanceof LedgerEntry) {
			includeFields = entity.includeFields
		}
		
		return includeFields
	}
	
	static def List<String> getInferredFieldNames(Entity entity) {
		var fieldNames = <String>newArrayList
		fieldNames.addAll(entity.fields.map[it.name])
		
		// Add static fields
		if(entity instanceof Master) {
			fieldNames.add('No.')
		} else if(entity instanceof Supplemental) {
			fieldNames.add('Code')
		} else if(entity instanceof DocumentHeader) {
			fieldNames.add('No.')
		}
		
		return fieldNames
	}
	
	static def getInferredGroups(Entity entity) {
		var List<Group> groups = <Group>newArrayList
		
		if(entity instanceof Master) {
			groups = entity.cardPageGroups
		} else if(entity instanceof DocumentHeader) {
			groups = entity.documentPageGroups
		}
		
		return groups
	}
	
	static def getGroupsExceptGeneral(Entity entity) {
		return entity.inferredGroups.filter[it.name != 'General']
	}
	
	static def getPageFieldsInGroup(Entity entity, String groupName) {		
		val filteredGroups = entity.inferredGroups.filter[it.name == groupName]
		
		if(filteredGroups.length == 0) {
			return <PageField>newArrayList
		} else {
			return filteredGroups.get(0).pageFields
		}
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
	
	static def doGenerateTableFields(Entity entity) '''
		«FOR field : entity.fields»
			«field.doGenerateTableField»
		«ENDFOR»
		«FOR includeField : entity.inferredIncludeFields»
			«includeField.doGenerateTableField»
		«ENDFOR»
	'''

}