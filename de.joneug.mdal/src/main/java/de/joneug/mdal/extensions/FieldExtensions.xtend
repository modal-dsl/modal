package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Field

import static extension de.joneug.mdal.extensions.EObjectExtensions.*

class FieldExtensions {
	
	def static Entity getEntity(Field field) {
		return field.getContainerOfType(Entity)
	}
	
}
