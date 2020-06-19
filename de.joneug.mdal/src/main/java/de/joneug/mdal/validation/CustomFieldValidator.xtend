package de.joneug.mdal.validation

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.MdalPackage
import org.eclipse.xtext.validation.Check

import static extension de.joneug.mdal.extensions.StringExtensions.*

class CustomFieldValidator extends AbstractMdalValidator {

	protected GeneratorManagement management = GeneratorManagement.getInstance()

	@Check
	def checkTableRelation(CustomField customField) {
		if(!customField.tableRelation.isNullOrEmpty) {
			if(!management.symbolReferences.exists[it.tables.exists[it.name == customField.tableRelation.unquote]]) {
				error(
					"Table '" + customField.tableRelation + "' is unknown.", MdalPackage.Literals.CUSTOM_FIELD__TABLE_RELATION,
					MdalValidator.CUSTOM_FIELD_UNKNOWN_TABLE
				)
			}
		}
	}

}
