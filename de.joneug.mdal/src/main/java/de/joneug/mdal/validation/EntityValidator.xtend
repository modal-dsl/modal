package de.joneug.mdal.validation

import de.joneug.mdal.mdal.DocumentHeader
import de.joneug.mdal.mdal.DocumentLine
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.LedgerEntry
import de.joneug.mdal.mdal.Master
import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.PageField
import de.joneug.mdal.mdal.Supplemental
import de.joneug.mdal.mdal.TemplateDescription
import de.joneug.mdal.mdal.TemplateName
import java.util.List
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
		val fieldNamesWithError = <String>newArrayList
		
		entity.fields.forEach[field |
			if(!fieldNamesWithError.contains(field.name)) {
				// Duplicates within regular fields
				if(entity.fields.exists[it !== field && it.name == field.name]) {
					error(
						'''Field with name «field.name.saveQuote» already exists in «entity.name.saveQuote».''',
						field,
						MdalPackage.Literals.FIELD__NAME,
						MdalValidator.FIELD_NAME_EXISTS
					)
					fieldNamesWithError.add(field.name)
				}
				// Duplicates between regular fields and include fields
				if (entity.inferredIncludeFields.exists[it.name == field.name]) {
					error(
						'''Field with name «field.name.saveQuote» already exists in «entity.name.saveQuote».''',
						field,
						MdalPackage.Literals.FIELD__NAME,
						MdalValidator.FIELD_NAME_EXISTS
					)
					fieldNamesWithError.add(field.name)
				}
			}
		]
		
		entity.inferredIncludeFields.forEach[includeField |
			if(!fieldNamesWithError.contains(includeField.name)) {
				// Duplicates within include fields
				if (entity.inferredIncludeFields.exists[it !== includeField && it.name == includeField.name]) {
					error(
						'''Field with name «includeField.name.saveQuote» already exists in «entity.name.saveQuote».''',
						includeField,
						MdalPackage.Literals.INCLUDE_FIELD__NAME,
						MdalValidator.FIELD_NAME_EXISTS
					)
					fieldNamesWithError.add(includeField.name)
				}
			}
		]
	}
	
	@Check
	def checkDuplicatePageFields(Entity entity) {
		if(entity instanceof Master) {
			checkDuplicatePageFields(entity.listPageFields)
			checkDuplicatePageFields(entity.cardPageGroups.map[it.pageFields].flatten.toList)
		} else if(entity instanceof Supplemental) {
			checkDuplicatePageFields(entity.listPageFields)
		} else if(entity instanceof DocumentHeader) {
			checkDuplicatePageFields(entity.listPageFields)
			checkDuplicatePageFields(entity.documentPageGroups.map[it.pageFields].flatten.toList)
		} else if(entity instanceof DocumentLine) {
			checkDuplicatePageFields(entity.listPartPageFields)
		} else if(entity instanceof LedgerEntry) {
			checkDuplicatePageFields(entity.listPageFields)
		}
	}

	def checkDuplicatePageFields(List<PageField> pageFields) {
		val pageFieldNamesWithError = <String>newArrayList
		
		pageFields.forEach[pageField |
			if(!pageFieldNamesWithError.contains(pageField.fieldName)) {
				if (pageFields.exists[it !== pageField && it.fieldName == pageField.fieldName]) {
					warning(
						'''Field with name «pageField.fieldName.saveQuote» is already included on the page.''',
						pageField,
						MdalPackage.Literals.PAGE_FIELD__FIELD_NAME,
						MdalValidator.PAGE_FIELD_NAME_EXISTS
					)
					pageFieldNamesWithError.add(pageField.fieldName)
				}
			}
		]
	}

}
