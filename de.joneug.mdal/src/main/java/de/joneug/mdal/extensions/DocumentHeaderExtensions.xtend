package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.BoolInternal
import de.joneug.mdal.mdal.Document
import de.joneug.mdal.mdal.DocumentHeader
import de.joneug.mdal.mdal.Supplemental
import de.joneug.mdal.mdal.TemplateAddress
import de.joneug.mdal.mdal.TemplateDimensions
import de.joneug.mdal.mdal.TemplateSalesperson

import static extension de.joneug.mdal.extensions.DocumentExtensions.*
import static extension de.joneug.mdal.extensions.DocumentLineExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class DocumentHeaderExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def getDocument(DocumentHeader header) {
		return header.getContainerOfType(Document)
	}
	
	static def getTableName(DocumentHeader header) {
		return header.solution.constructObjectName(header.shortName)
	}
	
	static def getNamePosted(DocumentHeader header) {
		return 'Posted ' + header.name
	}
	
	static def getShortNamePosted(DocumentHeader header) {
		return 'Posted ' + header.shortName
	}
	
	static def getCleanedNamePosted(DocumentHeader header) {
		return header.namePosted.toOnlyAlphabetic.removeSpaces
	}
	
	static def getCleanedShortNamePosted(DocumentHeader header) {
		return header.shortNamePosted.toOnlyAlphabetic.removeSpaces
	}

	static def getTableNamePosted(DocumentHeader header) {
		var name = header.solution.constructObjectName(header.namePosted)
		if(name.length > 30) {
			name = header.solution.constructObjectName(header.shortNamePosted)
		}
		return name
	}
	
	static def getTableVariableNamePosted(DocumentHeader header) {
		return header.cleanedShortNamePosted
	}
	
	static def void doGenerate(DocumentHeader header) {
		// Tables
		header.saveTable(header.tableName, header.doGenerateTable)
		header.saveTable(header.tableNamePosted, header.doGenerateTablePosted)
	}
	
	static def doGenerateTable(DocumentHeader header) '''
		«val solution = header.solution»
		«val document = header.document»
		«val master = header.solution.master»
		table «management.newTableNo» «header.tableName.saveQuote»
		{
		    Caption = '«header.name»';
		    DataCaptionFields = "No.";
		    LookupPageId = «document.documentPageName.saveQuote»;
		
		    fields
		    {
		        field(«management.getNewFieldNo(header)»; "No."; Code[20])
		        {
		            Caption = 'No.';
		
		            trigger OnValidate()
		            begin
		                if "No." <> xRec."No." then begin
		                    Get«solution.setupTableVariableName»();
		                    NoSeriesMgt.TestManual(«solution.setupTableVariableName»."«document.shortName» Nos.");
		                    "No. Series" := '';
		                end;
		            end;
		        }
		        field(«management.getNewFieldNo(header)»; "«master.name» No."; Code[20])
		        {
		            Caption = '«master.name» No.';
		            TableRelation = «master.tableName.saveQuote»;
		
		            trigger OnValidate()
		            begin
		                if "No." = '' then
		                    InitRecord;
		
		                TestStatus«document.initialStatus»();
		                if ("«master.name» No." <> xRec."«master.name» No.") and (xRec."«master.name» No." <> '') then begin
		                    if GetHideValidationDialog or not GuiAllowed then
		                        Confirmed := true
		                    else
		                        Confirmed := Confirm(ConfirmChangeQst, false, FieldCaption("«master.name» No."));
		
		                    if Confirmed then begin
		                        «document.line.tableVariableName».SetRange("Document No.", "No.");
		                        if "«master.name» No." = '' then begin
		                            if not «document.line.tableVariableName».IsEmpty then
		                                Error(ExistingLinesErr, FieldCaption("«master.name» No."));
		                            Init();
		                            OnValidate«master.tableVariableName»NoAfterInit(Rec, xRec);
		                            Get«solution.setupTableVariableName»();
		                            "No. Series" := xRec."No. Series";
		                            InitRecord();
		                            InitNoSeries();
		                            exit;
		                        end;
		
		                        «document.line.tableVariableName».Reset();
		                    end else begin
		                        Rec := xRec;
		                        exit;
		                    end;
		                end;
		
		                Get«master.tableVariableName»("«master.name» No.");
		                «master.tableVariableName».TestBlocked();
		                OnAfterCheck«master.tableVariableName»No(Rec, xRec, «master.tableVariableName»);
		                
		                «FOR masterIncludeField : header.includeFields.filter[it.entity === master]»
		                	«IF masterIncludeField.validate == BoolInternal.TRUE»
		                		VALIDATE(«masterIncludeField.name.saveQuote», «master.tableVariableName».«masterIncludeField.fieldName.saveQuote»);
		                	«ELSE»
		                		«masterIncludeField.name.saveQuote» := «master.tableVariableName».«masterIncludeField.fieldName.saveQuote»;
		                	«ENDIF»
						«ENDFOR»
		            end;
		        }
		        field(«management.getNewFieldNo(header)»; Status; Enum «document.statusEnumName.saveQuote»)
		        {
		            Caption = 'Status';
		            Editable = false;
		        }
		        
		        field(«management.getNewFieldNo(header)»; Comment; Boolean)
		        {
		            Caption = 'Comment';
		            FieldClass = FlowField;
		            Editable = false;
		            CalcFormula = exist («solution.commentLineTableName.saveQuote» where("No." = field("No."), "Document Line No." = const(0)));
		        }
		        field(«management.getNewFieldNo(header)»; "No. Printed"; Integer)
		        {
		            Caption = 'No. Printed';
		            Editable = false;
		        }
		        field(«management.getNewFieldNo(header)»; "Posting Date"; Date)
		        {
		            Caption = 'Posting Date';
		
		            trigger OnValidate()
		            var
		                IsHandled: Boolean;
		            begin
		                TestField("Posting Date");
		                TestNoSeriesDate("Posting No.", "Posting No. Series",
		                    FieldCaption("Posting No."), FieldCaption("Posting No. Series"));
		
		                IsHandled := false;
		                OnValidatePostingDateOnBeforeAssignDocumentDate(Rec, IsHandled);
		                if not IsHandled then
		                    Validate("Document Date", "Posting Date");
		            end;
		        }
		        field(«management.getNewFieldNo(header)»; "Document Date"; Date)
		        {
		            Caption = 'Document Date';
		        }
		        field(«management.getNewFieldNo(header)»; "Posting Description"; Text[100])
		        {
		            Caption = 'Posting Description';
		        }
		        field(«management.getNewFieldNo(header)»; "External Document No."; Code[35])
		        {
		            Caption = 'External Document No.';
		        }
		        field(«management.getNewFieldNo(header)»; "Reason Code"; Code[10])
		        {
		            Caption = 'Reason Code';
		            TableRelation = "Reason Code";
		        }
		        field(«management.getNewFieldNo(header)»; "No. Series"; Code[20])
		        {
		            Caption = 'No. Series';
		            Editable = false;
		            TableRelation = "No. Series";
		        }
		        field(«management.getNewFieldNo(header)»; "Posting No."; Code[20])
		        {
		            Caption = 'Posting No.';
		        }
		        field(«management.getNewFieldNo(header)»; "Posting No. Series"; Code[20])
		        {
		            Caption = 'Posting No. Series';
		            TableRelation = "No. Series";
		
		            trigger OnLookup()
		            begin
		                with «header.tableVariableName» do begin
		                    «header.tableVariableName» := Rec;
		                    Get«solution.setupTableVariableName»();
		                    TestNoSeries();
		                    if NoSeriesMgt.LookupSeries(GetPostingNoSeriesCode, "Posting No. Series") then
		                        Validate("Posting No. Series");
		                    Rec := «header.tableVariableName»;
		                end;
		            end;
		
		            trigger OnValidate()
		            begin
		                if "Posting No. Series" <> '' then begin
		                    Get«solution.setupTableVariableName»();
		                    TestNoSeries();
		                    NoSeriesMgt.TestSeries(GetPostingNoSeriesCode, "Posting No. Series");
		                end;
		                TestField("Posting No.", '');
		            end;
		        }
		        field(«management.getNewFieldNo(header)»; "Last Posting No."; Code[20])
		        {
		            Caption = 'Last Posting No.';
		            Editable = false;
		            TableRelation = «header.tableNamePosted.saveQuote»;
		        }
		        «IF header.hasTemplateOfType(TemplateDimensions)»
		        	field(«management.getNewFieldNo(header)»; "Dimension Set ID"; Integer)
		        	{
		        		Caption = 'Dimension Set ID';
		        		Editable = false;
		        		TableRelation = "Dimension Set Entry";
		        		
		        		trigger OnLookup()
		        		begin
		        			ShowDocDim;
		        		end;
		        		
		        		trigger OnValidate()
		        		begin
		        			DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
		        		end;
		        	}
		        «ENDIF»
		        «IF header.includeFields.exists[it.entity instanceof Supplemental && it.field == 'Code']»
		        	«val supplementalIncludeField = header.includeFields.filter[it.entity instanceof Supplemental && it.field == 'Code'].get(0)»
		        	field(«management.getNewFieldNo(header)»; «supplementalIncludeField.name.saveQuote»; Code[10])
		        	{
		        		Caption = '«supplementalIncludeField.name»';
		        		TableRelation = «supplementalIncludeField.entity.tableName.saveQuote»;
		        		
		        		trigger OnValidate()
		        		begin
		        			Test«document.initialStatus»Planning();
		        			if («supplementalIncludeField.name.saveQuote» <> xRec.«supplementalIncludeField.name.saveQuote») and (xRec.«supplementalIncludeField.name.saveQuote» <> '') then begin
		        				if GetHideValidationDialog or not GuiAllowed then
		        					Confirmed := true
		        				else
		        					Confirmed := Confirm(ConfirmChangeQst, false, FieldCaption(«supplementalIncludeField.name.saveQuote»));
		        				
		        				if Confirmed then begin
		        					if «supplementalIncludeField.name.saveQuote» = '' then
		        						exit;
		        				end else begin
		        					Rec := xRec;
		        					exit;
		        				end;
		        			end;
		        			
		        			If «supplementalIncludeField.name.saveQuote» = '' then
		        				«supplementalIncludeField.entity.tableVariableName».Init()
		        			else begin
		        			Get(«supplementalIncludeField.name.saveQuote»);
		        				«supplementalIncludeField.entity.tableVariableName».TestBlocked;
		        			end;
		        			
		        			«FOR supplementalIncludeField2 : header.includeFields.filter[it.entity === supplementalIncludeField.entity]»
		        				«IF supplementalIncludeField2.validate == BoolInternal.TRUE»
		        					VALIDATE(«supplementalIncludeField2.name.saveQuote», «supplementalIncludeField2.entity.tableVariableName».«supplementalIncludeField2.fieldName.saveQuote»);
			                	«ELSE»
			                		«supplementalIncludeField2.name.saveQuote» := «supplementalIncludeField2.entity.tableVariableName».«supplementalIncludeField2.fieldName.saveQuote»;
			                	«ENDIF»
							«ENDFOR»
		        		end;
		        	}
		        «ENDIF»
		        «header.doGenerateTableFields»
		    }
		
		    keys
		    {
		        key(Key1; "No.")
		        {
		            Clustered = true;
		        }
		        key(Key2; "«master.name» No.") { }
		    }
		
		    var
		    	NoSeriesMgt: Codeunit NoSeriesManagement;
		        «solution.setupTableVariableName»: Record «solution.setupTableName.saveQuote»;
		        «solution.setupTableVariableName»Read: Boolean;
		        «master.tableVariableName»: Record «master.tableName.saveQuote»;
		        «FOR supplementalIncludeField : header.includeFields.filter[it.entity instanceof Supplemental && it.field == 'Code']»
		        	«supplementalIncludeField.entity.tableVariableName»: Record «supplementalIncludeField.entity.tableName.saveQuote»;
		        «ENDFOR»
		        «document.header.tableVariableName»: Record «document.header.tableName.saveQuote»;
		        «document.line.tableVariableName»: Record «document.line.tableName.saveQuote»;
		        «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		        PostingDescrTxt: Label '«document.shortName»';
		        Confirmed: Boolean;
		        ConfirmChangeQst: Label 'Do you want to change %1?';
		        SelectNoSeriesAllowed: Boolean;
		        AlreadyExistsErr: Label 'The %1 %2 already exists.';
		        HideValidationDialog: Boolean;
		        StatusCheckSuspended: Boolean;
		        ExistingLinesErr: Label 'You cannot reset %1 because the document still has one or more lines.';
		        RenameNotAllowedErr: Label 'You cannot rename a %1.';
		        NoSeriesDateOrderErr: Label 'You can not change the %1 field because %2 %3 has %4 = %5 and the document has already been assigned %6 %7.';
		        «IF header.hasTemplateOfType(TemplateDimensions)»
		        	DimMgt: Codeunit DimensionManagement;
		        	UpdateLinesDimQst: Label 'You may have changed a dimension.\\Do you want to update the lines?';
		    	«ENDIF»
		    	«IF header.hasTemplateOfType(TemplateAddress)»
		    		PostCode: Record "Post Code";
		        «ENDIF»
		
		    trigger OnInsert()
		    begin
		        IF "No." = '' THEN BEGIN
		            Get«solution.setupTableVariableName»;
		            «solution.setupTableVariableName».TESTFIELD("«document.shortName» Nos.");
		            NoSeriesMgt.InitSeries(«solution.setupTableVariableName»."«document.shortName» Nos.", xRec."No. Series", "Posting Date", "No.", "No. Series");
		        END;
		
		        InitRecord;
		
		        if GetFilter«master.tableVariableName»No <> '' then
		            Validate("«master.name» No.", GetFilter«master.tableVariableName»No);
				
				«FOR supplementalIncludeField : header.includeFields.filter[it.entity instanceof Supplemental && it.field == 'Code']»
					if GetFilter«supplementalIncludeField.entity.tableVariableName»Code <> '' then
						Validate(«supplementalIncludeField.name.saveQuote», GetFilter«supplementalIncludeField.entity.tableVariableName»Code);
				«ENDFOR»
		    end;
		
		    trigger OnRename()
		    begin
		        Error(RenameNotAllowedErr, TableCaption);
		    end;
		
		    trigger OnDelete()
		    begin
		        «solution.commentLineTableVariableName».SetRange("Document Type", «solution.commentLineTableVariableName»."Document Type"::«document.name.saveQuote»);
		        «solution.commentLineTableVariableName».SetRange("No.", "No.");
		        «solution.commentLineTableVariableName».DeleteAll();
		        
		        «document.line.tableVariableName».DeleteAll();
		    end;
		
		    local procedure GetFilter«master.tableVariableName»No(): Code[20]
		    begin
		        if GetFilter("«master.name» No.") <> '' then
		            if GetRangeMin("«master.name» No.") = GetRangeMax("«master.name» No.") then
		                exit(GetRangeMax("«master.name» No."));
		    end;
			«FOR supplementalIncludeField : header.includeFields.filter[it.entity instanceof Supplemental && it.field == 'Code']»
				
				local procedure GetFilter«supplementalIncludeField.entity.tableVariableName»Code(): Code[20]
					begin
						if GetFilter(«supplementalIncludeField.name.saveQuote») <> '' then
							if GetRangeMin(«supplementalIncludeField.name.saveQuote») = GetRangeMax(«supplementalIncludeField.name.saveQuote») then
								exit(GetRangeMax(«supplementalIncludeField.name.saveQuote»));
					end;
			«ENDFOR»
		
		    procedure InitRecord()
		    var
		        IsHandled: Boolean;
		    begin
		        Get«solution.setupTableVariableName»();
		
		        IsHandled := false;
		        OnBeforeInitRecord(Rec, IsHandled, xRec);
		        if not IsHandled then
		            NoSeriesMgt.SetDefaultSeries("Posting No. Series", «solution.setupTableVariableName»."«document.shortNamePosted» Nos.");
		
		        if "Posting Date" = 0D then
		            "Posting Date" := WorkDate();
		
		        "Document Date" := WorkDate();
		        "Posting Description" := PostingDescrTxt + ' ' + "No.";
		
		        OnAfterInitRecord(Rec);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeInitRecord(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var IsHandled: Boolean; x«header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterInitRecord(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		    local procedure InitNoSeries()
		    begin
		        if xRec."Posting No." <> '' then begin
		            "Posting No. Series" := xRec."Posting No. Series";
		            "Posting No." := xRec."Posting No.";
		        end;
		
		        OnAfterInitNoSeries(Rec, xRec);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterInitNoSeries(var «header.tableVariableName»: Record «header.tableName.saveQuote»; x«header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		    procedure AssistEdit(Old«header.tableVariableName»: Record «header.tableName.saveQuote»): Boolean
		    var
		        «header.tableVariableName»2: Record «header.tableName.saveQuote»;
		        IsHandled: Boolean;
		    begin
		        IsHandled := false;
		        OnBeforeAssistEdit(Rec, Old«header.tableVariableName», IsHandled);
		        if IsHandled then
		            exit;
		
		        with «header.tableVariableName» do begin
		            Copy(Rec);
		            Get«solution.setupTableVariableName»();
		            TestNoSeries;
		            if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), Old«header.tableVariableName»."No. Series", "No. Series") then begin
		                NoSeriesMgt.SetSeries("No.");
		                if «header.tableVariableName»2.Get("No.") then
		                    Error(AlreadyExistsErr, TableCaption, "No.");
		                Rec := «header.tableVariableName»;
		                exit(true);
		            end;
		        end;
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeAssistEdit(var «header.tableVariableName»: Record «header.tableName.saveQuote»; Old«header.tableVariableName»: Record «header.tableName.saveQuote»; var IsHandled: Boolean)
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
		
		    procedure GetNoSeriesCode(): Code[20]
		    var
		        NoSeriesCode: Code[20];
		        IsHandled: Boolean;
		    begin
		        Get«solution.setupTableVariableName»();
		        
		        IsHandled := false;
		        OnBeforeGetNoSeriesCode(Rec, «solution.setupTableVariableName», NoSeriesCode, IsHandled);
		        if IsHandled then
		            exit;
		
		        NoSeriesCode := «solution.setupTableVariableName»."«document.shortName» Nos.";
		
		        OnAfterGetNoSeriesCode(Rec, «solution.setupTableVariableName», NoSeriesCode);
		        exit(NoSeriesMgt.GetNoSeriesWithCheck(NoSeriesCode, SelectNoSeriesAllowed, "No. Series"));
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeGetNoSeriesCode(var «header.tableVariableName»: Record «header.tableName.saveQuote»; «solution.setupTableVariableName»: Record «solution.setupTableName.saveQuote»; var NoSeriesCode: Code[20]; var IsHandled: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterGetNoSeriesCode(var «header.tableVariableName»: Record «header.tableName.saveQuote»; «solution.setupTableVariableName»: Record «solution.setupTableName.saveQuote»; var NoSeriesCode: Code[20])
		    begin
		    end;
		
		    procedure SetAllowSelectNoSeries()
		    begin
		        SelectNoSeriesAllowed := true;
		    end;
		
		    procedure TestNoSeries()
		    var
		        IsHandled: Boolean;
		    begin
		        Get«solution.setupTableVariableName»();
		
		        IsHandled := false;
		        OnBeforeTestNoSeries(Rec, IsHandled);
		        if IsHandled then
		            exit;
		
		        «solution.setupTableVariableName».TestField("«document.shortName» Nos.");
		
		        OnAfterTestNoSeries(Rec);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeTestNoSeries(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var IsHandled: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterTestNoSeries(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		    local procedure TestNoSeriesDate(No: Code[20]; NoSeriesCode: Code[20]; NoCapt: Text[1024]; NoSeriesCapt: Text[1024])
		    var
		        NoSeries: Record "No. Series";
		    begin
		        if (No <> '') and (NoSeriesCode <> '') then begin
		            NoSeries.Get(NoSeriesCode);
		            if NoSeries."Date Order" then
		                Error(
		                  NoSeriesDateOrderErr,
		                  FieldCaption("Posting Date"), NoSeriesCapt, NoSeriesCode,
		                  NoSeries.FieldCaption("Date Order"), NoSeries."Date Order",
		                  NoCapt, No);
		        end;
		    end;
		    «IF header.hasTemplateOfType(TemplateSalesperson)»
		    	
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
		
		    procedure TestStatus«document.initialStatus»()
		    begin
		        OnBeforeTestStatus«document.initialStatus»(Rec);
		
		        if StatusCheckSuspended then
		            exit;
		
		        TestField(Status, Status::«document.initialStatus»);
		
		        OnAfterTestStatus«document.initialStatus»(Rec);
		    end;
		
		    [IntegrationEvent(TRUE, false)]
		    local procedure OnBeforeTestStatus«document.initialStatus»(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(TRUE, false)]
		    local procedure OnAfterTestStatus«document.initialStatus»(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		    procedure SuspendStatusCheck(Suspend: Boolean)
		    begin
		        StatusCheckSuspended := Suspend;
		    end;
		
		    local procedure Get«master.tableVariableName»(«master.tableVariableName»No: Code[20])
		    begin
		        if not («master.tableVariableName»No = '') then begin
		            if «master.tableVariableName»No <> «master.tableVariableName»."No." then
		                «master.tableVariableName».Get(«master.tableVariableName»No);
		        end else
		            Clear(«master.tableVariableName»);
		    end;
			«FOR supplementalIncludeField : header.includeFields.filter[it.entity instanceof Supplemental && it.field == 'Code']»
			    
			    local procedure Get«supplementalIncludeField.entity.tableVariableName»(«supplementalIncludeField.name.clean»: Code[10])
			    begin
			        if not («supplementalIncludeField.name.clean» = '') then begin
			            if «supplementalIncludeField.name.clean» <> «supplementalIncludeField.entity.tableVariableName».Code then
			                «supplementalIncludeField.entity.tableVariableName».Get(«supplementalIncludeField.name.clean»);
			        end else
			            Clear(«supplementalIncludeField.entity.tableVariableName»);
			    end;
		    «ENDFOR»
		
		    local procedure Get«solution.setupTableVariableName»()
		    begin
		        if not «solution.setupTableVariableName»Read then
		            «solution.setupTableVariableName».Get();
		
		        «solution.setupTableVariableName»Read := true;
		        OnAfterGet«solution.setupTableVariableName»(Rec, «solution.setupTableVariableName», CurrFieldNo);
		    end;
		    
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterGet«solution.setupTableVariableName»(«header.tableVariableName»: Record «header.tableName.saveQuote»; var «solution.setupTableVariableName»: Record «solution.setupTableName.saveQuote»; CalledByFieldNo: Integer)
		    begin
		    end;
		    
		    «IF header.hasTemplateOfType(TemplateAddress)»
		    	
		    	[IntegrationEvent(false, false)]
		    	local procedure OnBeforeLookupCity(«header.tableVariableName»: Record «header.tableName.saveQuote»; var PostCodeRec: Record "Post Code");
		    	begin
		    	end;
		    	
		    	[IntegrationEvent(false, false)]
		    	local procedure OnBeforeLookupPostCode(«header.tableVariableName»: Record «header.tableName.saveQuote»; var PostCodeRec: Record "Post Code");
		    	begin
		    	end;
		    	
		    	[IntegrationEvent(false, false)]
		    	local procedure OnBeforeValidateCity(«header.tableVariableName»: Record «header.tableName.saveQuote»; var PostCodeRec: Record "Post Code");
		    	begin
		    	end;
		    	
		    	[IntegrationEvent(false, false)]
		    	local procedure OnBeforeValidatePostCode(«header.tableVariableName»: Record «header.tableName.saveQuote»; var PostCodeRec: Record "Post Code");
		    	begin
		    	end;
		    «ENDIF»
		
		    [IntegrationEvent(false, false)]
		    local procedure OnValidate«master.tableVariableName»NoAfterInit(var «header.tableVariableName»: Record «header.tableName.saveQuote»; x«header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterCheck«master.tableVariableName»No(var «header.tableVariableName»: Record «header.tableName.saveQuote»; x«header.tableVariableName»: Record «header.tableName.saveQuote»; «master.tableVariableName»: Record «master.tableName.saveQuote»)
		    begin
		    end;
		
		    procedure «document.line.tableVariableName»Exist(): Boolean
		    begin
		        «document.line.tableVariableName».Reset();
		        «document.line.tableVariableName».SetRange("Document No.", "No.");
		        exit(not «document.line.tableVariableName».IsEmpty);
		    end;
		    
			«IF header.hasTemplateOfType(TemplateDimensions)»
				procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
				var
					OldDimSetID: Integer;
				begin
					OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
					
					OldDimSetID := "Dimension Set ID";
					DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
					if "No." <> '' then
						Modify;
						
					if OldDimSetID <> "Dimension Set ID" then begin
						Modify;
						«IF document.line.hasTemplateOfType(TemplateDimensions)»
							if «document.line.tableVariableName»Exist then
								UpdateAllLineDim("Dimension Set ID", OldDimSetID);
						«ENDIF»
					end;
					
					OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
				end;
				
				[IntegrationEvent(false, false)]
				local procedure OnBeforeValidateShortcutDimCode(var «header.tableVariableName»: Record «header.tableName.saveQuote»; x«header.tableVariableName»: Record «header.tableName.saveQuote»; FieldNumber: Integer; var ShortcutDimCode: Code[20])
				begin
				end;
				
				[IntegrationEvent(false, false)]
				local procedure OnAfterValidateShortcutDimCode(var «header.tableVariableName»: Record «header.tableName.saveQuote»; x«header.tableVariableName»: Record «header.tableName.saveQuote»; FieldNumber: Integer; var ShortcutDimCode: Code[20])
				begin
				end;
				
				procedure ShowDocDim()
				var
					OldDimSetID: Integer;
				begin
					OldDimSetID := "Dimension Set ID";
					"Dimension Set ID" :=
						DimMgt.EditDimensionSet(
							"Dimension Set ID", "No.",
							"Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
					if OldDimSetID <> "Dimension Set ID" then begin
						Modify;
						«IF document.line.hasTemplateOfType(TemplateDimensions)»
							if «document.line.tableVariableName»Exist then
								UpdateAllLineDim("Dimension Set ID", OldDimSetID);
						«ENDIF»
					end;
				end;
				«IF document.line.hasTemplateOfType(TemplateDimensions)»
					
					procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
					var
						NewDimSetID: Integer;
						IsHandled: Boolean;
					begin
						IsHandled := false;
						OnBeforeUpdateAllLineDim(Rec, NewParentDimSetID, OldParentDimSetID, IsHandled);
						if IsHandled then
							exit;
							
						if NewParentDimSetID = OldParentDimSetID then
							exit;
						if not GetHideValidationDialog and GuiAllowed then
							if not Confirm(UpdateLinesDimQst) then
								exit;
						
						«document.line.tableVariableName».Reset();
						«document.line.tableVariableName».SetRange("Document No.", "No.");
						«document.line.tableVariableName».LockTable();
						if «document.line.tableVariableName».Find('-') then
							repeat
								NewDimSetID := DimMgt.GetDeltaDimSetID(«document.line.tableVariableName»."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
								if «document.line.tableVariableName»."Dimension Set ID" <> NewDimSetID then begin
									«document.line.tableVariableName»."Dimension Set ID" := NewDimSetID;
									
									DimMgt.UpdateGlobalDimFromDimSetID(
										«document.line.tableVariableName»."Dimension Set ID", «document.line.tableVariableName»."Shortcut Dimension 1 Code", «document.line.tableVariableName»."Shortcut Dimension 2 Code");
									
									OnUpdateAllLineDimOnBefore«document.line.tableVariableName»Modify(«document.line.tableVariableName»);
									«document.line.tableVariableName».Modify();
								end;
							until «document.line.tableVariableName».Next = 0;
					end;
					
					[IntegrationEvent(false, false)]
					local procedure OnBeforeUpdateAllLineDim(var «header.tableVariableName»: Record «header.tableName.saveQuote»; NewParentDimSetID: Integer; OldParentDimSetID: Integer; var IsHandled: Boolean)
					begin
					end;
					
					[IntegrationEvent(false, false)]
					local procedure OnUpdateAllLineDimOnBefore«document.line.tableVariableName»Modify(var «document.line.tableVariableName»: Record «document.line.tableName.saveQuote»)
					begin
					end;
			    «ENDIF»
		    «ENDIF»
		
		    [IntegrationEvent(false, false)]
		    local procedure OnValidatePostingDateOnBeforeAssignDocumentDate(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var IsHandled: Boolean)
		    begin
		    end;
		
		    local procedure GetPostingNoSeriesCode() PostingNos: Code[20]
		    var
		        IsHandled: Boolean;
		    begin
		        Get«solution.setupTableVariableName»();
		        IsHandled := false;
		        OnBeforeGetPostingNoSeriesCode(Rec, «solution.setupTableVariableName», PostingNos, IsHandled);
		        if IsHandled then
		            exit;
		
		        PostingNos := «solution.setupTableVariableName»."«document.shortNamePosted» Nos.";
		
		        OnAfterGetPostingNoSeriesCode(Rec, PostingNos);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeGetPostingNoSeriesCode(var «header.tableVariableName»: Record «header.tableName.saveQuote»; «solution.setupTableVariableName»: Record «solution.setupTableName.saveQuote»; var NoSeriesCode: Code[20]; var IsHandled: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterGetPostingNoSeriesCode(«header.tableVariableName»: Record «header.tableName.saveQuote»; var PostingNos: Code[20])
		    begin
		    end;
		}
	'''
	
	static def doGenerateTablePosted(DocumentHeader header) '''
		«management.resetFieldNo(header)»
		«val solution = header.solution»
		«val document = header.document»
		«val master = header.solution.master»
		table «management.newTableNo» «header.tableNamePosted.saveQuote»
		{
		    Caption = '«header.namePosted»';
		    DataCaptionFields = "No.";
		    LookupPageId = «document.documentPageNamePosted.saveQuote»;
		
		    fields
		    {
		        field(«management.getNewFieldNo(header)»; "No."; Code[20])
		        {
		            Caption = 'No.';
		        }
		        field(«management.getNewFieldNo(header)»; "«master.name» No."; Code[20])
		        {
		            Caption = '«master.name» No.';
		            TableRelation = «master.tableName.saveQuote»;
		        }
		        field(«management.getNewFieldNo(header)»; Status; Enum «document.statusEnumName.saveQuote»)
		        {
		            Caption = 'Status';
		            Editable = false;
		        }
		        
		        field(«management.getNewFieldNo(header)»; Comment; Boolean)
		        {
		            Caption = 'Comment';
		            FieldClass = FlowField;
		            Editable = false;
		            CalcFormula = exist («solution.commentLineTableName.saveQuote» where("No." = field("No."), "Document Line No." = const(0)));
		        }
		        field(«management.getNewFieldNo(header)»; "No. Printed"; Integer)
		        {
		            Caption = 'No. Printed';
		            Editable = false;
		        }
		        field(«management.getNewFieldNo(header)»; "Posting Date"; Date)
		        {
		            Caption = 'Posting Date';
		        }
		        field(«management.getNewFieldNo(header)»; "Document Date"; Date)
		        {
		            Caption = 'Document Date';
		        }
		        field(«management.getNewFieldNo(header)»; "Posting Description"; Text[100])
		        {
		            Caption = 'Posting Description';
		        }
		        field(«management.getNewFieldNo(header)»; "External Document No."; Code[35])
		        {
		            Caption = 'External Document No.';
		        }
		        field(«management.getNewFieldNo(header)»; "Reason Code"; Code[10])
		        {
		            Caption = 'Reason Code';
		            TableRelation = "Reason Code";
		        }
		        field(«management.getNewFieldNo(header)»; "No. Series"; Code[20])
		        {
		            Caption = 'No. Series';
		            Editable = false;
		            TableRelation = "No. Series";
		        }
		        field(«management.getNewFieldNo(header)»; "Posting No."; Code[20])
		        {
		            Caption = 'Posting No.';
		        }
		        field(«management.getNewFieldNo(header)»; "Posting No. Series"; Code[20])
		        {
		            Caption = 'Posting No. Series';
		            TableRelation = "No. Series";
		        }
		        field(«management.getNewFieldNo(header)»; "Last Posting No."; Code[20])
		        {
		            Caption = 'Last Posting No.';
		            Editable = false;
		            TableRelation = «header.tableNamePosted.saveQuote»;
		        }
		        «IF header.hasTemplateOfType(TemplateDimensions)»
		        	field(«management.getNewFieldNo(header)»; "Dimension Set ID"; Integer)
		        	{
		        		Caption = 'Dimension Set ID';
		        		Editable = false;
		        		TableRelation = "Dimension Set Entry";
		        		
		        		trigger OnLookup()
		        		begin
		        			ShowDimensions;
		        		end;
		        	}
		        «ENDIF»
		        «IF header.includeFields.exists[it.entity instanceof Supplemental && it.field == 'Code']»
		        	«val supplementalIncludeField = header.includeFields.filter[it.entity instanceof Supplemental && it.field == 'Code'].get(0)»
		        	field(«management.getNewFieldNo(header)»; «supplementalIncludeField.name.saveQuote»; Code[10])
		        	{
		        		Caption = '«supplementalIncludeField.name»';
		        		TableRelation = «supplementalIncludeField.entity.tableName.saveQuote»;
		        	}
		        «ENDIF»
		        «header.doGenerateTableFields»
		        field(«management.getNewFieldNo(header)»; "«document.shortName» No."; Code[20])
		        {
		        	Caption = '«document.shortName» No.';
		        }
		        field(«management.getNewFieldNo(header)»; "«document.shortName» Nos."; Code[20])
		        {
		        	Caption = '«document.shortName» Nos.';
		        	TableRelation = "No. Series".Code;
		        }
		        field(«management.getNewFieldNo(header)»; "User ID"; Code[50])
		        {
		        	Caption = 'User ID';
		        	TableRelation = User."User Name";
		        	ValidateTableRelation = false;
		        }
		        field(«management.getNewFieldNo(header)»; "Source Code"; Code[10])
		        {
		        	Caption = 'Source Code';
		        }
			}
		
		    keys
		    {
		        key(Key1; "No.")
		        {
		            Clustered = true;
		        }
		        key(Key2; "Posting Date") { }
		    }
		    
		    trigger OnDelete()
		    begin
		        «solution.commentLineTableVariableName».SetRange("Document Type", «solution.commentLineTableVariableName»."Document Type"::«document.namePosted.saveQuote»);
		        «solution.commentLineTableVariableName».SetRange("No.", "No.");
		        «solution.commentLineTableVariableName».DeleteAll();
		        
		        «document.line.tableVariableNamePosted».DeleteAll();
		    end;
		    
		    var
		    	«solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		    	«document.line.tableVariableNamePosted»: Record «document.line.tableNamePosted.saveQuote»;
			    «IF header.hasTemplateOfType(TemplateDimensions)»
			    	DimMgt: Codeunit DimensionManagement;
			    «ENDIF»
		    
		    procedure Navigate()
		    var
		    	NavigatePage: Page Navigate;
		    begin
		    	NavigatePage.SetDoc("Posting Date", "No.");
		    	NavigatePage.SetRec(Rec);
		    	NavigatePage.Run;
		   	end;
		   	
			«IF header.hasTemplateOfType(TemplateDimensions)»
				procedure ShowDimensions()
				begin
					DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption, "No."));
				end;
		   	«ENDIF»
		}
	'''
	
}