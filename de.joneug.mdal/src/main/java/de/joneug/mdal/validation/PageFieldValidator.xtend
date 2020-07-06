package de.joneug.mdal.validation

import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.PageField
import org.eclipse.xtext.validation.AbstractDeclarativeValidator
import org.eclipse.xtext.validation.Check
import org.eclipse.xtext.validation.EValidatorRegistrar

import static extension de.joneug.mdal.extensions.PageFieldExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class PageFieldValidator extends AbstractDeclarativeValidator {
	
	override register(EValidatorRegistrar registrar) {}
	
	@Check
	def checkFieldName(PageField pageField) {
		val fieldEither = pageField.fieldEither
		
		if(fieldEither === null || pageField.fieldEither.get === null) {
			error(
				'''Field «pageField.fieldName.saveQuote» is unknown.''',
				MdalPackage.Literals.PAGE_FIELD__FIELD_NAME,
				MdalValidator.PAGE_FIELD_UNKNOWN_FIELD
			)
		}
	}
	
}