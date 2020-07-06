package de.joneug.mdal.validation

import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.MdalPackage
import org.eclipse.xtext.validation.AbstractDeclarativeValidator
import org.eclipse.xtext.validation.Check
import org.eclipse.xtext.validation.EValidatorRegistrar

import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class IncludeFieldValidator extends AbstractDeclarativeValidator {
	
	override register(EValidatorRegistrar registrar) {}

	@Check
	def checkEntityAndField(IncludeField includeField) {
		val entity = includeField.entity
		
		if(entity === null) {
			error(
				'''Entity «includeField.entityName.saveQuote» is unknown.''',
				MdalPackage.Literals.INCLUDE_FIELD__ENTITY_NAME,
				MdalValidator.INCLUDE_FIELD_UNKNOWN_ENTITY
			)
		} else if(!includeField.fieldName.isNullOrEmpty && !entity.fields.exists[it.name == includeField.fieldName]) {
			error(
				'''Field «includeField.entityName.saveQuote».«includeField.fieldName.saveQuote» is unknown.''',
				MdalPackage.Literals.INCLUDE_FIELD__FIELD_NAME,
				MdalValidator.INCLUDE_FIELD_UNKNOWN_FIELD
			)
		}
	}

}
