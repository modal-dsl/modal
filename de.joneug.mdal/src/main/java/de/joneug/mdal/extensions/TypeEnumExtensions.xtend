package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.TypeEnum

import static extension de.joneug.mdal.extensions.CustomFieldExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class TypeEnumExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def getCustomField(TypeEnum typeEnum) {
		return typeEnum.getContainerOfType(CustomField)
	}
	
	static def void doGenerate(TypeEnum typeEnum) {
		// Skip if file was already generated as this method could be called multiple times due to IncludeFields
		if(!typeEnum.solution.existsEnum(typeEnum.customField.enumFileName)) {
			typeEnum.solution.saveEnum(typeEnum.customField.enumFileName, typeEnum.doGenerateEnum)	
		}
	}
	
	static def doGenerateEnum(TypeEnum typeEnum) '''
	enum «management.newEnumNo» «typeEnum.customField.enumName.saveQuote»
	{
		Extensible = true;
		
		«FOR member : typeEnum.members»
			value(«management.getNewFieldNo(typeEnum.customField) - 1»; "«member»") { Caption = '«member»'; }
		«ENDFOR»
	}
	'''
	
}
