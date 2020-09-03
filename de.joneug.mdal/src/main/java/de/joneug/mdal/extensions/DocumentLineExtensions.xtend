package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.BoolInternal
import de.joneug.mdal.mdal.Document
import de.joneug.mdal.mdal.DocumentLine
import de.joneug.mdal.mdal.TemplateDimensions

import static extension de.joneug.mdal.extensions.DocumentExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
import static extension de.joneug.mdal.extensions.PageFieldExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class DocumentLineExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def getDocument(DocumentLine line) {
		return line.getContainerOfType(Document)
	}
	
	static def getTableName(DocumentLine line) {
		return line.solution.constructObjectName(line.shortName)
	}
	
	static def getNamePosted(DocumentLine line) {
		return 'Posted ' + line.name
	}
	
	static def getShortNamePosted(DocumentLine line) {
		return 'Pstd. ' + line.shortName
	}
	
	static def getCleanedNamePosted(DocumentLine line) {
		return line.namePosted.toOnlyAlphabetic.removeSpaces
	}
	
	static def getCleanedShortNamePosted(DocumentLine line) {
		return line.shortNamePosted.toOnlyAlphabetic.removeSpaces
	}

	static def getTableNamePosted(DocumentLine line) {
		var name = line.solution.constructObjectName(line.namePosted)
		if(name.length > 30) {
			name = line.solution.constructObjectName(line.shortNamePosted)
		}
		return name
	}
	
	static def getTableVariableNamePosted(DocumentLine line) {
		return line.cleanedShortNamePosted
	}
	
	static def getSubformPageName(DocumentLine line) {
		return line.solution.constructObjectName(line.document.shortName + ' Subf.')
	}
	
	static def String getSubformPageNamePosted(DocumentLine line) {
		return line.solution.constructObjectName(line.document.shortNamePosted + ' Subf.')
	}
	
	static def void doGenerate(DocumentLine line) {
		// Tables
		line.saveTable(line.tableName, line.doGenerateTable)
		line.saveTable(line.tableNamePosted, line.doGenerateTablePosted)
		
		// Pages
		line.savePage(line.subformPageName, line.doGenerateSubformPage)
		line.savePage(line.subformPageNamePosted, line.doGenerateSubformPagePosted)
	}
	
	static def doGenerateTable(DocumentLine line) '''
		«val solution = line.solution»
		«val document = line.document»
		table «management.newTableNo» «line.tableName.saveQuote»
		{
			Caption = '«line.tableName»';
			
		    fields
		    {
		        field(«management.getNewFieldNo(line)»; "Document No."; Code[20])
		        {
		            Caption = 'Document No.';
		            TableRelation = «document.header.tableName.saveQuote»;
		        }
		        field(«management.getNewFieldNo(line)»; "Line No."; Integer)
		        {
		            Caption = 'Line No.';
		        }
		        «IF line.hasTemplateOfType(TemplateDimensions)»
		        	field(«management.getNewFieldNo(line)»; "Dimension Set ID"; Integer)
		        	{
		        		Caption = 'Dimension Set ID';
		        		Editable = false;
		        		TableRelation = "Dimension Set Entry";
		        		
		        		trigger OnLookup()
		        		begin
		        			ShowDimensions();
		        		end;
		        		
		        		trigger OnValidate()
		        		begin
		        			DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
		        		end;
		        	}
		        «ENDIF»
		        «line.doGenerateTableFields»
		    }
		
		    keys
		    {
		        key(Key1; "Document No.", "Line No.")
		        {
		            Clustered = true;
		        }
		    }
		
		    var
		        «document.header.tableVariableName»: Record «document.header.tableName.saveQuote»;
		        «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		        StatusCheckSuspended: Boolean;
		        HideValidationDialog: Boolean;
		        RenameNotAllowedErr: Label 'You cannot rename a %1.';
		        «IF line.hasTemplateOfType(TemplateDimensions)»
		        	DimMgt: Codeunit DimensionManagement;
		        «ENDIF»
		
		    trigger OnRename()
		    begin
		        Error(RenameNotAllowedErr, TableCaption);
		    end;
		
		    trigger OnDelete()
		    begin
		        «solution.commentLineTableVariableName».SetRange("Document Type", «solution.commentLineTableVariableName»."Document Type"::«document.name.saveQuote»);
		        «solution.commentLineTableVariableName».SetRange("No.", "Document No.");
		        «solution.commentLineTableVariableName».SetRange("Line No.", "Line No.");
		        «solution.commentLineTableVariableName».DeleteAll();
		    end;
			
		    procedure TestStatus«document.initialStatus»()
		    begin
		        Get«document.header.tableVariableName»();
		        OnBeforeTestStatus«document.initialStatus»(Rec, «document.header.tableVariableName»);
		
		        if StatusCheckSuspended then
		            exit;
		
		        «document.header.tableVariableName».Testfield(Status, «document.header.tableVariableName».Status::«document.initialStatus»);
		
		        OnAfterTestStatus«document.initialStatus»(Rec, «document.header.tableVariableName»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeTestStatus«document.initialStatus»(var «line.tableVariableName»: Record «line.tableName.saveQuote»; var «document.header.tableVariableName»: Record «document.header.tableName.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterTestStatus«document.initialStatus»(var «line.tableVariableName»: Record «line.tableName.saveQuote»; var «document.header.tableVariableName»: Record «document.header.tableName.saveQuote»)
		    begin
		    end;
		
		    procedure SuspendStatusCheck(Suspend: Boolean)
		    begin
		        StatusCheckSuspended := Suspend;
		    end;
		
		    procedure Get«document.header.tableVariableName»()
		    var
		        IsHandled: Boolean;
		    begin
		        OnBeforeGet«document.header.tableVariableName»(Rec, «document.header.tableVariableName», IsHandled);
		        if IsHandled then
		            exit;
		
		        TestField("Document No.");
		        if "Document No." <> «document.header.tableVariableName»."No." then
		            «document.header.tableVariableName».Get("Document No.");
		
		        OnAfterGet«document.header.tableVariableName»(Rec, «document.header.tableVariableName»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeGet«document.header.tableVariableName»(var «line.tableVariableName»: Record «line.tableName.saveQuote»; var «document.header.tableVariableName»: Record «document.header.tableName.saveQuote»; var IsHanded: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterGet«document.header.tableVariableName»(var «line.tableVariableName»: Record «line.tableName.saveQuote»; var «document.header.tableVariableName»: Record «document.header.tableName.saveQuote»)
		    begin
		    end;
		
		    procedure InitRecord()
		    begin
		        Get«document.header.tableVariableName»;
				
				OnBeforeInitRecord(Rec, «document.header.tableVariableName»);
				
		        Init();
		        «FOR headerIncludeField : line.includeFields.filter[it.entity === document.header]»
		        	
		        	«IF headerIncludeField.validate == BoolInternal.TRUE»
		        		«FOR assignmentEntry : headerIncludeField.assignmentMap.entrySet»
		        			Validate(«assignmentEntry.key.saveQuote», «document.header.tableVariableName».«assignmentEntry.value.saveQuote»);
		        		«ENDFOR»
		        	«ELSE»
		        		«FOR assignmentEntry : headerIncludeField.assignmentMap.entrySet»
		        			«assignmentEntry.key.saveQuote» := «document.header.tableVariableName».«assignmentEntry.value.saveQuote»;
		        		«ENDFOR»
		        	«ENDIF»
				«ENDFOR»
				«IF line.hasTemplateOfType(TemplateDimensions) && document.header.hasTemplateOfType(TemplateDimensions)»
					"Shortcut Dimension 1 Code" := «document.header.tableVariableName»."Shortcut Dimension 1 Code";
					"Shortcut Dimension 2 Code" := «document.header.tableVariableName»."Shortcut Dimension 2 Code";
				«ENDIF»
				
				OnAfterInitRecord(Rec, «document.header.tableVariableName»);
		    end;
		    
		    [IntegrationEvent(false, false)]
		  	local procedure OnBeforeInitRecord(var «line.tableVariableName»: Record «line.tableName.saveQuote»; var «document.header.tableVariableName»: Record «document.header.tableName.saveQuote»)
		    begin
		    end;
		    
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterInitRecord(var «line.tableVariableName»: Record «line.tableName.saveQuote»; var «document.header.tableVariableName»: Record «document.header.tableName.saveQuote»)
		    begin
		    end;
		
		    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
		    begin
		        HideValidationDialog := NewHideValidationDialog;
		    end;
		
		    procedure GetHideValidationDialog(): Boolean
		    begin
		        exit(HideValidationDialog);
		    end;
		
		    procedure ShowLineComments()
		    var
		        «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		        «solution.commentSheetPageVariableName»: Page «solution.commentSheetPageName.saveQuote»;
		    begin
		        TestField("Document No.");
		        TestField("Line No.");
		        «solution.commentLineTableVariableName».SetRange("Document Type", «solution.commentLineTableVariableName»."Document Type"::«document.name.saveQuote»);
		        «solution.commentLineTableVariableName».SetRange("No.", "Document No.");
		        «solution.commentLineTableVariableName».SetRange("Document Line No.", "Line No.");
		        «solution.commentSheetPageVariableName».SetTableView(«solution.commentLineTableVariableName»);
		        «solution.commentSheetPageVariableName».RunModal;
		    end;
		    «IF line.hasTemplateOfType(TemplateDimensions)»
		    	
		    	procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
		    	begin
		    		OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
		    		DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
		    		OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
		    	end;
		    	
		    	[IntegrationEvent(false, false)]
		    	local procedure OnBeforeValidateShortcutDimCode(var «line.tableVariableName»: Record «line.tableName.saveQuote»; x«line.tableVariableName»: Record «line.tableName.saveQuote»; FieldNumber: Integer; var ShortcutDimCode: Code[20])
		    	begin
		    	end;
		    	
		    	[IntegrationEvent(false, false)]
		    	local procedure OnAfterValidateShortcutDimCode(var «line.tableVariableName»: Record «line.tableName.saveQuote»; x«line.tableVariableName»: Record «line.tableName.saveQuote»; FieldNumber: Integer; var ShortcutDimCode: Code[20])
		    	begin
		    	end;
		    	
		    	procedure ShowDimensions() IsChanged: Boolean
		    	var
		    		OldDimSetID: Integer;
		    	begin
		    		OldDimSetID := "Dimension Set ID";
		    		"Dimension Set ID" :=
		    			DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%2 %3', "Document No.", "Line No."));
		    		DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
		    		IsChanged := OldDimSetID <> "Dimension Set ID";
		    		
		    		OnAfterShowDimensions(Rec, xRec);
		    	end;
		    	
		    	[IntegrationEvent(false, false)]
		    	local procedure OnAfterShowDimensions(var «line.tableVariableName»: Record «line.tableName.saveQuote»; x«line.tableVariableName»: Record «line.tableName.saveQuote»)
		    	begin
		    	end;
		    «ENDIF»
		}
	'''
	
	static def doGenerateTablePosted(DocumentLine line) '''
		«management.resetFieldNo(line)»
		«val solution = line.solution»
		«val document = line.document»
		table «management.newTableNo» «line.tableNamePosted.saveQuote»
		{
			Caption = '«line.tableNamePosted»';
			
		    fields
		    {
		        field(«management.getNewFieldNo(line)»; "Document No."; Code[20])
		        {
		            Caption = 'Document No.';
		            TableRelation = «document.header.tableName.saveQuote»;
		        }
		        field(«management.getNewFieldNo(line)»; "Line No."; Integer)
		        {
		            Caption = 'Line No.';
		        }
		        «IF line.hasTemplateOfType(TemplateDimensions)»
		        	field(«management.getNewFieldNo(line)»; "Dimension Set ID"; Integer)
		        	{
		        		Caption = 'Dimension Set ID';
		        		Editable = false;
		        		TableRelation = "Dimension Set Entry";
		        		
		        		trigger OnLookup()
		        		begin
		        			ShowDimensions();
		        		end;
		        	}
		        «ENDIF»
		        «line.doGenerateTableFields»
		    }
		
		    keys
		    {
		        key(Key1; "Document No.", "Line No.")
		        {
		            Clustered = true;
		        }
		    }
		
		    var
		        «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		        «IF line.hasTemplateOfType(TemplateDimensions)»
		        	DimMgt: Codeunit DimensionManagement;
		        «ENDIF»
		
		    trigger OnDelete()
		    begin
		        «solution.commentLineTableVariableName».SetRange("Document Type", «solution.commentLineTableVariableName»."Document Type"::«document.namePosted.saveQuote»);
		        «solution.commentLineTableVariableName».SetRange("No.", "Document No.");
		        «solution.commentLineTableVariableName».SetRange("Line No.", "Line No.");
		        «solution.commentLineTableVariableName».DeleteAll();
		    end;
		    «IF line.hasTemplateOfType(TemplateDimensions)»
		    	
		    	procedure ShowDimensions()
		    	begin
		    		DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', TableCaption, "Document No.", "Line No."));
		    	end;
		    «ENDIF»
		    
			procedure ShowLineComments()
			var
				«solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
			begin
				«solution.commentLineTableVariableName».ShowComments(«solution.commentLineTableVariableName»."Document Type"::«document.namePosted.saveQuote», "Document No.", "Line No.");
			end;
		}
	'''
	
	static def doGenerateSubformPage(DocumentLine line) '''
		page «management.newPageNo» «line.subformPageName.saveQuote»
		{
		
		    AutoSplitKey = true;
		    Caption = 'Lines';
		    DelayedInsert = true;
		    LinksAllowed = false;
		    PageType = ListPart;
		    SourceTable = «line.tableName.saveQuote»;
		
		    layout
		    {
		        area(content)
		        {
		            repeater(Control1)
		            {
		                ShowCaption = false;
		                
		                field("Line No."; "Line No.")
		                {
		                	ApplicationArea = All;
		                	ToolTip = 'Specifies the number of the line.';
		                	Visible = false;
		                }
		                «FOR pageField : line.listPartPageFields»
		                	«pageField.doGenerate»
		                «ENDFOR»
		                «IF line.hasTemplateOfType(TemplateDimensions)»
		                	field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
		                	{
		                		ApplicationArea = All;
		                	}
		                	field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
		                	{
		                		ApplicationArea = All;
		                	}
		                «ENDIF»
		            }
		        }
		    }
		
		    actions
		    {
		        area(processing)
		        {
		            group("&Line")
		            {
		                Caption = '&Line';
		                Image = Line;
		                group("Related Information")
		                {
		                    Caption = 'Related Information';
		                    action("Co&mments")
		                    {
		                        ApplicationArea = Comments;
		                        Caption = 'Co&mments';
		                        Image = ViewComments;
		                        ToolTip = 'View or add comments for the record.';
		
		                        trigger OnAction()
		                        begin
		                            ShowLineComments;
		                        end;
		                    }
		                }
		            }
		        }
		    }
		}
	'''
	
	static def doGenerateSubformPagePosted(DocumentLine line) '''
		page «management.newPageNo» «line.subformPageNamePosted.saveQuote»
		{
		    AutoSplitKey = true;
		    Caption = 'Lines';
		    Editable = false;
		    LinksAllowed = false;
		    PageType = ListPart;
		    SourceTable = «line.tableNamePosted.saveQuote»;
		
		    layout
		    {
		        area(content)
		        {
		            repeater(Control1)
		            {
		                ShowCaption = false;
		                «FOR pageField : line.listPartPageFields»
		                	«pageField.doGenerate»
		                «ENDFOR»
		                «IF line.hasTemplateOfType(TemplateDimensions)»
		                	field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
		                	{
		                		ApplicationArea = All;
		                	}
		                	field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
		                	{
		                		ApplicationArea = All;
		                	}
		                «ENDIF»
		            }
		        }
		    }
		
		    actions
		    {
		        area(processing)
		        {
		            group("&Line")
		            {
		                Caption = '&Line';
		                Image = Line;
		                group("Related Information")
		                {
		                    Caption = 'Related Information';
		                    action("Co&mments")
		                    {
		                        ApplicationArea = Comments;
		                        Caption = 'Co&mments';
		                        Image = ViewComments;
		                        ToolTip = 'View or add comments for the record.';
		
		                        trigger OnAction()
		                        begin
		                            ShowLineComments;
		                        end;
		                    }
		                }
		            }
		        }
		    }
		}
	'''
	
}