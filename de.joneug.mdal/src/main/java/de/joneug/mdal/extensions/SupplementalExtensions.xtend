package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Supplemental
import de.joneug.mdal.mdal.TemplateAddress
import de.joneug.mdal.mdal.TemplateDimensions
import de.joneug.mdal.mdal.TemplateSalesperson

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.PageFieldExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class SupplementalExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def getListPageName(Supplemental supplemental) {
		return supplemental.solution.constructObjectName(supplemental.name + 's')
	}
	
	static def getDataCaptionFields(Supplemental supplemental) {
		val fields = (supplemental as Entity).dataCaptionFields
		fields.add('Code')
		return fields
	}
	
	static def getFieldGroupBrick(Supplemental supplemental) {
		val fields = (supplemental as Entity).fieldGroupBrick
		fields.add('Code')
		return fields
	}
	
	static def void doGenerate(Supplemental supplemental) {
		supplemental.saveTable(supplemental.tableName, supplemental.doGenerateTable)
		supplemental.savePage(supplemental.listPageName, supplemental.doGenerateListPage)
	}
	
	static def doGenerateTable(Supplemental supplemental) '''
	table «management.getNewTableNo(supplemental)» "«supplemental.tableName»" {
		Caption = '«supplemental.name»';
		DataCaptionFields = «FOR field : supplemental.dataCaptionFields SEPARATOR ', '»«field.saveQuote»«ENDFOR»;
		LookupPageId = "«supplemental.listPageName»";
		
		fields
		{
			field(«management.getNewFieldNo(supplemental)»; "Code"; Code[10])
			{
				Caption = 'Code';
				NotBlank = true;
			}
			«supplemental.doGenerateTableFields»
			field(«management.getNewFieldNo(supplemental)»; Blocked; Boolean)
			{
				Caption = 'Blocked';
			}
		}
		
		keys
		{
			key(Key«management.getNewKeyNo(supplemental)»; "Code")
			{
				Clustered = true;
			}
			«FOR field : supplemental.keys»
			key(Key«management.getNewKeyNo(supplemental)»; «field.saveQuote») { }
			«ENDFOR»
		}
		
		fieldgroups
		{
			fieldgroup(DropDown; «FOR field : supplemental.fieldgroupDropDown SEPARATOR ', '»«field.saveQuote»«ENDFOR») { }
		}
		
		«IF supplemental.hasTemplateOfType(TemplateDimensions)»
			trigger OnInsert()
			begin
				DimMgt.UpdateDefaultDim(Database::"«supplemental.tableName»", "Code", "Global Dimension 1 Code", "Global Dimension 2 Code");
			end;
			
			trigger OnDelete()
			begin
				«IF supplemental.hasTemplateOfType(TemplateDimensions)»
					DimMgt.DeleteDefaultDim(Database::"«supplemental.tableName»", "Code");
				«ENDIF»
			end;
		«ENDIF»
		var
			PostCode: Record "Post Code";
			«IF supplemental.hasTemplateOfType(TemplateDimensions)»
				DimMgt: Codeunit DimensionManagement;
			«ENDIF»
		
		procedure TestBlocked()
		begin
			TestField(Blocked, false);
		end;
		«IF supplemental.hasTemplateOfType(TemplateSalesperson)»

			local procedure ValidateSalesPersonCode()
			var
				SalespersonPurchaser: Record "Salesperson/Purchaser";
			begin
				if "Salesperson Code" <> '' then
					if SalespersonPurchaser.Get("Salesperson Code") then
						if SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) then
							Error(SalespersonPurchaser.GetPrivacyBlockedGenericText(SalespersonPurchaser, true));
			end;
		«ENDIF»
		«IF supplemental.hasTemplateOfType(TemplateDimensions)»

			procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
			begin
				OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
				
				DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
				if not IsTemporary then begin
					DimMgt.SaveDefaultDim(Database::"«supplemental.tableName»", "Code", FieldNumber, ShortcutDimCode);
						Modify;
					end;
					
					OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
				end;
				
			[IntegrationEvent(false, false)]
			local procedure OnBeforeValidateShortcutDimCode(var «supplemental.tableVariableName»: Record "«supplemental.tableName»"; var x«supplemental.tableVariableName»: Record "«supplemental.tableName»"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
			begin
			end;
			
			[IntegrationEvent(false, false)]
			local procedure OnAfterValidateShortcutDimCode(var «supplemental.tableVariableName»: Record "«supplemental.tableName»"; var x«supplemental.tableVariableName»: Record "«supplemental.tableName»"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
			begin
			end;
		«ENDIF»
		«IF supplemental.hasTemplateOfType(TemplateAddress)»
			
			[IntegrationEvent(false, false)]
			local procedure OnBeforeLookupCity(SeminarRoom: Record "SEM Seminar Room"; var PostCodeRec: Record "Post Code");
			begin
			end;
			
			[IntegrationEvent(false, false)]
			local procedure OnBeforeLookupPostCode(SeminarRoom: Record "SEM Seminar Room"; var PostCodeRec: Record "Post Code");
			begin
			end;
			
			[IntegrationEvent(false, false)]
			local procedure OnBeforeValidateCity(SeminarRoom: Record "SEM Seminar Room"; var PostCodeRec: Record "Post Code");
			begin
			end;
			
			[IntegrationEvent(false, false)]
			local procedure OnBeforeValidatePostCode(SeminarRoom: Record "SEM Seminar Room"; var PostCodeRec: Record "Post Code");
			begin
			end;
		«ENDIF»
	}
	'''
	
	static def doGenerateListPage(Supplemental supplemental) '''
	page «management.newPageNo» «supplemental.listPageName.saveQuote»
	{
	    ApplicationArea = All;
	    Caption = '«supplemental.name»s';
	    PageType = List;
	    SourceTable = «supplemental.tableName.saveQuote»;
	    UsageCategory = Lists;
	
	    layout
	    {
	        area(content)
	        {
	            repeater(Control1)
	            {
	            	ShowCaption = false;
	                field("Code"; "Code")
	                {
	                    ApplicationArea = All;
	                }
	                «FOR pageField : supplemental.listPageFields»
	                	«pageField.doGenerate»
	                «ENDFOR»
	                field(Blocked; Blocked)
	                {
	                    ApplicationArea = All;
	                    Visible = false;
	                }
	            }
	        }
	        area(factboxes)
	        {
	            systempart(Control1900383207; Links)
	            {
	                ApplicationArea = RecordLinks;
	                Visible = false;
	            }
	            systempart(Control1905767507; Notes)
	            {
	                ApplicationArea = Notes;
	                Visible = true;
	            }
	        }
	    }
	}
	'''
	
}