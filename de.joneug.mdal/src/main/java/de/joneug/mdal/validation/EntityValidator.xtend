package de.joneug.mdal.validation

import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.MdalPackage
import org.eclipse.xtext.validation.Check

import static extension de.joneug.mdal.extensions.EObjectExtensions.*

class EntityValidator extends AbstractMdalValidator {

	@Check
	def checkNamesAreUnique(Entity entity) {
		if(entity.getAllContentsOfTypeFromRoot(Entity).exists[it !== entity && it.name == entity.name]) {
			error(
				"Entity with name '" + entity.name + "' already exists.",
				MdalPackage.Literals.ENTITY__NAME,
				MdalValidator.ENTITY_NAME_EXISTS
			)
		}
	}

}
