package de.joneug.mdal.generator

import de.joneug.mdal.mdal.Solution

import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*

class SetupGenerator {

	static GeneratorManagement management = GeneratorManagement.getInstance()

	static def void doGenerateSetup(Solution solution) {
		// Table
		solution.logDebug("Generating setup table")
		solution.saveTable(solution.setupTableFileName, solution.doGenerateSetupTable)

		// Page
		solution.logDebug("Generating setup page")
		solution.savePage(solution.setupPageFileName, solution.doGenerateSetupPage)
	}

	static def doGenerateSetupTable(Solution solution) '''
		table «management.getNewTableNo()» "«solution.setupTableName»"
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
		        field(3; "Seminar Registration Nos."; Code[20])
		        {
		            Caption = 'Seminar Registration Nos.';
		            TableRelation = "No. Series";
		        }
		        field(4; "Posted Seminar Reg. Nos."; Code[20])
		        {
		            Caption = 'Posted Seminar Reg. Nos.';
		            TableRelation = "No. Series";
		        }
		        field(10; "Copy Comments"; Boolean)
		        {
		            AccessByPermission = TableData "SEM Posted Seminar Reg. Header" = R;
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
		page «management.getNewPageNo()» "«solution.setupPageName»"
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
		
		                field(CopyComments; "Copy Comments")
		                {
		                    ApplicationArea = All;
		                }
		            }
		            group("Number Series")
		            {
		                Caption = 'Number Series';
		
		                field("«solution.master.cleanedName» Nos."; "«solution.master.cleanedName» Nos.")
		                {
		                    ApplicationArea = All;
		                }
		                field(SeminarRegistrationNos; "Seminar Registration Nos.")
		                {
		                    ApplicationArea = All;
		                }
		                field(PostedSeminarRegNos; "Posted Seminar Reg. Nos.")
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

}
