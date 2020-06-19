package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.BoolInternal
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.Master
import de.joneug.mdal.mdal.Solution
import de.joneug.mdal.mdal.TemplateDimensions
import de.joneug.mdal.mdal.TemplateField
import org.eclipse.xtext.generator.IFileSystemAccess2

import static extension de.joneug.mdal.extensions.CustomFieldExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*
import static extension de.joneug.mdal.extensions.TemplateFieldExtensions.*

/**
 * This is an extension library for all {@link Master objects}.
 */
class MasterExtensions {
	
	/*
	 * Helper extensions
	 */

	static GeneratorManagement management = GeneratorManagement.getInstance()

	static def isNameInsteadDescr(Master master) {
		if (master.nameInsteadDescr == BoolInternal.UNSPECIFIED) {
			return false
		} else {
			return master.nameInsteadDescr == BoolInternal.TRUE
		}
	}

	static def getDescrOrName(Master master) {
		if (master.isNameInsteadDescr) {
			return 'Name'
		} else {
			return 'Description'
		}
	}
	
	static def getCleanedName(Master master) {
		return master.name.onlyAlphabetic.removeSpaces
	}
	
	static def getCleanedShortName(Master master) {
		return master.shortName.onlyAlphabetic.removeSpaces
	}

	static def getCustomFields(Master master) {
		return master.fields.filter(CustomField)
	}

	static def getTemplateFields(Master master) {
		return master.fields.filter(TemplateField)
	}

	static def addDimensions(Master master) {
		master.templateFields.exists[it.type instanceof TemplateDimensions]
	}

	static def getTableName(Master master, Solution solution) {
		return solution.constructObjectName(master.name)
	}

	static def getTableFileName(Master master, Solution solution) {
		return constructTableFileName(master.getTableName(solution))
	}
	
	static def getTableVariableName(Master master) {
		return master.cleanedShortName
	}

	static def getCardPageName(Master master, Solution solution) {
		return solution.constructObjectName(master.name + ' Card')
	}

	static def getListPageName(Master master, Solution solution) {
		return solution.constructObjectName(master.name + ' List')
	}
	
	/*
	 * Generator extensions
	 */
	
	static def void doGenerate(Master master, Solution solution, IFileSystemAccess2 fsa) {
		// Table
		solution.saveTable(fsa, master.getTableFileName(solution), master.doGenerateTable(solution, fsa))
		
		// List Page
		// Card Page
	}

	static def doGenerateTable(Master master, Solution solution, IFileSystemAccess2 fsa) '''
		table «management.getNewTableNo()» "«master.getTableName(solution)»"
		{
			Caption = '«master.name»';
			DataCaptionFields = "No.", «master.descrOrName»;
			DrillDownPageID = "«master.getListPageName(solution)»";
			LookupPageId = "«master.getListPageName(solution)»";
			
			fields
			{
				field(«management.getNewFieldNo(master)»; "No."; Code[20])
				{
					Caption = 'No.';
					
					trigger OnValidate()
					begin
						if "No." <> xRec."No." then begin
							Get«solution.setupTableVariableName»();
							NoSeriesMgt.TestManual(«solution.setupTableVariableName»."«master.cleanedName» Nos.");
							"No. Series" := '';
						end;
					end;
				}
				field(«management.getNewFieldNo(master)»; «master.descrOrName»; Text[100])
				{
					Caption = '«master.descrOrName»';
					
					trigger OnValidate()
					begin
						if ("Search «master.descrOrName»" = UpperCase(xRec.«master.descrOrName»)) or ("Search «master.descrOrName»" = '') then
							"Search «master.descrOrName»" := CopyStr(«master.descrOrName», 1, MaxStrLen("Search «master.descrOrName»"));
					end;
				}
				field(«management.getNewFieldNo(master)»; "Search «master.descrOrName»"; Code[100])
				{
					Caption = 'Search «master.descrOrName»';
				}
				field(«management.getNewFieldNo(master)»; "«master.descrOrName» 2"; Text[50])
				{
					Caption = '«master.descrOrName» 2';
				}
				field(«management.getNewFieldNo(master)»; Blocked; Boolean)
				{
					Caption = 'Blocked';
				}
				field(«management.getNewFieldNo(master)»; "Last Date Modified"; Date)
				{
					Caption = 'Last Date Modified';
					Editable = false;
				}
				field(«management.getNewFieldNo(master)»; "No. Series"; Code[20])
				{
					Caption = 'No. Series';
					Editable = false;
					TableRelation = "No. Series";
				}
				field(«management.getNewFieldNo(master)»; Comment; Boolean)
				{
					CalcFormula = Exist ("Comment Line" where("Table Name" = const(«master.cleanedName»), "No." = field("No.")));
					Caption = 'Comment';
					Editable = false;
					FieldClass = FlowField;
				}
				«FOR field : master.customFields»
					«field.doGenerate(master, solution, fsa)»
				«ENDFOR»
				«FOR field : master.templateFields»
					«field.doGenerate(master)»
				«ENDFOR»
			}
			
			keys
			{
				key(Key1; "No.")
				{
					Clustered = true;
				}
				key(Key2; "Search «master.descrOrName»") { }
			}
			
			fieldgroups
			{
				fieldgroup(DropDown; "No.", «master.descrOrName») { }
				fieldgroup(Brick; "No.", «master.descrOrName», "«master.descrOrName» 2") { }
			}
			
			trigger OnInsert()
			begin
				if "No." = '' then begin
					Test«master.cleanedName»NoSeries();
					NoSeriesMgt.InitSeries(«solution.setupTableVariableName»."«master.cleanedName» Nos.", xRec."No. Series", 0D, "No.", "No. Series");
				end;
				
				«IF master.addDimensions»
					DimMgt.UpdateDefaultDim(Database::"«master.getTableName(solution)»", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code");
				«ENDIF»
			end;
			
			trigger OnModify()
			begin
				"Last Date Modified" := Today;
			end;
			
			trigger OnDelete()
			begin
				«IF master.addDimensions»
					DimMgt.DeleteDefaultDim(Database::"«master.getTableName(solution)»", "No.");
					
				«ENDIF»
				CommentLine.SetRange("Table Name", CommentLine."Table Name"::«master.cleanedName»);
				CommentLine.SetRange("No.", "No.");
				CommentLine.DeleteAll();
				
				«solution.documentHeaderTableVariableName».SetCurrentKey("«master.cleanedName» No.");
				«solution.documentHeaderTableVariableName».SetRange("«master.cleanedName» No.", "No.");
				IF NOT «solution.documentHeaderTableVariableName».IsEmpty THEN
					Error(
						ExistingDocumentsErr,
						TableCaption, "No.", «solution.documentHeaderTableVariableName».TableCaption);
			end;
			
			trigger OnRename()
			begin
				"Last Date Modified" := Today;
			end;
				
			var
				«solution.setupTableVariableName»Read: Boolean;
				«solution.setupTableVariableName»: Record "«solution.setupTableName»";
				NoSeriesMgt: Codeunit NoSeriesManagement;
				«IF master.addDimensions»
					DimMgt: Codeunit DimensionManagement;
				«ENDIF»
				CommentLine: Record "Comment Line";
				«master.tableVariableName»: Record "«master.getTableName(solution)»";
				«solution.documentHeaderTableVariableName»: Record "«solution.documentHeaderTableName»";
				ExistingDocumentsErr: Label 'You cannot delete %1 %2 because there is at least one outstanding %3 for this «master.name».';
				
			procedure AssistEdit(Old«master.tableVariableName»: Record "«master.getTableName(solution)»"): Boolean
			begin
				with «master.tableVariableName» do begin
					«master.tableVariableName» := Rec;
					Test«master.cleanedName»NoSeries();
					if NoSeriesMgt.SelectSeries(«solution.setupTableVariableName»."«master.cleanedName» Nos.", Old«master.tableVariableName»."No. Series", "No. Series") then begin
						Test«master.cleanedName»NoSeries();
						NoSeriesMgt.SetSeries("No.");
						Rec := «master.tableVariableName»;
						exit(true);
					end;
				end;
			end;
			
			«IF master.addDimensions»
				procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
				begin
					OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
					
					DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
					if not IsTemporary then begin
						DimMgt.SaveDefaultDim(Database::"«master.getTableName(solution)»", "No.", FieldNumber, ShortcutDimCode);
						Modify;
					end;
					
					OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
				end;
				
				[IntegrationEvent(false, false)]
				local procedure OnBeforeValidateShortcutDimCode(var «master.tableVariableName»: Record "«master.getTableName(solution)»"; var x«master.tableVariableName»: Record "«master.getTableName(solution)»"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
				begin
				end;
				
				[IntegrationEvent(false, false)]
				local procedure OnAfterValidateShortcutDimCode(var «master.tableVariableName»: Record "«master.getTableName(solution)»"; var x«master.tableVariableName»: Record "«master.getTableName(solution)»"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
				begin
				end;
			«ENDIF»
			
			local procedure Get«solution.setupTableVariableName»()
			begin
				if not «solution.setupTableVariableName»Read then
					«solution.setupTableVariableName».Get();
					
				«solution.setupTableVariableName»Read := true;
				
				OnAfterGet«solution.setupTableVariableName»(«solution.setupTableVariableName»);
			end;
			
			[IntegrationEvent(false, false)]
			local procedure OnAfterGet«solution.setupTableVariableName»(var «solution.setupTableVariableName»: Record "«solution.setupTableName»")
			begin
			end;
			
			local procedure Test«master.cleanedName»NoSeries()
			begin
				Get«solution.setupTableVariableName»();
				«solution.setupTableVariableName».TestField("«master.cleanedName» Nos.");
			end;
			
			procedure TestBlocked()
			begin
				TestField(Blocked, false);
			end;
		}
	'''

}
