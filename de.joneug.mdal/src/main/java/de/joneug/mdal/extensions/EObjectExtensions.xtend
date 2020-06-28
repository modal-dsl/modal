package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.Model
import de.joneug.mdal.mdal.Solution
import java.util.List
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.EcoreUtil2

class EObjectExtensions {

	def static String dump(EObject object) {
		return object.dump("")
	}

	// Adapted from https://stackoverflow.com/a/35116799
	def protected static String dump(EObject object, String indent) {
		val replaceRegex = '.*[.]impl[.](.*)Impl[^(]*'
		var output = indent + object.toString().replaceFirst(replaceRegex, '$1 ')

		for (reference : object.eCrossReferences) {
			output += ' ->' + reference.toString().replaceFirst(replaceRegex, '$1 ')
		}
		output += "\n"
		for (content : object.eContents) {
			output += content.dump(indent + "\t")
		}
		return output
	}

	def static <T extends EObject> List<T> getAllContentsOfTypeFromRoot(EObject object, Class<T> type) {
		val root = EcoreUtil2.getContainerOfType(object, Model)
		return EcoreUtil2.getAllContentsOfType(root, type)
	}
	
	def static <T extends EObject> getContainerOfType(EObject object, Class<T> type) {
		return EcoreUtil2.getContainerOfType(object, type)
	}

	def static getSolution(EObject object) {
		return object.getContainerOfType(Solution)
	}
	
}
