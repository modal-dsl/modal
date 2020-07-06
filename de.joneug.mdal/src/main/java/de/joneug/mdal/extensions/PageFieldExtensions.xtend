package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Field
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.PageField
import de.joneug.mdal.util.MdalEither

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.FieldExtensions.*
import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*

class PageFieldExtensions {
	
	def static getEntity(PageField pageField) {
		return pageField.getContainerOfType(Entity)
	}
	
	def static MdalEither<Field, IncludeField> getFieldEither(PageField pageField) {
		val entity = pageField.entity
		
		if(entity === null) {
			return null
		}
		
		val filteredFields = entity.fields.filter[it.name == pageField.fieldName]
		if(filteredFields.length > 0) {
			return MdalEither.<Field, IncludeField>forLeft(filteredFields.get(0))
		}
		
		val filteredIncludeFields = entity.inferredIncludeFields.filter[it.name == pageField.fieldName]
		if(filteredIncludeFields.length > 0) {
			return MdalEither.<Field, IncludeField>forRight(filteredIncludeFields.get(0))
		}
		
		return null
	}
	
	def static doGenerate(PageField pageField) {
		val either = pageField.fieldEither
		
		if(either.isLeft) {
			return either.getLeft.doGeneratePageField
		} else {
			return either.getRight.doGeneratePageField
		}
	}
	
}