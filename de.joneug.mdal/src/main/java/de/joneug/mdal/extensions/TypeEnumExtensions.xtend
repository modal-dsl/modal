package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.TypeEnum
import org.eclipse.xtext.generator.IFileSystemAccess2

import static extension de.joneug.mdal.extensions.CustomFieldExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*

class TypeEnumExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def void doGenerate(TypeEnum typeEnum, IFileSystemAccess2 fsa) {
		typeEnum.solution.saveEnum(fsa, typeEnum.getContainerOfType(CustomField).getEnumFileName(), typeEnum.doGenerateEnum)
	}
	
	static def doGenerateEnum(TypeEnum typeEnum) '''
	enum «management.newEnumNo» "«typeEnum.getContainerOfType(CustomField).getEnumName()»"
	{
		Extensible = true;
		
		«FOR member : typeEnum.members»
			value(«management.getNewFieldNo(typeEnum)»; "«member»") { Caption = '«member»'; }
		«ENDFOR»
	}
	'''
	
}