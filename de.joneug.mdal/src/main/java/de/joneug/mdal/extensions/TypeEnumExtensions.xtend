package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.Solution
import de.joneug.mdal.mdal.TypeEnum
import org.eclipse.xtext.generator.IFileSystemAccess2

import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.CustomFieldExtensions.*

class TypeEnumExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def void doGenerate(TypeEnum typeEnum, CustomField customField, Solution solution, IFileSystemAccess2 fsa) {
		solution.saveEnum(fsa, customField.getEnumFileName(solution), typeEnum.doGenerateEnum(customField, solution))
	}
	
	static def doGenerateEnum(TypeEnum typeEnum, CustomField customField, Solution solution) '''
	enum «management.newEnumNo» "«customField.getEnumName(solution)»"
	{
		Extensible = true;
		
		«FOR member : typeEnum.members»
			value(«management.getNewFieldNo(typeEnum)»; "«member»") { Caption = '«member»'; }
		«ENDFOR»
	}
	'''
	
}