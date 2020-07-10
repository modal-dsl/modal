package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Field
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.TemplateAddress
import de.joneug.mdal.mdal.TemplateContact
import de.joneug.mdal.mdal.TemplateContactInfo
import de.joneug.mdal.mdal.TemplateDescription
import de.joneug.mdal.mdal.TemplateDimensions
import de.joneug.mdal.mdal.TemplateName
import de.joneug.mdal.mdal.TemplateSalesperson
import de.joneug.mdal.mdal.TemplateType

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.FieldExtensions.*
import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class TemplateTypeExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def getField(TemplateType templateType) {
		return templateType.getContainerOfType(Field)
	}
	
	static def calledFromEditableTable(StackTraceElement[] stacktrace) {
		return !stacktrace.exists[
			(it.className == DocumentHeaderExtensions.name && it.methodName == 'doGenerateTablePosted') ||
			(it.className == DocumentLineExtensions.name && it.methodName == 'doGenerateTablePosted') ||
			it.className == LedgerEntryExtensions.name
		]
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
	 * Polymorphic dispatch for "doGenerateTableFields" on TemplateType subtypes 
	 */
	static def dispatch doGenerateTableFields(TemplateName templateType, IncludeField includeField) {
		var entity = templateType.field.entity
		var prefix = ''
		if(includeField !== null) {
			entity = includeField.getContainerOfType(Entity)
			prefix = includeField.entity.shortName + ' '
		}
		return '''
			field(«management.getNewFieldNo(entity)»; "«prefix»Name"; Text[100])
			{
				Caption = '«prefix»Name';
				
				«IF includeField === null»
					trigger OnValidate()
					begin
						if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
							"Search Name" := CopyStr(Name, 1, MaxStrLen("Search Name"));
					end;
				«ENDIF»
			}
			«IF includeField === null»
				field(«management.getNewFieldNo(templateType.field.entity)»; "Search Name"; Code[100])
				{
					Caption = 'Search Name';
				}
			«ENDIF»
			field(«management.getNewFieldNo(templateType.field.entity)»; "«prefix»Name 2"; Text[50])
			{
				Caption = '«prefix»Name 2';
			}
		'''
	}
		
	static def dispatch doGenerateTableFields(TemplateDescription templateType, IncludeField includeField) {
		var entity = templateType.field.entity
		var prefix = ''
		if(includeField !== null) {
			entity = includeField.getContainerOfType(Entity)
			prefix = includeField.entity.shortName + ' '
		}
		
		return '''
			field(«management.getNewFieldNo(entity)»; "«prefix»Description"; Text[100])
			{
				Caption = '«prefix»Description';
				
				«IF includeField === null»
					trigger OnValidate()
					begin
						if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
							"Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
					end;
				«ENDIF»
			}
			«IF includeField === null»
				field(«management.getNewFieldNo(entity)»; "Search Description"; Code[100])
				{
					Caption = 'Search Description';
				}
			«ENDIF»
			field(«prefix»«management.getNewFieldNo(entity)»; "«prefix»Description 2"; Text[50])
			{
				Caption = '«prefix»Description 2';
			}
		'''
	}

	static def dispatch doGenerateTableFields(TemplateDimensions templateType, IncludeField includeField) {
		var entity = templateType.field.entity
		if(includeField !== null) {
			entity = includeField.getContainerOfType(Entity)
		}
		val editable = Thread.currentThread.stackTrace.calledFromEditableTable
		
		return '''
			field(«management.getNewFieldNo(entity)»; "Global Dimension 1 Code"; Code[20])
			{
				CaptionClass = '1,1,1';
				Caption = 'Global Dimension 1 Code';
				TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
				«IF editable»
					
					trigger OnValidate()
					begin
						ValidateShortcutDimCode(1, "Global Dimension 1 Code");
					end;
				«ENDIF»
			}
			field(«management.getNewFieldNo(entity)»; "Global Dimension 2 Code"; Code[20])
			{
				CaptionClass = '1,1,2';
				Caption = 'Global Dimension 2 Code';
				TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
				«IF editable»
					
					trigger OnValidate()
					begin
						ValidateShortcutDimCode(2, "Global Dimension 2 Code");
					end;
				«ENDIF»
			}
		'''
	}
	
	static def dispatch doGenerateTableFields(TemplateAddress templateType, IncludeField includeField) {
		var entity = templateType.field.entity
		var prefix = ''
		if(includeField !== null) {
			entity = includeField.getContainerOfType(Entity)
			prefix = includeField.entity.shortName + ' '
		}
		val editable = Thread.currentThread.stackTrace.calledFromEditableTable
		
		return '''
			field(«management.getNewFieldNo(entity)»; "«prefix»Address"; Text[100])
			{
				Caption = '«prefix»Address';
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»Address 2"; Text[50])
			{
				Caption = '«prefix»Address 2';
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»City"; Text[30])
			{
				Caption = '«prefix»City';
				TableRelation = if ("«prefix»Country/Region Code" = const('')) "Post Code".City
				else
				if ("«prefix»Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("«prefix»Country/Region Code"));
				ValidateTableRelation = false;
				«IF editable»
					
					trigger OnLookup()
					begin
						OnBeforeLookupCity(Rec, PostCode);
						
						PostCode.LookupPostCode("«prefix»City", "«prefix»Post Code", "«prefix»County", "«prefix»Country/Region Code");
					end;
					
					trigger OnValidate()
					begin
					OnBeforeValidateCity(Rec, PostCode);
					
					PostCode.ValidateCity("«prefix»City", "«prefix»Post Code", "«prefix»County", "«prefix»Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
					end;
				«ENDIF»
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»Country/Region Code"; Code[10])
			{
				Caption = '«prefix»Country/Region Code';
				TableRelation = "Country/Region";
				«IF editable»
					
					trigger OnValidate()
					begin
						PostCode.CheckClearPostCodeCityCounty("«prefix»City", "«prefix»Post Code", "«prefix»County", "«prefix»Country/Region Code", xRec."«prefix»Country/Region Code");
					end;
				«ENDIF»
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»Post Code"; Code[20])
			{
				Caption = '«prefix»Post Code';
				TableRelation = if ("«prefix»Country/Region Code" = const('')) "Post Code"
				else
				if ("«prefix»Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("«prefix»Country/Region Code"));
				ValidateTableRelation = false;
				«IF editable»
					
					trigger OnLookup()
					begin
						OnBeforeLookupPostCode(Rec, PostCode);
						
						PostCode.LookupPostCode("«prefix»City", "«prefix»Post Code", "«prefix»County", "«prefix»Country/Region Code");
					end;
					
					trigger OnValidate()
					begin
						OnBeforeValidatePostCode(Rec, PostCode);
						
						PostCode.ValidatePostCode("«prefix»City", "«prefix»Post Code", "«prefix»County", "«prefix»Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
					end;
				«ENDIF»
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»County"; Text[30])
			{
				CaptionClass = '5,1,' + "«prefix»Country/Region Code";
				Caption = '«prefix»County';
			}
		'''
	}
	
	static def dispatch doGenerateTableFields(TemplateContactInfo templateType, IncludeField includeField) {
		var entity = templateType.field.entity
		var prefix = ''
		if(includeField !== null) {
			entity = includeField.getContainerOfType(Entity)
			prefix = includeField.entity.shortName + ' '
		}
		val editable = Thread.currentThread.stackTrace.calledFromEditableTable
		
		return '''
			field(«management.getNewFieldNo(entity)»; "«prefix»Contact Person"; Text[50])
			{
				Caption = '«prefix»Contact Person';
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»Phone No."; Text[30])
			{
				Caption = '«prefix»Phone No.';
				ExtendedDatatype = PhoneNo;
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»Telex No."; Text[30])
			{
				Caption = '«prefix»Telex No.';
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»Fax No."; Text[30])
			{
				Caption = '«prefix»Fax No.';
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»Telex Answer Back"; Text[20])
			{
				Caption = '«prefix»Telex Answer Back';
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»E-Mail"; Text[80])
			{
				Caption = '«prefix»Email';
				ExtendedDatatype = EMail;
				«IF editable»
					
					trigger OnValidate()
					var
						MailManagement: Codeunit "Mail Management";
					begin
						MailManagement.ValidateEmailAddressField("«prefix»E-Mail");
					end;
				«ENDIF»
			}
			field(«management.getNewFieldNo(entity)»; "«prefix»Home Page"; Text[80])
			{
				Caption = '«prefix»Home Page';
				ExtendedDatatype = URL;
			}
		'''
	}
	
	static def dispatch doGenerateTableFields(TemplateSalesperson templateType, IncludeField includeField) {
		var entity = templateType.field.entity
		if(includeField !== null) {
			entity = includeField.getContainerOfType(Entity)
		}
		val editable = Thread.currentThread.stackTrace.calledFromEditableTable
		
		return '''
			field(«management.getNewFieldNo(entity)»; "Salesperson Code"; Code[20])
			{
				Caption = 'Salesperson Code';
				TableRelation = "Salesperson/Purchaser";
				«IF editable»
					
					trigger OnValidate()
					begin
						ValidateSalesPersonCode();
					end;
				«ENDIF»
			}
		'''
	}
	
	static def dispatch doGenerateTableFields(TemplateContact templateType, IncludeField includeField) {
		var entity = templateType.field.entity
		var fieldName = templateType.field.name
		if(includeField !== null) {
			entity = includeField.getContainerOfType(Entity)
			fieldName = includeField.name
		}
		val editable = Thread.currentThread.stackTrace.calledFromEditableTable
		
		return '''
			field(«management.getNewFieldNo(entity)»; «fieldName.saveQuote»; Code[20])
			{
				Caption = '«fieldName»';
				TableRelation = Contact;
				«IF editable»
					
					trigger OnLookup()
					var
						Cont: Record Contact;
						ContBusinessRelation: Record "Contact Business Relation";
					begin
						if «fieldName.saveQuote» <> '' then
							if Cont.Get(«fieldName.saveQuote») then
								Cont.SetRange("Company No.", Cont."Company No.")
							else
								if ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, «fieldName.saveQuote») then
									Cont.SetRange("Company No.", ContBusinessRelation."Contact No.")
								else
									Cont.SetRange("No.", '');
						
						if «fieldName.saveQuote» <> '' then
							if Cont.Get(«fieldName.saveQuote») then;
						if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
							xRec := Rec;
							Validate(«fieldName.saveQuote», Cont."No.");
						end;
					end;
					
					trigger OnValidate()
					var
						ContBusinessRelation: Record "Contact Business Relation";
						Cont: Record Contact;
					begin
						if «fieldName.saveQuote» = xRec.«fieldName.saveQuote» then
							exit;
						
						if «fieldName.saveQuote» <> '' then
							if Cont.Get(«fieldName.saveQuote») then
								Cont.CheckIfPrivacyBlockedGeneric;
					end;
				«ENDIF»
			}
		'''
	}
	
	/*
	 * Polymorphic dispatch for "doGeneratePageFields" on TemplateType subtypes 
	 */
	 
	static def dispatch doGeneratePageFields(TemplateName templateType, IncludeField includeField) {
		var prefix = ''
		if(includeField !== null) {
			prefix = includeField.entity.shortName + ' '
		}
		return '''
			field("«prefix»Name"; "«prefix»Name")
			{
				ApplicationArea = All;
				Importance = Promoted;
				ShowMandatory = true;
				
				«IF includeField === null»
					trigger OnValidate()
					begin
						CurrPage.SaveRecord;
					end;
				«ENDIF»
			}
			field("«prefix»Name 2"; "«prefix»Name 2")
			{
				ApplicationArea = All;
				Importance = Additional;
				Visible = false;
			}
			«IF includeField === null»
				field("Search Name"; "Search Name")
				{
					ApplicationArea = All;
					Importance = Additional;
				}
			«ENDIF»
		'''
	}
	
	static def dispatch doGeneratePageFields(TemplateDescription templateType, IncludeField includeField) {
		var prefix = ''
		if(includeField !== null) {
			prefix = includeField.entity.shortName + ' '
		}
		return '''
		    field("«prefix»Description"; "«prefix»Description")
		    {
		        ApplicationArea = All;
		        Importance = Promoted;
		        ShowMandatory = true;
		        
		        «IF includeField === null»
		        	trigger OnValidate()
		        	begin
		        		CurrPage.SaveRecord;
		        	end;
			    «ENDIF»
		    }
		    field("«prefix»Description 2"; "«prefix»Description 2")
		    {
		        ApplicationArea = All;
		        Importance = Additional;
		        Visible = false;
		    }
		    «IF includeField === null»
		    	field("Search Description"; "Search Description")
		    	{
		    		ApplicationArea = All;
		    		Importance = Additional;
		    	}
		    «ENDIF»
		'''
	}
	
	static def dispatch doGeneratePageFields(TemplateDimensions templateType, IncludeField includeField) ''''''

	static def dispatch doGeneratePageFields(TemplateSalesperson templateType, IncludeField includeField) '''
		field("Salesperson Code"; "Salesperson Code")
		{
		    ApplicationArea = All;
		}
	'''
	
	static def dispatch doGeneratePageFields(TemplateAddress templateType, IncludeField includeField) {
		var prefix = ''
		if(includeField !== null) {
			prefix = includeField.entity.shortName + ' '
		}
		return '''
			field("«prefix»Address"; "«prefix»Address")
			{
				ApplicationArea = All;
				QuickEntry = false;
			}
			field("«prefix»Address 2"; "«prefix»Address 2")
			{
				ApplicationArea = All;
				QuickEntry = false;
			}
			field("«prefix»City"; "«prefix»City")
			{
				ApplicationArea = All;
				QuickEntry = false;
			}
			field("«prefix»County"; "«prefix»County")
			{
				ApplicationArea = All;
				QuickEntry = false;
			}
			field("«prefix»Post Code"; "«prefix»Post Code")
			{
				ApplicationArea = All;
				QuickEntry = false;
			}
			field("«prefix»Country/Region Code"; "«prefix»Country/Region Code")
			{
				ApplicationArea = All;
				QuickEntry = false;
			}
		'''	
	}
	
	static def dispatch doGeneratePageFields(TemplateContactInfo templateType, IncludeField includeField) {
		var prefix = ''
		if(includeField !== null) {
			prefix = includeField.entity.shortName + ' '
		}
		return '''
			field("«prefix»Phone No."; "«prefix»Phone No.")
			{
				ApplicationArea = All;
			}
			field("«prefix»Telex No."; "«prefix»Telex No.")
			{
				ApplicationArea = All;
				Visible = false;
			}
			field("«prefix»Fax No."; "«prefix»Fax No.")
			{
				ApplicationArea = All;
				Visible = false;
			}
			field("«prefix»Telex Answer Back"; "«prefix»Telex Answer Back")
			{
				ApplicationArea = All;
				Visible = false;
			}
			field("«prefix»E-Mail"; "«prefix»E-Mail")
			{
				ApplicationArea = All;
			}
			field("«prefix»Home Page"; "«prefix»Home Page")
			{
				ApplicationArea = All;
			}
		'''	
	}
	
	static def dispatch doGeneratePageFields(TemplateContact templateType, IncludeField includeField) {
		var fieldName = templateType.field.name
		if(includeField !== null) {
			fieldName = includeField.name
		}
		return '''
			field(«fieldName.saveQuote»; «fieldName.saveQuote»)
			{
				ApplicationArea = All;
			}
		'''
	}
}