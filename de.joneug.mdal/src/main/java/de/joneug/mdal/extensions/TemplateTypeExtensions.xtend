package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.Field
import de.joneug.mdal.mdal.TemplateDescription
import de.joneug.mdal.mdal.TemplateDimensions
import de.joneug.mdal.mdal.TemplateName
import de.joneug.mdal.mdal.TemplateType

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.FieldExtensions.*
import de.joneug.mdal.mdal.TemplateSalesperson
import de.joneug.mdal.mdal.TemplateAddress
import de.joneug.mdal.mdal.TemplateContactInfo

class TemplateTypeExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def getField(TemplateType templateType) {
		return templateType.getContainerOfType(Field)
	}
	
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
		field(«management.getNewFieldNo(templateType.field.entity)»; Name; Text[100])
		{
			Caption = 'Name';
			
			trigger OnValidate()
			begin
				if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
					"Search Name" := CopyStr(Name, 1, MaxStrLen("Search Name"));
			end;
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Search Name"; Code[100])
		{
			Caption = 'Search Name';
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Name 2"; Text[50])
		{
			Caption = 'Name 2';
		}
	'''
	
	static def dispatch doGenerate(TemplateDescription templateType) '''
		field(«management.getNewFieldNo(templateType.field.entity)»; Description; Text[100])
		{
			Caption = 'Description';
			
			trigger OnValidate()
			begin
				if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
					"Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
			end;
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Search Description"; Code[100])
		{
			Caption = 'Search Description';
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Description 2"; Text[50])
		{
			Caption = 'Description 2';
		}
	'''

	static def dispatch doGenerate(TemplateDimensions templateType) '''
		field(«management.getNewFieldNo(templateType.field.entity)»; "Global Dimension 1 Code"; Code[20])
		{
			CaptionClass = '1,1,1';
			Caption = 'Global Dimension 1 Code';
			TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
			
			trigger OnValidate()
			begin
				ValidateShortcutDimCode(1, "Global Dimension 1 Code");
			end;
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Global Dimension 2 Code"; Code[20])
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
	
	static def dispatch doGenerate(TemplateSalesperson templateType) '''
		field(«management.getNewFieldNo(templateType.field.entity)»; "Salesperson Code"; Code[20])
		{
			Caption = 'Salesperson Code';
			TableRelation = "Salesperson/Purchaser";
			
			trigger OnValidate()
			begin
				ValidateSalesPersonCode();
			end;
		}
	'''
	
	static def dispatch doGenerate(TemplateAddress templateType) '''
		field(«management.getNewFieldNo(templateType.field.entity)»; Address; Text[100])
		{
			Caption = 'Address';
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Address 2"; Text[50])
		{
			Caption = 'Address 2';
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; City; Text[30])
		{
			Caption = 'City';
			TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
			else
			if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
			ValidateTableRelation = false;
			
			trigger OnLookup()
			begin
				OnBeforeLookupCity(Rec, PostCode);
				
				PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
			end;
			
			trigger OnValidate()
			begin
			OnBeforeValidateCity(Rec, PostCode);
			
			PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
			end;
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Country/Region Code"; Code[10])
		{
			Caption = 'Country/Region Code';
			TableRelation = "Country/Region";
			
			trigger OnValidate()
			begin
				PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");
			end;
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Post Code"; Code[20])
		{
			Caption = 'Post Code';
			TableRelation = if ("Country/Region Code" = const('')) "Post Code"
			else
			if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
			ValidateTableRelation = false;
			
			trigger OnLookup()
			begin
				OnBeforeLookupPostCode(Rec, PostCode);
				
				PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
			end;
			
			trigger OnValidate()
			begin
				OnBeforeValidatePostCode(Rec, PostCode);
				
				PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
			end;
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; County; Text[30])
		{
			CaptionClass = '5,1,' + "Country/Region Code";
			Caption = 'County';
		}
	'''
	
	static def dispatch doGenerate(TemplateContactInfo templateType) '''
		field(«management.getNewFieldNo(templateType.field.entity)»; "Contact Person"; Text[50])
		{
			Caption = 'Contact Person';
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Phone No."; Text[30])
		{
			Caption = 'Phone No.';
			ExtendedDatatype = PhoneNo;
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Telex No."; Text[30])
		{
			Caption = 'Telex No.';
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Fax No."; Text[30])
		{
			Caption = 'Fax No.';
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Telex Answer Back"; Text[20])
		{
			Caption = 'Telex Answer Back';
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "E-Mail"; Text[80])
		{
			Caption = 'Email';
			ExtendedDatatype = EMail;
			
			trigger OnValidate()
			var
				MailManagement: Codeunit "Mail Management";
			begin
				MailManagement.ValidateEmailAddressField("E-Mail");
			end;
		}
		field(«management.getNewFieldNo(templateType.field.entity)»; "Home Page"; Text[80])
		{
			Caption = 'Home Page';
			ExtendedDatatype = URL;
		}
	'''
	
}