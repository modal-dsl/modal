package de.joneug.mdal.validation

import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.MdalPackage
import org.eclipse.xtext.validation.Check

import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*

class IncludeFieldValidator extends AbstractMdalValidator {

	@Check
	def checkEntityAndField(IncludeField includeField) {
		val entity = includeField.entityObject
		
		if(entity === null) {
			error("Entity '" + includeField.entity + "' is unknown.", MdalPackage.Literals.INCLUDE_FIELD__ENTITY, MdalValidator.INCLUDE_FIELD_UNKNOWN_ENTITY)
		} else if(!includeField.field.isNullOrEmpty && !entity.fields.exists[it.name == includeField.field]) {
			generateFieldUnknownError(includeField.field)
		}
	}

	def generateEntityUnknownError(String entityName) {
		error("Entity '" + entityName + "' is unknown.", MdalPackage.Literals.INCLUDE_FIELD__ENTITY, MdalValidator.INCLUDE_FIELD_UNKNOWN_ENTITY)
	}

	def generateFieldUnknownError(String fieldName) {
		error("Field '" + fieldName + "' is unknown.", MdalPackage.Literals.INCLUDE_FIELD__FIELD, MdalValidator.INCLUDE_FIELD_UNKNOWN_FIELD)
	}

}
