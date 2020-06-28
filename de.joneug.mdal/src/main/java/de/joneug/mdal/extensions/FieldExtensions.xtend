package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.Entity
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.EcoreUtil2

class FieldExtensions {
	
	def static Entity getEntityObject(EObject object) {
		return EcoreUtil2.getContainerOfType(object, Entity)
	}
	
}