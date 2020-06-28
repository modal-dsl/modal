package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.TemplateDescription
import de.joneug.mdal.mdal.TemplateDimensions
import de.joneug.mdal.mdal.TemplateGenProdPostingGroup
import de.joneug.mdal.mdal.TemplateName
import de.joneug.mdal.mdal.TemplateType

import static extension de.joneug.mdal.extensions.FieldExtensions.*

class TemplateTypeExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	/*
	 * Polymorphic dispatch for "getDataCaptionFields" on TemplateType subtypes 
	 */
	
	static def dispatch getDataCaptionFields(TemplateType templateType) {
		return newArrayList
	}
	
	static def dispatch getDataCaptionFields(TemplateName templateType) {
		return newArrayList('Name')
	}
	
	static def dispatch getDataCaptionFields(TemplateDescription templateType) {
		return newArrayList('Description')
	}
	
	/*
	 * Polymorphic dispatch for "getKeys" on TemplateType subtypes 
	 */
	
	static def dispatch getKeys(TemplateType templateType) {
		return newArrayList
	}
	
	static def dispatch getKeys(TemplateName templateType) {
		return newArrayList('Search Name')
	}
	
	static def dispatch getKeys(TemplateDescription templateType) {
		return newArrayList('Search Description')
	}
	
	/*
	 * Polymorphic dispatch for "getFieldgroupDropDown" on TemplateType subtypes 
	 */
	
	static def dispatch getFieldgroupDropDown(TemplateType templateType) {
		return newArrayList
	}
	
	static def dispatch getFieldgroupDropDown(TemplateName templateType) {
		return newArrayList('Name')
	}
	
	static def dispatch getFieldgroupDropDown(TemplateDescription templateType) {
		return newArrayList('Description')
	}
	
	/*
	 * Polymorphic dispatch for "getFieldGroupBrick" on TemplateType subtypes 
	 */
	
	static def dispatch getFieldGroupBrick(TemplateType templateType) {
		return newArrayList
	}
	
	static def dispatch getFieldGroupBrick(TemplateName templateType) {
		return newArrayList('Name', 'Name 2')
	}
	
	static def dispatch getFieldGroupBrick(TemplateDescription templateType) {
		return newArrayList('Description', 'Description 2')
	}
	
	/*
	 * Polymorphic dispatch for "doGenerate" on TemplateType subtypes 
	 */
	
	static def dispatch doGenerate(TemplateName templateType) '''
		field(«management.getNewFieldNo(templateType.entityObject)»; Name; Text[100])
		{
			Caption = 'Name';
			
			trigger OnValidate()
			begin
				if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
					"Search Name" := CopyStr(Name, 1, MaxStrLen("Search Name"));
			end;
		}
		field(«management.getNewFieldNo(templateType.entityObject)»; "Search Name"; Code[100])
		{
			Caption = 'Search Name';
		}
		field(«management.getNewFieldNo(templateType.entityObject)»; "Name 2"; Text[50])
		{
			Caption = 'Name 2';
		}
	'''
	
	static def dispatch doGenerate(TemplateDescription templateType) '''
		field(«management.getNewFieldNo(templateType.entityObject)»; Description; Text[100])
		{
			Caption = 'Description';
			
			trigger OnValidate()
			begin
				if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
					"Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
			end;
		}
		field(«management.getNewFieldNo(templateType.entityObject)»; "Search Description"; Code[100])
		{
			Caption = 'Search Description';
		}
		field(«management.getNewFieldNo(templateType.entityObject)»; "Description 2"; Text[50])
		{
			Caption = 'Description 2';
		}
	'''
	
	static def dispatch doGenerate(TemplateGenProdPostingGroup templateType) '''
		field(«management.getNewFieldNo(templateType.entityObject)»; "Gen. Prod. Posting Group"; Code[20])
		{
			Caption = 'Gen. Prod. Posting Group';
			TableRelation = "Gen. Product Posting Group";
		}
	'''

	static def dispatch doGenerate(TemplateDimensions templateType) '''
		field(«management.getNewFieldNo(templateType.entityObject)»; "Global Dimension 1 Code"; Code[20])
		{
			CaptionClass = '1,1,1';
			Caption = 'Global Dimension 1 Code';
			TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
			
			trigger OnValidate()
			begin
				ValidateShortcutDimCode(1, "Global Dimension 1 Code");
			end;
		}
		field(«management.getNewFieldNo(templateType.entityObject)»; "Global Dimension 2 Code"; Code[20])
		{
			CaptionClass = '1,1,2';
			Caption = 'Global Dimension 2 Code';
			TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
			
			trigger OnValidate()
			begin
				ValidateShortcutDimCode(2, "Global Dimension 2 Code");
			end;
		}
	'''
	
}