package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.LedgerEntry

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class LedgerEntryExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	def static getNameRegister(LedgerEntry ledgerEntry) {
		return ledgerEntry.solution.master.name + ' Register'
	}
	
	def static getShortNameRegister(LedgerEntry ledgerEntry) {
		return ledgerEntry.solution.master.shortName + ' Register'
	}
	
	def static getTableNameRegister(LedgerEntry ledgerEntry) {
		var name = ledgerEntry.solution.constructObjectName(ledgerEntry.nameRegister)
		if(name.length > 30) {
			name = ledgerEntry.solution.constructObjectName(ledgerEntry.shortNameRegister)
		}
		return name
	}
	
	def static getNameJournal(LedgerEntry ledgerEntry) {
		return ledgerEntry.solution.master.name + ' Journal Line'
	}
	
	def static getShortNameJournal(LedgerEntry ledgerEntry) {
		return ledgerEntry.solution.master.shortName + ' Jnl. Line'
	}
	
	static def getCleanedShortNameJournal(LedgerEntry ledgerEntry) {
		return ledgerEntry.shortNameJournal.toOnlyAlphabetic.removeSpaces
	}
	
	def static getTableNameJournal(LedgerEntry ledgerEntry) {
		var name = ledgerEntry.solution.constructObjectName(ledgerEntry.nameJournal)
		if(name.length > 30) {
			name = ledgerEntry.solution.constructObjectName(ledgerEntry.shortNameJournal)
		}
		return name
	}
	
	static def getTableVariableNameJournal(LedgerEntry ledgerEntry) {
		return ledgerEntry.cleanedShortNameJournal
	}
	
	static def getListPageName(LedgerEntry ledgerEntry) {
		var name = ledgerEntry.solution.constructObjectName(ledgerEntry.name.replace('Entry', 'Entries'))
		if(name.length > 30) {
			name = ledgerEntry.solution.constructObjectName(ledgerEntry.shortName.replace('Entry', 'Entries'))
		}
		return name
	}
	
	def static doGenerate(LedgerEntry ledgerEntry) {
		// Tables
		ledgerEntry.saveTable(ledgerEntry.tableNameJournal, ledgerEntry.doGenerateTableJournal)
		ledgerEntry.saveTable(ledgerEntry.tableName, ledgerEntry.doGenerateTable)
		ledgerEntry.saveTable(ledgerEntry.tableNameRegister, ledgerEntry.doGenerateTableRegister)
		
		// Pages
	}
	
	def static doGenerateTable(LedgerEntry ledgerEntry) '''
		«management.resetFieldNo(ledgerEntry)»
		«val master = ledgerEntry.solution.master»
		«val document = ledgerEntry.solution.document»
		table «management.getNewTableNo(ledgerEntry)» «ledgerEntry.tableName.saveQuote»
		{
		    Caption = '«ledgerEntry.name»';
		    DrillDownPageID = «ledgerEntry.listPageName.saveQuote»;
		    LookupPageID = «ledgerEntry.listPageName.saveQuote»;
		
		    fields
		    {
		        field(«management.getNewFieldNo(ledgerEntry)»; "Entry No."; Integer)
		        {
		            Caption = 'Entry No.';
		        }
		        
		        field(«management.getNewFieldNo(ledgerEntry)»; "Posting Date"; Date)
		        {
		            Caption = 'Posting Date';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Document Date"; Date)
		        {
		            Caption = 'Document Date';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Document No."; Code[20])
		        {
		            Caption = 'Document No.';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; Description; Text[100])
		        {
		            Caption = 'Description';
		        }
				field(«management.getNewFieldNo(ledgerEntry)»; "Source No."; Code[20])
		        {
		            Caption = 'Source No.';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "«master.name» No."; Code[20])
		        {
		            Caption = '«master.name» No.';
		            TableRelation = «master.tableName.saveQuote»;
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "«document.name» No."; Code[20])
		        {
		            Caption = '«document.name» No.';
		        }
		        «ledgerEntry.doGenerateTableFields»
		        field(«management.getNewFieldNo(ledgerEntry)»; "Journal Batch Name"; Code[10])
		        {
		            Caption = 'Journal Batch Name';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Source Code"; Code[10])
		        {
		            Caption = 'Source Code';
		            Editable = false;
		            TableRelation = "Source Code";
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Reason Code"; Code[10])
		        {
		            Caption = 'Reason Code';
		            TableRelation = "Reason Code";
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "No. Series"; Code[10])
		        {
		            Caption = 'No. Series';
		            TableRelation = "No. Series";
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "User ID"; Code[50])
		        {
		            Caption = 'User ID';
		            DataClassification = EndUserIdentifiableInformation;
		            TableRelation = User."User Name";
		            ValidateTableRelation = false;
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Last Modified DateTime"; DateTime)
		        {
		            Caption = 'Last Modified DateTime';
		            Editable = false;
		        }
		    }
		
		    keys
		    {
		        key(Key1; "Entry No.")
		        {
		            Clustered = true;
		        }
		        key(Key2; "Document No.") {}
		    }
		
		    fieldgroups
		    {
		    }
		
		    trigger OnInsert()
		    begin
		        "Last Modified DateTime" := CurrentDateTime;
		    end;
		
		    trigger OnModify()
		    begin
		        "Last Modified DateTime" := CurrentDateTime;
		    end;
		
		    trigger OnRename()
		    begin
		        "Last Modified DateTime" := CurrentDateTime;
		    end;
		
		    procedure GetLastEntryNo(): Integer;
		    var
		        FindRecordManagement: Codeunit "Find Record Management";
		    begin
		        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
		    end;
		
		    procedure GetLastEntry(var LastEntryNo: Integer)
		    var
		        FindRecordManagement: Codeunit "Find Record Management";
		        FieldNoValues: List of [Integer];
		    begin
		        FieldNoValues.Add(FieldNo("Entry No."));
		        FindRecordManagement.GetLastEntryIntFieldValues(Rec, FieldNoValues);
		        LastEntryNo := FieldNoValues.Get(1);
		    end;
		
		    procedure CopyFrom«ledgerEntry.tableVariableNameJournal»(«ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»)
		    begin
		        "«master.name» No." := «ledgerEntry.tableVariableNameJournal»."«master.name» No.";
		        "Posting Date" := «ledgerEntry.tableVariableNameJournal»."Posting Date";
		        "Document Date" := «ledgerEntry.tableVariableNameJournal»."Document Date";
		        "Document No." := «ledgerEntry.tableVariableNameJournal»."Document No.";
		        Description := «ledgerEntry.tableVariableNameJournal».Description;
		        "Source No." := «ledgerEntry.tableVariableNameJournal»."Source No.";
		        "Journal Batch Name" := «ledgerEntry.tableVariableNameJournal»."Journal Batch Name";
		        "Source Code" := «ledgerEntry.tableVariableNameJournal»."Source Code";
		        "Reason Code" := «ledgerEntry.tableVariableNameJournal»."Reason Code";
		        "No. Series" := «ledgerEntry.tableVariableNameJournal»."Posting No. Series";
		
		        OnAfterCopy«ledgerEntry.tableVariableName»From«ledgerEntry.tableVariableNameJournal»(Rec, «ledgerEntry.tableVariableNameJournal»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterCopy«ledgerEntry.tableVariableName»From«ledgerEntry.tableVariableNameJournal»(var «ledgerEntry.tableVariableName»: Record «ledgerEntry.tableName.saveQuote»; var «ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»)
		    begin
		    end;
		}
	'''
	
	def static doGenerateTableJournal(LedgerEntry ledgerEntry) '''
		«management.resetFieldNo(ledgerEntry)»
		«val master = ledgerEntry.solution.master»
		«val document = ledgerEntry.solution.document»
		table «management.newTableNo» «ledgerEntry.tableNameJournal.saveQuote»
		{
		    Caption = '«ledgerEntry.nameJournal»';
		
		    fields
		    {
		        field(«management.getNewFieldNo(ledgerEntry)»; "Journal Template Name"; Code[10])
		        {
		            Caption = 'Journal Template Name';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Line No."; Integer)
		        {
		            Caption = 'Line No.';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Posting Date"; Date)
		        {
		            Caption = 'Posting Date';
		
		            trigger OnValidate()
		            begin
		                TestField("Posting Date");
		                Validate("Document Date", "Posting Date");
		            end;
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Document Date"; Date)
		        {
		            Caption = 'Document Date';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Document No."; Code[20])
		        {
		            Caption = 'Document No.';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; Description; Text[100])
		        {
		            Caption = 'Description';
		        }
		        
		        field(«management.getNewFieldNo(ledgerEntry)»; "Source No."; Code[20])
		        {
		            Caption = 'Source No.';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "«master.name» No."; Code[20])
		        {
		            Caption = '«master.name» No.';
		            TableRelation = «master.tableName.saveQuote»;
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "«document.name» No."; Code[20])
		        {
		            Caption = '«document.name» No.';
		        }
		        «ledgerEntry.doGenerateTableFields»
		        field(«management.getNewFieldNo(ledgerEntry)»; "Journal Batch Name"; Code[10])
		        {
		            Caption = 'Journal Batch Name';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Source Code"; Code[10])
		        {
		            Caption = 'Source Code';
		            Editable = false;
		            TableRelation = "Source Code";
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Reason Code"; Code[10])
		        {
		            Caption = 'Reason Code';
		            TableRelation = "Reason Code";
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Posting No. Series"; Code[10])
		        {
		            Caption = 'Posting No. Series';
		            TableRelation = "No. Series";
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Last Modified DateTime"; DateTime)
		        {
		            Caption = 'Last Modified DateTime';
		        }
		    }
		
		    keys
		    {
		        key(Key1; "Journal Batch Name", "Journal Template Name", "Line No.")
		        {
		            Clustered = true;
		        }
		    }
		
		    fieldgroups
		    {
		    }
		
		    trigger OnInsert()
		    begin
		        SetLastModifiedDateTime;
		    end;
		
		    trigger OnModify()
		    var
		        IsHandled: Boolean;
		    begin
		        SetLastModifiedDateTime;
		    end;
		
		    procedure EmptyLine() Result: Boolean
		    var
		        IsHandled: Boolean;
		    begin
		        OnBeforeEmptyLine(Rec, Result, IsHandled);
		        if IsHandled then
		            exit(Result);
		        exit("«master.name» No." = '');
		    end;
		
		    procedure GetNewLineNo(TemplateName: Code[10]; BatchName: Code[10]): Integer
		    var
		        «ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»;
		    begin
		        «ledgerEntry.tableVariableNameJournal».Validate("Journal Template Name", TemplateName);
		        «ledgerEntry.tableVariableNameJournal».Validate("Journal Batch Name", BatchName);
		        «ledgerEntry.tableVariableNameJournal».SetRange("Journal Template Name", TemplateName);
		        «ledgerEntry.tableVariableNameJournal».SetRange("Journal Batch Name", BatchName);
		        if «ledgerEntry.tableVariableNameJournal».FindLast then
		            exit(«ledgerEntry.tableVariableNameJournal»."Line No." + 10000);
		        exit(10000);
		    end;
		
		    local procedure SetLastModifiedDateTime()
		    var
		        DotNet_DateTimeOffset: Codeunit DotNet_DateTimeOffset;
		    begin
		        "Last Modified DateTime" := DotNet_DateTimeOffset.ConvertToUtcDateTime(CurrentDateTime);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeEmptyLine(«ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»; var Result: Boolean; var IsHandled: Boolean)
		    begin
		    end;
		}
	'''
	
	def static doGenerateTableRegister(LedgerEntry ledgerEntry) '''
		«management.resetFieldNo(ledgerEntry)»
		table «management.newTableNo» «ledgerEntry.tableNameRegister.saveQuote»
		{
		
		    Caption = '«ledgerEntry.nameRegister»';
		
		    fields
		    {
		        field(«management.getNewFieldNo(ledgerEntry)»; "No."; Integer)
		        {
		            Caption = 'No.';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "From Entry No."; Integer)
		        {
		            Caption = 'From Entry No.';
		            TableRelation = «ledgerEntry.tableName.saveQuote»;
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "To Entry No."; Integer)
		        {
		            Caption = 'To Entry No.';
		            TableRelation = «ledgerEntry.tableName.saveQuote»;
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Creation Date"; Date)
		        {
		            Caption = 'Creation Date';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Source Code"; Code[10])
		        {
		            Caption = 'Source Code';
		            TableRelation = "Source Code";
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "User ID"; Code[50])
		        {
		            Caption = 'User ID';
		            DataClassification = EndUserIdentifiableInformation;
		            TableRelation = User."User Name";
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Journal Batch Name"; Code[10])
		        {
		            Caption = 'Journal Batch Name';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; Reversed; Boolean)
		        {
		            Caption = 'Reversed';
		        }
		        field(«management.getNewFieldNo(ledgerEntry)»; "Creation Time"; Time)
		        {
		            Caption = 'Creation Time';
		        }
		    }
		
		    keys
		    {
		        key(Key1; "No.")
		        {
		            Clustered = true;
		        }
		        key(Key2; "Creation Date")
		        {
		        }
		        key(Key3; "Source Code", "Journal Batch Name", "Creation Date")
		        {
		        }
		    }
		
		    fieldgroups
		    {
		        fieldgroup(DropDown; "No.", "From Entry No.", "To Entry No.", "Creation Date", "Source Code")
		        {
		        }
		    }
		
		    procedure GetLastEntryNo(): Integer;
		    var
		        FindRecordManagement: Codeunit "Find Record Management";
		    begin
		        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("No.")))
		    end;
		
		    procedure Initialize(NextRegNo: Integer; FromEntryNo: Integer; SourceCode: Code[10]; BatchName: Code[10]; TemplateName: Code[10])
		    begin
		        Init;
		        "No." := NextRegNo;
		        "Creation Date" := Today;
		        "Creation Time" := Time;
		        "Source Code" := SourceCode;
		        "User ID" := UserId;
		        "From Entry No." := FromEntryNo;
		        "Journal Batch Name" := BatchName;
		        Clear(TemplateName);
		    end;
		}
	'''
	
}