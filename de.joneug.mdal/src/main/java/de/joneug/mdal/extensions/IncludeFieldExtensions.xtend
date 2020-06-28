package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.IncludeField

import static extension de.joneug.mdal.extensions.EObjectExtensions.*

class IncludeFieldExtensions {

	def static Entity getEntity(IncludeField includeField) {
		for (entity : includeField.getAllContentsOfTypeFromRoot(Entity)) {
			if(entity.name == includeField.entityName) {
				return entity
			}
		}

		return null
	}

}
