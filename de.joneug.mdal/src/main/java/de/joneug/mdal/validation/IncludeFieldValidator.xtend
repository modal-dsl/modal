package de.joneug.mdal.validation

import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.MdalPackage
import org.eclipse.xtext.validation.Check

import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*

class IncludeFieldValidator extends AbstractMdalValidator {

	@Check
	def checkEntityAndField(IncludeField includeField) {
		if(includeField.getEntityObject === null) {
			error("Entity '" + includeField.entity + "' is unknown.", MdalPackage.Literals.INCLUDE_FIELD__ENTITY, MdalValidator.INCLUDE_FIELD_UNKNOWN_ENTITY)
		} else if(!includeField.field.isNullOrEmpty && !includeField.getEntityObject.fields.exists[it.name == includeField.field]) {
			error("Field '" + includeField.field + "' is unknown.", MdalPackage.Literals.INCLUDE_FIELD__FIELD, MdalValidator.INCLUDE_FIELD_UNKNOWN_FIELD)
		}
	}

}
