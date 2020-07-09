package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.Solution

import static extension de.joneug.mdal.extensions.DocumentExtensions.*
import static extension de.joneug.mdal.extensions.DocumentHeaderExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.LedgerEntryExtensions.*
import static extension de.joneug.mdal.extensions.MasterExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*
import static extension de.joneug.mdal.extensions.SupplementalExtensions.*

/**
 * This is an extension library for all {@link Solution objects}.
 */
class SolutionExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()

	static def getInferredPrefix(Solution solution) {
		if (solution.prefix.isNullOrEmpty) {
			return solution.master.shortName.toOnlyAlphabetic.toUpperCase
		} else {
			return solution.prefix
		}
	}

	static def String constructObjectName(Solution solution, String objectName) {
		return solution.inferredPrefix + ' ' + objectName
	}
	 
	static def doGenerate(Solution solution) {
		solution.logInfo('''Generating solution "«solution.name»"''')
		management.reset()
		management.readAppJson()
		management.readSymbolReferences()
		
		// Setup
		solution.logInfo("Generating setup files")
		solution.doGenerateSetup
		
		// Comments
		solution.doGenerateCommentObjects
		
		// Source Code Setup
		solution.doGenerateSourceCodeSetupObjects
		
		// Master
		solution.logInfo("Generating master files")
		solution.master.doGenerate
		
		// Supplementals
		solution.supplementals.forEach[it.doGenerate]
		
		// Document
		solution.document.doGenerate
		
		// Ledger Entry
		solution.ledgerEntry.doGenerate
	}
	
	/*
	 * Setup
	 */
	static def String getSetupTableName(Solution solution) {
		return solution.constructObjectName(solution.master.name + ' Setup')
	}

	static def String getSetupTableVariableName(Solution solution) {
		return solution.master.cleanedShortName + 'Setup'
	}
	
	static def String getSetupPageName(Solution solution) {
		return solution.constructObjectName(solution.master.name + ' Setup')
	}

	static def void doGenerateSetup(Solution solution) {
		// Table
		solution.logDebug("Generating setup table")
		solution.saveTable(solution.setupTableName, solution.doGenerateSetupTable)

		// Page
		solution.logDebug("Generating setup page")
		solution.savePage(solution.setupPageName, solution.doGenerateSetupPage)
	}

	static def doGenerateSetupTable(Solution solution) '''
		table «management.newTableNo» "«solution.setupTableName»"
		{
		    Caption = '«solution.master.name» Setup';
		    DrillDownPageID = "«solution.setupPageName»";
		    LookupPageID = "«solution.setupPageName»";
		
		    fields
		    {
		        field(1; "Primary Key"; Code[10])
		        {
		            Caption = 'Primary Key';
		        }
		        field(2; "«solution.master.cleanedName» Nos."; Code[20])
		        {
		            Caption = '«solution.master.cleanedName» Nos.';
		            TableRelation = "No. Series";
		        }
		        field(3; "«solution.document.shortName» Nos."; Code[20])
		        {
		            Caption = '«solution.document.shortName» Nos.';
		            TableRelation = "No. Series";
		        }
		        field(4; "«solution.document.shortNamePosted» Nos."; Code[20])
		        {
		            Caption = '«solution.document.shortNamePosted» Nos.';
		            TableRelation = "No. Series";
		        }
		        field(10; "Copy Comments"; Boolean)
		        {
		            AccessByPermission = TableData «solution.document.header.tableNamePosted.saveQuote» = R;
		            Caption = 'Copy Comments To Posted Reg.';
		            InitValue = true;
		        }
		    }
		
		    keys
		    {
		        key(Key1; "Primary Key")
		        {
		            Clustered = true;
		        }
		    }
		
		    var
		        RecordHasBeenRead: Boolean;
		
		    procedure GetRecordOnce()
		    begin
		        if RecordHasBeenRead then
		            exit;
		        Get;
		        RecordHasBeenRead := true;
		    end;
		}
	'''

	static def doGenerateSetupPage(Solution solution) '''
		page «management.newPageNo» "«solution.setupPageName»"
		{
		    ApplicationArea = All;
		    Caption = '«solution.master.name» Setup';
		    DeleteAllowed = false;
		    InsertAllowed = false;
		    PageType = Card;
		    SourceTable = "«solution.setupTableName»";
		    UsageCategory = Administration;
		
		    layout
		    {
		        area(content)
		        {
		            group(General)
		            {
		                Caption = 'General';
		
		                field("Copy Comments"; "Copy Comments")
		                {
		                    ApplicationArea = All;
		                }
		            }
		            group("Number Series")
		            {
		                Caption = 'Number Series';
		
		                field("«solution.master.name» Nos."; "«solution.master.name» Nos.")
		                {
		                    ApplicationArea = All;
		                }
		                field("«solution.document.shortName» Nos."; "«solution.document.shortName» Nos.")
		                {
		                    ApplicationArea = All;
		                }
		                field("«solution.document.shortNamePosted» Nos."; "«solution.document.shortNamePosted» Nos.")
		                {
		                    ApplicationArea = All;
		                }
		            }
		        }
		    }
		
		    actions
		    {
		    }
		
		    trigger OnOpenPage()
		    begin
		        Reset();
		        if not Get() then begin
		            Init();
		            Insert();
		        end;
		    end;
		}
	'''
	
	/*
	 * Comments
	 */
	
	static def void doGenerateCommentObjects(Solution solution) {
		solution.saveEnumExt(solution.commentLineTableNameEnumExtName, solution.doGenerateCommentLineTableNameEnumExt)
		solution.saveEnum(solution.commentDocumentTypeEnumName, solution.doGenerateCommentDocumentTypeEnum)
		solution.saveTableExt(solution.commentLineTableExtName, solution.doGenerateCommentLineTableExtName)
		solution.saveTable(solution.commentLineTableName, solution.doGenerateCommentLineTable)
		solution.savePage(solution.commentListPageName, solution.doGenerateCommentListPage)
		solution.savePage(solution.commentSheetPageName, solution.doGenerateCommentSheetPage)
	}
	
	static def getCommentLineTableNameEnumExtName(Solution solution) {
		return solution.constructObjectName('Comment Line Table Name Ext')
	}
	
	static def doGenerateCommentLineTableNameEnumExt(Solution solution) '''
		enumextension «management.newEnumExtNo» «solution.commentLineTableNameEnumExtName.saveQuote» extends "Comment Line Table Name"
		{
			value(50000; "«solution.master.cleanedName»") { }
		}
	'''
	
	static def getCommentLineTableExtName(Solution solution) {
		return solution.constructObjectName('Comment Line Ext')
	}
	
	static def doGenerateCommentLineTableExtName(Solution solution) '''
		tableextension «management.newTableExtNo» «solution.commentLineTableExtName.saveQuote» extends "Comment Line"
		{
			fields
			{
				modify("No.")
				{
					TableRelation = if ("Table Name" = const(«solution.master.name»)) «solution.master.tableName.saveQuote»;
				}
			}
		}
	'''
	
	static def getCommentDocumentTypeEnumName(Solution solution) {
		return solution.constructObjectName(solution.master.name + ' Comment Document Type')
	}
	
	static def doGenerateCommentDocumentTypeEnum(Solution solution) '''
		«val document = solution.document»
		enum «management.newEnumNo» «solution.commentDocumentTypeEnumName.saveQuote»
		{
			Extensible = true;
			
			value(0; «document.name.saveQuote») { Caption = '«document.name»'; }
			value(1; «document.namePosted.saveQuote») { Caption = '«document.namePosted»'; }
		}
	'''
	
	static def getCommentLineTableName(Solution solution) {
		return solution.constructObjectName(solution.master.name + ' Comment Line')
	}
	
	static def getCommentLineTableVariableName(Solution solution) {
		return solution.master.cleanedShortName + 'CommentLine'
	}
	
	static def doGenerateCommentLineTable(Solution solution) '''
		table «management.newTableNo» «solution.commentLineTableName.saveQuote»
		{
		    Caption = '«solution.master.name» Comment Line';
		    DrillDownPageID = «solution.commentListPageName.saveQuote»;
		    LookupPageID = «solution.commentListPageName.saveQuote»;
		
		    fields
		    {
		        field(1; "Document Type"; Enum "«solution.commentDocumentTypeEnumName»")
		        {
		            Caption = 'Document Type';
		        }
		        field(2; "No."; Code[20])
		        {
		            Caption = 'No.';
		        }
		        field(3; "Line No."; Integer)
		        {
		            Caption = 'Line No.';
		        }
		        field(4; "Date"; Date)
		        {
		            Caption = 'Date';
		        }
		        field(5; "Code"; Code[10])
		        {
		            Caption = 'Code';
		        }
		        field(6; Comment; Text[80])
		        {
		            Caption = 'Comment';
		        }
		        field(7; "Document Line No."; Integer)
		        {
		            Caption = 'Document Line No.';
		        }
		    }
		
		    keys
		    {
		        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
		        {
		            Clustered = true;
		        }
		    }
		
		    fieldgroups
		    {
		    }
		
		    procedure SetUpNewLine()
		    var
		        «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		    begin
		        «solution.commentLineTableVariableName».SetRange("Document Type", "Document Type");
		        «solution.commentLineTableVariableName».SetRange("No.", "No.");
		        «solution.commentLineTableVariableName».SetRange("Document Line No.", "Document Line No.");
		        «solution.commentLineTableVariableName».SetRange(Date, WorkDate);
		        if not «solution.commentLineTableVariableName».FindFirst then
		            Date := WorkDate;
		
		        OnAfterSetUpNewLine(Rec, «solution.commentLineTableVariableName»);
		    end;
		
		    procedure CopyComments(FromDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; ToDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; FromNumber: Code[20]; ToNumber: Code[20])
		    var
		        «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		        «solution.commentLineTableVariableName»2: Record «solution.commentLineTableName.saveQuote»;
		        IsHandled: Boolean;
		    begin
		        IsHandled := false;
		        OnBeforeCopyComments(«solution.commentLineTableVariableName», ToDocumentType, IsHandled, FromDocumentType, FromNumber, ToNumber);
		        if IsHandled then
		            exit;
		
		        «solution.commentLineTableVariableName».SetRange("Document Type", FromDocumentType);
		        «solution.commentLineTableVariableName».SetRange("No.", FromNumber);
		        if «solution.commentLineTableVariableName».FindSet() then
		            repeat
		                «solution.commentLineTableVariableName»2 := «solution.commentLineTableVariableName»;
		                «solution.commentLineTableVariableName»2."Document Type" := ToDocumentType;
		                «solution.commentLineTableVariableName»2."No." := ToNumber;
		                «solution.commentLineTableVariableName»2.Insert();
		            until «solution.commentLineTableVariableName».Next() = 0;
		    end;
		
		    procedure CopyLineComments(FromDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; ToDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; FromNumber: Code[20]; ToNumber: Code[20]; FromDocumentLineNo: Integer; ToDocumentLineNo: Integer)
		    var
		        «solution.commentLineTableVariableName»Source: Record «solution.commentLineTableName.saveQuote»;
		        «solution.commentLineTableVariableName»Target: Record «solution.commentLineTableName.saveQuote»;
		        IsHandled: Boolean;
		    begin
		        IsHandled := false;
		        OnBeforeCopyLineComments(
		          «solution.commentLineTableVariableName»Target, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber, FromDocumentLineNo, ToDocumentLineNo);
		        if IsHandled then
		            exit;
		
		        «solution.commentLineTableVariableName»Source.SetRange("Document Type", FromDocumentType);
		        «solution.commentLineTableVariableName»Source.SetRange("No.", FromNumber);
		        «solution.commentLineTableVariableName»Source.SetRange("Document Line No.", FromDocumentLineNo);
		        if «solution.commentLineTableVariableName»Source.FindSet() then
		            repeat
		                «solution.commentLineTableVariableName»Target := «solution.commentLineTableVariableName»Source;
		                «solution.commentLineTableVariableName»Target."Document Type" := ToDocumentType;
		                «solution.commentLineTableVariableName»Target."No." := ToNumber;
		                «solution.commentLineTableVariableName»Target."Document Line No." := ToDocumentLineNo;
		                «solution.commentLineTableVariableName»Target.Insert();
		            until «solution.commentLineTableVariableName»Source.Next() = 0;
		    end;
		
		    procedure CopyHeaderComments(FromDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; ToDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; FromNumber: Code[20]; ToNumber: Code[20])
		    var
		        «solution.commentLineTableVariableName»Source: Record «solution.commentLineTableName.saveQuote»;
		        «solution.commentLineTableVariableName»Target: Record «solution.commentLineTableName.saveQuote»;
		        IsHandled: Boolean;
		    begin
		        IsHandled := false;
		        OnBeforeCopyHeaderComments(«solution.commentLineTableVariableName»Target, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber);
		        if IsHandled then
		            exit;
		
		        «solution.commentLineTableVariableName»Source.SetRange("Document Type", FromDocumentType);
		        «solution.commentLineTableVariableName»Source.SetRange("No.", FromNumber);
		        «solution.commentLineTableVariableName»Source.SetRange("Document Line No.", 0);
		        if «solution.commentLineTableVariableName»Source.FindSet() then
		            repeat
		                «solution.commentLineTableVariableName»Target := «solution.commentLineTableVariableName»Source;
		                «solution.commentLineTableVariableName»Target."Document Type" := ToDocumentType;
		                «solution.commentLineTableVariableName»Target."No." := ToNumber;
		                «solution.commentLineTableVariableName»Target.Insert();
		            until «solution.commentLineTableVariableName»Source.Next() = 0;
		    end;
		
		    procedure DeleteComments(DocType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; DocNo: Code[20])
		    begin
		        SetRange("Document Type", DocType);
		        SetRange("No.", DocNo);
		        if not IsEmpty then
		            DeleteAll();
		    end;
		
		    procedure ShowComments(DocType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; DocNo: Code[20]; DocLineNo: Integer)
		    var
		        «solution.commentSheetPageVariableName»: Page «solution.commentSheetPageName.saveQuote»;
		    begin
		        SetRange("Document Type", DocType);
		        SetRange("No.", DocNo);
		        SetRange("Document Line No.", DocLineNo);
		        Clear(«solution.commentSheetPageVariableName»);
		        «solution.commentSheetPageVariableName».SetTableView(Rec);
		        «solution.commentSheetPageVariableName».RunModal;
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterSetUpNewLine(var «solution.commentLineTableVariableName»Rec: Record «solution.commentLineTableName.saveQuote»; var «solution.commentLineTableVariableName»Filter: Record «solution.commentLineTableName.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeCopyComments(var «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»; ToDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; var IsHandled: Boolean; FromDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; FromNumber: Code[20]; ToNumber: Code[20])
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeCopyLineComments(var «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»; var IsHandled: Boolean; FromDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; ToDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; FromNumber: Code[20]; ToNumber: Code[20]; FromDocumentLineNo: Integer; ToDocumentLine: Integer)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeCopyHeaderComments(var «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»; var IsHandled: Boolean; FromDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; ToDocumentType: Enum «solution.commentDocumentTypeEnumName.saveQuote»; FromNumber: Code[20]; ToNumber: Code[20])
		    begin
		    end;
		}
	'''
	
	static def getCommentListPageName(Solution solution) {
		return solution.constructObjectName(solution.master.name + ' Comment List')
	}
	
	static def doGenerateCommentListPage(Solution solution) '''
		page «management.newPageNo» «solution.commentListPageName.saveQuote»
		{
		    Caption = 'Comment List';
		    DataCaptionFields = "No.";
		    Editable = false;
		    LinksAllowed = false;
		    PageType = List;
		    SourceTable = «solution.commentLineTableName.saveQuote»;
		
		    layout
		    {
		        area(content)
		        {
		            repeater(Control1)
		            {
		                ShowCaption = false;
		                field("No."; "No.")
		                {
		                    ApplicationArea = Comments;
		                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
		                }
		                field("Date"; Date)
		                {
		                    ApplicationArea = Comments;
		                    ToolTip = 'Specifies the date the comment was created.';
		                }
		                field(Comment; Comment)
		                {
		                    ApplicationArea = Comments;
		                    ToolTip = 'Specifies the comment itself.';
		                }
		            }
		        }
		    }
		
		    actions
		    {
		    }
		}
	'''
	
	static def getCommentSheetPageName(Solution solution) {
		return solution.constructObjectName(solution.master.name + ' Comment Sheet')
	}
	
	static def getCommentSheetPageVariableName(Solution solution) {
		return solution.master.cleanedShortName + 'CommentSheet'
	}
	
	static def doGenerateCommentSheetPage(Solution solution) '''
		page «management.newPageNo» «solution.commentSheetPageName.saveQuote»
		{
		    AutoSplitKey = true;
		    Caption = 'Comment Sheet';
		    DataCaptionFields = "No.";
		    DelayedInsert = true;
		    LinksAllowed = false;
		    MultipleNewLines = true;
		    PageType = List;
		    SourceTable = «solution.commentLineTableName.saveQuote»;
		
		    layout
		    {
		        area(content)
		        {
		            repeater(Control1)
		            {
		                ShowCaption = false;
		                field("Date"; Date)
		                {
		                    ApplicationArea = Comments;
		                    ToolTip = 'Specifies the date the comment was created.';
		                }
		                field(Comment; Comment)
		                {
		                    ApplicationArea = Comments;
		                    ToolTip = 'Specifies the comment itself.';
		                }
		                field("Code"; Code)
		                {
		                    ApplicationArea = Comments;
		                    ToolTip = 'Specifies a code for the comment.';
		                    Visible = false;
		                }
		            }
		        }
		    }
		
		    actions
		    {
		    }
		
		    trigger OnNewRecord(BelowxRec: Boolean)
		    begin
		        SetUpNewLine;
		    end;
		}
	'''
	
	/*
	 * Source Code Setup
	 */
	
	static def doGenerateSourceCodeSetupObjects(Solution solution) {
		solution.saveTableExt(solution.sourceCodeSetupTableExtName, solution.doGenerateSourceCodeSetupTableExt)
	}
	
	static def getSourceCodeSetupTableExtName(Solution solution) {
		return solution.constructObjectName('Source Code Setup Ext')
	}
	
	static def doGenerateSourceCodeSetupTableExt(Solution solution) '''
		«val document = solution.document»
		tableextension «management.newTableExtNo» «solution.sourceCodeSetupTableExtName.saveQuote» extends "Source Code Setup"
		{
		    fields
		    {
		        field(50000; «document.name.saveQuote»; Code[10])
		        {
		            Caption = '«document.name»';
		            TableRelation = "Source Code";
		        }
		    }
		}
	'''
	
}
