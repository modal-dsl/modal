package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.TemplateField

import static extension de.joneug.mdal.extensions.TemplateTypeExtensions.*

class TemplateFieldExtensions {

	static def String[] getDataCaptionFields(TemplateField templateField) {
		return templateField.type.dataCaptionFields
	}
	
	static def String[] getKeys(TemplateField templateField) {
		return templateField.type.keys
	}
	
	static def String[] getFieldgroupDropDown(TemplateField templateField) {
		templateField.type.fieldgroupDropDown
	}
	
	static def String[] getFieldGroupBrick(TemplateField templateField) {	
		templateField.type.fieldGroupBrick
	}
	
	static def doGenerate(TemplateField templateField) {
		return templateField.type.doGenerate
	}

}
