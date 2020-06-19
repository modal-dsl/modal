package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.Solution
import de.joneug.mdal.mdal.TypeEnum
import de.joneug.mdal.mdal.TypeOption
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.generator.IFileSystemAccess2

import static extension de.joneug.mdal.extensions.FieldTypeExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*

class CustomFieldExtensions {

	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def getEnumName(CustomField customField, Solution solution) {
		if(!(customField.type instanceof TypeEnum)) {
			throw new IllegalArgumentException("CustomField must be of type TypeEnum")
		}
		
		return solution.constructObjectName(customField.name)
	}

	static def getEnumFileName(CustomField customField, Solution solution) {
		if(!(customField.type instanceof TypeEnum)) {
			throw new IllegalArgumentException("CustomField must be of type TypeEnum")
		}
		return constructEnumFileName(customField.getEnumName(solution))
	}
	
	static def getInferredCaption(CustomField customField) {
		if(customField.caption.isNullOrEmpty) {
			return customField.name			
		} else {
			return customField.caption
		}
	}

	static def doGenerate(CustomField customField, EObject object, Solution solution, IFileSystemAccess2 fsa) '''
		field(«management.getNewFieldNo(object)»; "«customField.getName()»"; «customField.type.doGenerate(customField, solution, fsa)»)
		{
			Caption = '«customField.inferredCaption»';
			««« Option
			«IF customField.type instanceof TypeOption»
				OptionCaption = '«FOR member : (customField.type as TypeEnum).getMembers() SEPARATOR ','»«member»«ENDFOR»';
				OptionMembers = «FOR member : (customField.type as TypeEnum).getMembers() SEPARATOR ','»"«member»"«ENDFOR»;
			«ENDIF»
		}
	'''

}
