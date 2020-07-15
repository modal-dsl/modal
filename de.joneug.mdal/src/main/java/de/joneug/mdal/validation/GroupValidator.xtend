package de.joneug.mdal.validation

import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Group
import de.joneug.mdal.mdal.MdalPackage
import org.eclipse.xtext.validation.AbstractDeclarativeValidator
import org.eclipse.xtext.validation.Check
import org.eclipse.xtext.validation.EValidatorRegistrar

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class GroupValidator extends AbstractDeclarativeValidator {
	
	override register(EValidatorRegistrar registrar) {}
	
	@Check
	def checkNamesAreUnique(Group group) {
		val entity = group.getContainerOfType(Entity)
		
		if(entity.getAllContentsOfType(Group).exists[it !== group && it.name == group.name]) {
			error(
				'''Group with name «group.name.saveQuote» already exists.''',
				MdalPackage.Literals.GROUP__NAME,
				MdalValidator.GROUP_NAME_EXISTS
			)
		}
	}
	
}