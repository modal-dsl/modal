package de.joneug.mdal.validation

import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Master
import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.Supplemental
import de.joneug.mdal.mdal.TemplateDescription
import de.joneug.mdal.mdal.TemplateName
import org.eclipse.xtext.validation.AbstractDeclarativeValidator
import org.eclipse.xtext.validation.Check
import org.eclipse.xtext.validation.EValidatorRegistrar

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class EntityValidator extends AbstractDeclarativeValidator {

	override register(EValidatorRegistrar registrar) {}

	@Check
	def checkNamesAreUnique(Entity entity) {
		if(entity.getAllContentsOfTypeFromRoot(Entity).exists[it !== entity && it.name == entity.name]) {
			error(
				'''Entity with name «entity.name.saveQuote» already exists.''',
				MdalPackage.Literals.ENTITY__NAME,
				MdalValidator.ENTITY_NAME_EXISTS
			)
		}
	}

	@Check
	def checkHasNameOrDescription(Entity entity) {
		if(!(entity instanceof Master) && !(entity instanceof Supplemental)) {
			return
		}

		if(!entity.templateFields.exists[it.type instanceof TemplateDescription || it.type instanceof TemplateName]) {
			warning(
				'''Entity «entity.name.saveQuote» should have a name or description.''',
				MdalPackage.Literals.ENTITY__FIELDS,
				MdalValidator.ENTITY_NAME_DESCRIPTION
			)
		}
	}
	
	@Check
	def checkFieldNamesAreUnique(Entity entity) {
		entity.fields.forEach[field |
			if(entity.fields.exists[it !== field && it.name == field.name]) {
				error(
					'''Field with name «field.name.saveQuote» already exists in «entity.name.saveQuote».''',
					field,
					MdalPackage.Literals.FIELD__NAME,
					MdalValidator.FIELD_NAME_EXISTS
				)
			}
		]
	}

}
