package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.Solution

import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.MasterExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
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
	
	/*
	 * Generator extensions
	 */
	 
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
		
		// Supplemental
		solution.supplementals.forEach[it.doGenerate]
		
		// Document
		
		// Journal
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
	
	/*
	 * Comments
	 */
	
	static def void doGenerateCommentObjects(Solution solution) {
		solution.saveEnumExt(solution.commentLineTableNameEnumExtName, solution.doGenerateCommentLineTableNameEnumExt)
		solution.saveEnum(solution.commentDocumentTypeEnumName, solution.doGenerateCommentDocumentTypeEnum)
		solution.saveTableExt(solution.commentLineTableExtName, solution.doGenerateCommentLineTableExtName)
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
	
	static def getCommentDocumentTypeEnumName(Solution solution) {
		return solution.constructObjectName(solution.master.name + ' Comment Document Type')
	}
	
	static def doGenerateCommentDocumentTypeEnum(Solution solution) '''
		«val document = solution.document»
		enum «management.newEnumNo» «solution.commentDocumentTypeEnumName.saveQuote»
		{
			Extensible = true;
			
			value(0; «document.header.name.saveQuote») { Caption = '«document.header.name»'; }
			value(1; "Posted «document.header.name»") { Caption = 'Posted «document.header.name»'; }
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
		        field(50000; "«solution.document.header.tableName»"; Code[10])
		        {
		            Caption = '«document.header.name»';
		            TableRelation = "Source Code";
		        }
		    }
		}
	'''
	
	
	

}
