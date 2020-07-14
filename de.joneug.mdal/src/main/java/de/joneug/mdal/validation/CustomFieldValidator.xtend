package de.joneug.mdal.validation

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.MdalPackage
import org.eclipse.xtext.validation.Check

import static extension de.joneug.mdal.extensions.StringExtensions.*
import org.eclipse.xtext.validation.EValidatorRegistrar
import org.eclipse.xtext.validation.AbstractDeclarativeValidator

class CustomFieldValidator extends AbstractDeclarativeValidator {

	protected GeneratorManagement management = GeneratorManagement.getInstance()

	override register(EValidatorRegistrar registrar) {}

	@Check
	def checkTableRelation(CustomField customField) {
		if(!customField.tableRelation.isNullOrEmpty) {
			if(!management.symbolReferences.exists[it.tables.exists[it.name == customField.tableRelation.unquote]]) {
				warning(
					'''Table «customField.tableRelation.saveQuote» is unknown.''',
					MdalPackage.Literals.CUSTOM_FIELD__TABLE_RELATION,
					MdalValidator.CUSTOM_FIELD_UNKNOWN_TABLE
				)
			}
		}
	}

}
