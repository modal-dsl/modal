package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.Document

import static extension de.joneug.mdal.extensions.DocumentHeaderExtensions.*
import static extension de.joneug.mdal.extensions.DocumentLineExtensions.*
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.LedgerEntryExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class DocumentExtensions {
	
	static GeneratorManagement management = GeneratorManagement.getInstance()
	
	static def getCleanedName(Document document) {
		return document.name.toOnlyAlphabetic.removeSpaces
	}
	
	static def getNamePosted(Document document) {
		return 'Posted ' + document.name
	}
	
	static def getShortNamePosted(Document document) {
		return 'Posted ' + document.shortName
	}
	
	static def getDocumentPageName(Document document) {
		var name = document.solution.constructObjectName(document.name)
		if(name.length > 30) {
			name = document.solution.constructObjectName(document.shortName)
		}
		return name
	}
	
	static def getDocumentPageNamePosted(Document document) {
		var name = document.solution.constructObjectName('Posted ' + document.name)
		if(name.length > 30) {
			name = document.solution.constructObjectName('Posted ' + document.shortName)
		}
		return name
	}
	
	static def getListPageName(Document document) {
		var name = document.solution.constructObjectName(document.name + ' List')
		if(name.length > 30) {
			name = document.solution.constructObjectName(document.shortName + ' List')
		}
		return name
	}
	
	static def getListPageNamePosted(Document document) {
		var name = document.solution.constructObjectName('Posted ' + document.name + ' List')
		if(name.length > 30) {
			name = document.solution.constructObjectName('Posted ' + document.shortName + ' List')
		}
		return name
	}
	
	static def getSubformPageName(Document document) {
		var name = document.solution.constructObjectName(document.name + ' Subform')
		if(name.length > 30) {
			name = document.solution.constructObjectName(document.shortName + ' Subform')
		}
		return name
	}
	
	static def getSubformPageNamePosted(Document document) {
		var name = document.solution.constructObjectName('Posted ' + document.name + ' Subform')
		if(name.length > 30) {
			name = document.solution.constructObjectName('Posted ' + document.shortName + ' Subform')
		}
		return name
	}
	
	static def getStatusEnumName(Document document) {
		var name = document.solution.constructObjectName(document.name + ' Status')
		if(name.length > 30) {
			name = document.solution.constructObjectName(document.shortName + ' Status')
		}
		
		return name
	}
	
	static def getInitialStatus(Document document) {
		return document.header.statusCaptions.get(0)
	}
	
	static def codeunitNamePost(Document document) {
		val master = document.solution.master
		var name = document.solution.constructObjectName(master.name + '-Post')
		if(name.length > 30) {
			name = document.solution.constructObjectName(master.shortName + '-Post')
		}
		
		return name
	}
	
	static def codeunitNamePostYesNo(Document document) {
		val master = document.solution.master
		var name = document.solution.constructObjectName(master.name + '-Post (Yes/No)')
		if(name.length > 30) {
			name = document.solution.constructObjectName(master.shortName + '-Post (Yes/No)')
		}
		
		return name
	}
	
	static def codeunitVariableNamePostYesNo(Document document) {
		return document.codeunitNamePostYesNo.clean.substring(3)
	}
	
	static def codeunitNameJnlCheckLine(Document document) {
		val master = document.solution.master
		var name = document.solution.constructObjectName(master.name + ' Jnl.-Check Line')
		if(name.length > 30) {
			name = document.solution.constructObjectName(master.shortName + ' Jnl.-Check Line')
		}
		
		return name
	}
	
	static def codeunitVariableNameJnlCheckLine(Document document) {
		return document.codeunitNameJnlCheckLine.clean.substring(3)
	}
	
	static def codeunitNameJnlPostLine(Document document) {
		val master = document.solution.master
		var name = document.solution.constructObjectName(master.name + ' Jnl.-Post Line')
		if(name.length > 30) {
			name = document.solution.constructObjectName(master.shortName + ' Jnl.-Post Line')
		}
		
		return name
	}
	
	static def void doGenerate(Document document) {
		// Enum
		document.saveEnum(document.statusEnumName, document.doGenerateStatusEnum)
		
		// Tables
		document.header.doGenerate
		document.line.doGenerate
		
		// Codeunits
		document.saveCodeunit(document.codeunitNamePost, document.doGenerateCodeunitPost)
		document.saveCodeunit(document.codeunitNamePostYesNo, document.doGenerateCodeunitPostYesNo)
		document.saveCodeunit(document.codeunitNameJnlCheckLine, document.doGenerateCodeunitJnlCheckLine)
		document.saveCodeunit(document.codeunitNameJnlPostLine, document.doGenerateCodeunitJnlPostLine)
	}
	
	static def doGenerateStatusEnum(Document document) '''
		enum «management.newEnumNo» «document.statusEnumName.saveQuote»
		{
		    Extensible = true;
		    AssignmentCompatibility = true;
			
			«FOR statusCaption : document.header.statusCaptions»
				value(«management.getNewFieldNo(document) - 1»; «statusCaption.saveQuote») { Caption = '«statusCaption»'; }
			«ENDFOR»
		}
	'''
	
	static def doGenerateCodeunitPost(Document document) '''
		«val solution = document.solution»
		«val line = document.line»
		«val header = document.header»
		codeunit «management.newCodeunitNo» «document.codeunitNamePost.saveQuote»
		{
		    Permissions = TableData «line.tableName.saveQuote» = imd,
		                  TableData «header.tableNamePosted.saveQuote» = imd,
		                  TableData «line.tableNamePosted.saveQuote» = imd;
		    TableNo = «header.tableName.saveQuote»;
		
		    trigger OnRun()
		    var
		        SavedPreviewMode: Boolean;
		        SavedSuppressCommit: Boolean;
		        LinesProcessed: Boolean;
		    begin
		        OnBeforePost«document.shortName.clean»(Rec, SuppressCommit, PreviewMode, HideProgressWindow);
		        if not GuiAllowed then
		            LockTimeout(false);
		
		        SavedPreviewMode := PreviewMode;
		        SavedSuppressCommit := SuppressCommit;
		        ClearAllVariables();
		        SuppressCommit := SavedSuppressCommit;
		        PreviewMode := SavedPreviewMode;
		
		        Get«solution.setupTableVariableName»();
		        «header.tableVariableName» := Rec;
		        FillTempLines(«header.tableVariableName», Temp«line.tableVariableName»Global);
		
		        EverythingPosted := true;
		
		        // Header
		        CheckAndUpdate();
		        PostHeader(«header.tableVariableName», «header.tableVariableNamePosted»);
		
		
		        // Lines
		        OnBeforePostLines(Temp«line.tableVariableName»Global, «header.tableVariableName», SuppressCommit, PreviewMode);
		
		        LineCount := 0;
		
		        LinesProcessed := false;
		        if Temp«line.tableVariableName»Global.FindSet() then
		            repeat
		                LineCount := LineCount + 1;
		                if not HideProgressWindow then
		                    Window.Update(2, LineCount);
		
		                PostLine(«header.tableVariableName», Temp«line.tableVariableName»Global);
		            until Temp«line.tableVariableName»Global.Next() = 0;
		
		        OnAfterPostPostedLines(«header.tableVariableName», «header.tableVariableNamePosted», LinesProcessed, SuppressCommit, EverythingPosted);
		
		        UpdateLastPostingNos(«header.tableVariableName»);
		
		        OnRunOnBeforeFinalizePosting(
		          «header.tableVariableName», «header.tableVariableNamePosted», SuppressCommit);
		
		        FinalizePosting(«header.tableVariableName», EverythingPosted);
		
		        Rec := «header.tableVariableName»;
		
		        if not SuppressCommit then
		            Commit();
		
		        OnAfterPostPostedDoc(Rec, «header.tableVariableNamePosted»."No.", SuppressCommit);
		    end;
		
		    var
		        «header.tableVariableName»: Record «header.tableName.saveQuote»;
		        «line.tableVariableName»: Record «line.tableName.saveQuote»;
		        Temp«line.tableVariableName»Global: Record «line.tableName.saveQuote» temporary;
		        «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»;
		        «line.tableVariableNamePosted»: Record «line.tableNamePosted.saveQuote»;
		        «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		        SourceCodeSetup: Record "Source Code Setup";
		        ModifyHeader: Boolean;
		        Window: Dialog;
		        LineCount: Integer;
		        PostingLinesMsg: Label 'Posting lines              #2######', Comment = 'Counter';
		        «document.shortNamePosted.clean»NoMsg: Label '«document.name» %1  -> «document.namePosted» %2';
		        PostingPreviewNoTok: Label '***', Locked = true;
		        EverythingPosted: Boolean;
		        SuppressCommit: Boolean;
		        PreviewMode: Boolean;
		        HideProgressWindow: Boolean;
		        SrcCode: Code[10];
		        «solution.setupTableVariableName»: Record «solution.setupTableName.saveQuote»;
		        «solution.setupTableVariableName»Read: Boolean;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnRunOnBeforeFinalizePosting(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterPostPostedDoc(var «header.tableVariableName»: Record «header.tableName.saveQuote»; «header.tableVariableNamePosted»No: Code[20]; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    local procedure FinalizePosting(var «header.tableVariableName»: Record «header.tableName.saveQuote»; EverythingInvoiced: Boolean)
		    begin
		        OnBeforeFinalizePosting(«header.tableVariableName», Temp«line.tableVariableName»Global, EverythingInvoiced, SuppressCommit);
		
		        with «header.tableVariableName» do begin
		            if not EverythingInvoiced then begin
		                OnFinalizePostingOnNotEverythingInvoiced(«header.tableVariableName», Temp«line.tableVariableName»Global, SuppressCommit)
		            end else begin
		                PostUpdatePostedLine;
		            end;
		
		            if not PreviewMode then
		                DeleteAfterPosting(«header.tableVariableName»);
		        end;
		
		        OnAfterFinalizePostingOnBeforeCommit(«header.tableVariableName», «header.tableVariableNamePosted», SuppressCommit, PreviewMode);
		
		        if PreviewMode then begin
		            if not HideProgressWindow then
		                Window.Close();
		            exit;
		        end;
		        if not SuppressCommit then
		            Commit();
		
		        if not HideProgressWindow then
		            Window.Close();
		
		        OnAfterFinalizePosting(«header.tableVariableName», «header.tableVariableNamePosted», SuppressCommit, PreviewMode);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnFinalizePostingOnNotEverythingInvoiced(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var Temp«line.tableVariableName»Global: Record «line.tableName.saveQuote» temporary; SuppressCommit: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterFinalizePostingOnBeforeCommit(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterFinalizePosting(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeFinalizePosting(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var Temp«line.tableVariableName»Global: Record «line.tableName.saveQuote» temporary; var EverythingInvoiced: Boolean; SuppressCommit: Boolean)
		    begin
		    end;
		
		    local procedure DeleteAfterPosting(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    var
		        «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		        «line.tableVariableName»: Record «line.tableName.saveQuote»;
		        Temp«line.tableVariableName»Local: Record «line.tableName.saveQuote» temporary;
		        SkipDelete: Boolean;
		    begin
		        OnBeforeDeleteAfterPosting(«header.tableVariableName», «header.tableVariableNamePosted», SkipDelete, SuppressCommit);
		        if SkipDelete then
		            exit;
		
		        with «header.tableVariableName» do begin
		            if HasLinks then
		                DeleteLinks;
		
		            Delete;
		
		            ResetTempLines(Temp«line.tableVariableName»Local);
		            if Temp«line.tableVariableName»Local.FindFirst() then
		                repeat
		                    if Temp«line.tableVariableName»Local.HasLinks then
		                        Temp«line.tableVariableName»Local.DeleteLinks;
		                until Temp«line.tableVariableName»Local.Next() = 0;
		
		            «line.tableVariableName».SetRange("Document No.", "No.");
		            OnBefore«line.tableVariableName»DeleteAll(«line.tableVariableName», SuppressCommit);
		            «line.tableVariableName».DeleteAll();
		
		            «solution.commentLineTableVariableName».DeleteComments(«solution.commentLineTableVariableName»."Document Type"::«document.name.saveQuote», "No.");
		        end;
		
		        OnAfterDeleteAfterPosting(«header.tableVariableName», «header.tableVariableNamePosted», SuppressCommit);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeDeleteAfterPosting(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; var SkipDelete: Boolean; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBefore«line.tableVariableName»DeleteAll(var «line.tableVariableName»: Record «line.tableName.saveQuote»; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterDeleteAfterPosting(«header.tableVariableName»: Record «header.tableName.saveQuote»; «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		
		    local procedure PostUpdatePostedLine()
		    var
		        «line.tableVariableName»: Record «line.tableName.saveQuote»;
		        Temp«line.tableVariableName»: Record «line.tableName.saveQuote» temporary;
		    begin
		        ResetTempLines(Temp«line.tableVariableName»);
		        with Temp«line.tableVariableName» do begin
		            OnPostUpdatePostedLineOnBeforeFindSet(Temp«line.tableVariableName»);
		            if FindSet() then
		                repeat
		                    «line.tableVariableName».Get("Document No.", "Line No.");
		                    OnPostUpdatePostedLineOnBeforeModify(«line.tableVariableName», Temp«line.tableVariableName»);
		                    «line.tableVariableName».Modify();
		                until Next() = 0;
		        end;
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnPostUpdatePostedLineOnBeforeFindSet(var Temp«line.tableVariableName»: Record «line.tableName.saveQuote» temporary)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnPostUpdatePostedLineOnBeforeModify(var «line.tableVariableName»: Record «line.tableName.saveQuote»; var Temp«line.tableVariableName»: Record «line.tableName.saveQuote» temporary)
		    begin
		    end;
		
		    local procedure ResetTempLines(var Temp«line.tableVariableName»Local: Record «line.tableName.saveQuote» temporary)
		    begin
		        Temp«line.tableVariableName»Local.Reset();
		        Temp«line.tableVariableName»Local.Copy(Temp«line.tableVariableName»Global, true);
		        OnAfterResetTempLines(Temp«line.tableVariableName»Local);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterResetTempLines(var Temp«line.tableVariableName»Local: Record «line.tableName.saveQuote» temporary)
		    begin
		    end;
		
		    local procedure UpdateLastPostingNos(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		        with «header.tableVariableName» do begin
		            "Last Posting No." := «header.tableVariableNamePosted»."No.";
		            "Posting No." := '';
		        end;
		
		        OnAfterUpdateLastPostingNos(«header.tableVariableName»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterUpdateLastPostingNos(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		    local procedure PostLine(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «line.tableVariableName»: Record «line.tableName.saveQuote»)
		    var
		        IsHandled: Boolean;
		    begin
		        with «line.tableVariableName» do begin
		            TestLine(«header.tableVariableName», «line.tableVariableName»);
		
		            UpdateLineBeforePost(«header.tableVariableName», «line.tableVariableName»);
		
		            IsHandled := false;
		            OnPostLineOnBeforeInsertPostedLine(«header.tableVariableName», «line.tableVariableName», IsHandled, «header.tableVariableNamePosted»);
		            if not IsHandled then begin
		                «line.tableVariableNamePosted».Init;
		                «line.tableVariableNamePosted».TransferFields(«line.tableVariableName»);
		                «line.tableVariableNamePosted»."Document No." := «header.tableVariableNamePosted»."No.";
		
		                OnBeforePostedLineInsert(«line.tableVariableNamePosted», «header.tableVariableNamePosted», Temp«line.tableVariableName»Global, «header.tableVariableName», SrcCode, SuppressCommit);
		                «line.tableVariableNamePosted».Insert(true);
		                OnAfterPostedLineInsert(«line.tableVariableNamePosted», «header.tableVariableNamePosted», Temp«line.tableVariableName»Global, «header.tableVariableName», SrcCode, SuppressCommit);
		            end;
		        end;
		
		        OnAfterPostPostedLine(«header.tableVariableName», «line.tableVariableName», SuppressCommit, «line.tableVariableNamePosted»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnPostLineOnBeforeInsertPostedLine(«header.tableVariableName»: Record «header.tableName.saveQuote»; «line.tableVariableName»: Record «line.tableName.saveQuote»; var IsHandled: Boolean; «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforePostedLineInsert(var «line.tableVariableNamePosted»: Record «line.tableNamePosted.saveQuote»; «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; var Temp«line.tableVariableName»Global: Record «line.tableName.saveQuote» temporary; «header.tableVariableName»: Record «header.tableName.saveQuote»; SrcCode: Code[10]; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterPostedLineInsert(var «line.tableVariableNamePosted»: Record «line.tableNamePosted.saveQuote»; «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; var Temp«line.tableVariableName»Global: Record «line.tableName.saveQuote» temporary; «header.tableVariableName»: Record «header.tableName.saveQuote»; SrcCode: Code[10]; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterPostPostedLine(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «line.tableVariableName»: Record «line.tableName.saveQuote»; CommitIsSuppressed: Boolean; var «line.tableVariableNamePosted»: Record «line.tableNamePosted.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterPostPostedLines(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; var LinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingPosted: Boolean)
		    begin
		    end;
		
		    local procedure TestLine(«header.tableVariableName»: Record «header.tableName.saveQuote»; «line.tableVariableName»: Record «line.tableName.saveQuote»)
		    begin
		        OnTestLine(«header.tableVariableName», «line.tableVariableName», SuppressCommit);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnTestLine(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «line.tableVariableName»: Record «line.tableName.saveQuote»; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    local procedure UpdateLineBeforePost(«header.tableVariableName»: Record «header.tableName.saveQuote»; «line.tableVariableName»: Record «line.tableName.saveQuote»)
		    begin
		        OnUpdateLineBeforePost(«header.tableVariableName», «line.tableVariableName», SuppressCommit);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnUpdateLineBeforePost(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «line.tableVariableName»: Record «line.tableName.saveQuote»; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    local procedure ClearAllVariables()
		    begin
		        ClearAll;
		        Temp«line.tableVariableName»Global.DeleteAll();
		    end;
		
		    procedure FillTempLines(«header.tableVariableName»: Record «header.tableName.saveQuote»; var Temp«line.tableVariableName»: Record «line.tableName.saveQuote» temporary)
		    begin
		        Temp«line.tableVariableName».Reset();
		        if Temp«line.tableVariableName».IsEmpty() then
		            CopyToTempLines(«header.tableVariableName», «line.tableVariableName»);
		    end;
		
		    procedure CopyToTempLines(«header.tableVariableName»: Record «header.tableName.saveQuote»; var Temp«line.tableVariableName»: Record «line.tableName.saveQuote» temporary)
		    var
		        «line.tableVariableName»: Record «line.tableName.saveQuote»;
		    begin
		        «line.tableVariableName».SetRange("Document No.", «header.tableVariableName»."No.");
		        OnCopyToTempLinesOnAfterSetFilters(«line.tableVariableName», «header.tableVariableName»);
		        if «line.tableVariableName».FindSet() then
		            repeat
		                Temp«line.tableVariableName» := «line.tableVariableName»;
		                Temp«line.tableVariableName».Insert();
		            until «line.tableVariableName».Next() = 0;
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnCopyToTempLinesOnAfterSetFilters(var «line.tableVariableName»: Record «line.tableName.saveQuote»; «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforePostLines(var Temp«line.tableVariableName»Global: Record «line.tableName.saveQuote» temporary; var «header.tableVariableName»: Record «header.tableName.saveQuote»; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
		    begin
		    end;
		
		    procedure SetSuppressCommit(NewSuppressCommit: Boolean)
		    begin
		        SuppressCommit := NewSuppressCommit;
		    end;
		
		    procedure SetPreviewMode(NewPreviewMode: Boolean)
		    begin
		        PreviewMode := NewPreviewMode;
		    end;
		
		    local procedure PostHeader(«header.tableVariableName»: Record «header.tableName.saveQuote»; «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»)
		    begin
		        OnPostHeader(«header.tableVariableName», «header.tableVariableNamePosted», Temp«line.tableVariableName»Global, SrcCode, SuppressCommit, PreviewMode);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnPostHeader(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; var Temp«line.tableVariableName»Global: Record «line.tableName.saveQuote» temporary; SrcCode: Code[10]; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
		    begin
		    end;
		
		    local procedure CheckAndUpdate()
		    begin
		        with «header.tableVariableName» do begin
		            // Check
		            CheckMandatoryHeaderFields(«header.tableVariableName»);
		            CheckPostRestrictions(«header.tableVariableName»);
		
		            if not HideProgressWindow then
		                InitProgressWindow(«header.tableVariableName»);
		
		            CheckNothingToPost(«header.tableVariableName»);
		
		            OnAfterCheck«document.shortName.clean»(«header.tableVariableName», SuppressCommit);
		
		            // Update
		            ModifyHeader := UpdatePostingNo(«header.tableVariableName»);
		
		            OnBeforePostCommit«document.shortName.clean»(«header.tableVariableName», PreviewMode, ModifyHeader, SuppressCommit, Temp«line.tableVariableName»Global);
		            if not PreviewMode and ModifyHeader then begin
		                Modify;
		                if not SuppressCommit then
		                    Commit();
		            end;
		
		            LockTables(«header.tableVariableName»);
		
		            SourceCodeSetup.Get();
		            SrcCode := SourceCodeSetup.«document.name.saveQuote»;
		
		            OnCheckAndUpdateOnAfterSetSourceCode(«header.tableVariableName», SourceCodeSetup, SrcCode);
		
		            InsertPostedHeaders(«header.tableVariableName»);
		        end;
		
		        OnAfterCheckAndUpdate(«header.tableVariableName», SuppressCommit, PreviewMode);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterCheckAndUpdate(var «header.tableVariableName»: Record «header.tableName.saveQuote»; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
		    begin
		    end;
		
		    local procedure InsertPostedHeaders(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    var
		        PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler";
		        IsHandled: Boolean;
		    begin
		        if PreviewMode then
		            PostingPreviewEventHandler.PreventCommit();
		
		        «header.tableVariableNamePosted».LockTable();
		
		        IsHandled := false;
		        OnBeforeInsert«header.tableVariableNamePosted»(«header.tableVariableName», IsHandled);
		        if not IsHandled then
		            Insert«header.tableVariableNamePosted»(«header.tableVariableName», «header.tableVariableNamePosted»);
		
		        OnAfterInsert«header.tableVariableNamePosted»(«header.tableVariableName», «header.tableVariableNamePosted»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeInsert«header.tableVariableNamePosted»(var «header.tableVariableName»: Record «header.tableName.saveQuote»; IsHandled: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterInsert«header.tableVariableNamePosted»(var «header.tableVariableName»: Record «header.tableName.saveQuote»; «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»)
		    begin
		    end;
		
		    local procedure Insert«header.tableVariableNamePosted»(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»)
		    var
		        «solution.commentLineTableVariableName»: Record «solution.commentLineTableName.saveQuote»;
		        RecordLinkManagement: Codeunit "Record Link Management";
		    begin
		        with «header.tableVariableName» do begin
		            «header.tableVariableNamePosted».Init();
		            «header.tableVariableNamePosted».TransferFields(«header.tableVariableName»);
		
		            «header.tableVariableNamePosted»."No." := "Posting No.";
		            «header.tableVariableNamePosted»."No. Series" := "Posting No. Series";
		            «header.tableVariableNamePosted»."«document.shortName» No." := "No.";
		            «header.tableVariableNamePosted»."«document.shortName» Nos." := "No. Series";
		            if GuiAllowed and not HideProgressWindow then
		                Window.Update(1, StrSubstNo(«document.shortNamePosted.clean»NoMsg, "No.", «header.tableVariableNamePosted»."No."));
		            «header.tableVariableNamePosted»."Source Code" := SrcCode;
		            «header.tableVariableNamePosted»."User ID" := UserId;
		            «header.tableVariableNamePosted»."No. Printed" := 0;
		
		            OnBefore«header.tableVariableNamePosted»Insert(«header.tableVariableNamePosted», «header.tableVariableName», SuppressCommit);
		            «header.tableVariableNamePosted».Insert(true);
		            OnAfter«header.tableVariableNamePosted»Insert(«header.tableVariableNamePosted», «header.tableVariableName», SuppressCommit);
		
		            if «solution.setupTableVariableName»."Copy Comments" then begin
		                «solution.commentLineTableVariableName».CopyComments(«solution.commentLineTableVariableName»."Document Type"::«document.name.saveQuote», «solution.commentLineTableVariableName»."Document Type"::«document.namePosted.saveQuote», "No.", «header.tableVariableNamePosted»."No.");
		            end;
		        end;
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBefore«header.tableVariableNamePosted»Insert(var «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; «header.tableVariableName»: Record «header.tableName.saveQuote»; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfter«header.tableVariableNamePosted»Insert(var «header.tableVariableNamePosted»: Record «header.tableNamePosted.saveQuote»; «header.tableVariableName»: Record «header.tableName.saveQuote»; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnCheckAndUpdateOnAfterSetSourceCode(«header.tableVariableName»: Record «header.tableName.saveQuote»; SourceCodeSetup: Record "Source Code Setup"; var SrcCode: Code[10]);
		    begin
		    end;
		
		    local procedure LockTables(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    var
		        «line.tableVariableName»: Record «line.tableName.saveQuote»;
		    begin
		        OnBeforeLockTables(«header.tableVariableName», PreviewMode, SuppressCommit);
		
		        «line.tableVariableName».LockTable();
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeLockTables(var «header.tableVariableName»: Record «header.tableName.saveQuote»; PreviewMode: Boolean; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforePostCommit«document.shortName.clean»(var «header.tableVariableName»: Record «header.tableName.saveQuote»; PreviewMode: Boolean; var ModifyHeader: Boolean; var CommitIsSuppressed: Boolean; var Temp«line.tableVariableName»Global: Record «line.tableName.saveQuote» temporary)
		    begin
		    end;
		
		    local procedure UpdatePostingNo(var «header.tableVariableName»: Record «header.tableName.saveQuote») ModifyHeader: Boolean
		    var
		        NoSeriesMgt: Codeunit NoSeriesManagement;
		        IsHandled: Boolean;
		    begin
		        with «header.tableVariableName» do begin
		            OnBeforeUpdatePostingNo(«header.tableVariableName», PreviewMode, ModifyHeader, IsHandled);
		
		            if not IsHandled then
		                if "Posting No." = '' then
		                    if not PreviewMode then begin
		                        TestField("Posting No. Series");
		                        "Posting No." := NoSeriesMgt.GetNextNo("Posting No. Series", "Posting Date", true);
		                        ModifyHeader := true;
		                    end else
		                        "Posting No." := PostingPreviewNoTok;
		        end;
		
		        OnAfterUpdatePostingNo(«header.tableVariableName», NoSeriesMgt, SuppressCommit);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeUpdatePostingNo(var «header.tableVariableName»: Record «header.tableName.saveQuote»; PreviewMode: Boolean; var ModifyHeader: Boolean; var IsHandled: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterUpdatePostingNo(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var NoSeriesMgt: Codeunit NoSeriesManagement; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterCheck«document.shortName.clean»(var «header.tableVariableName»: Record «header.tableName.saveQuote»; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    procedure InitProgressWindow(«header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		        Window.Open(
		                '#1#################################\\' +
		                  PostingLinesMsg);
		        Window.Update(1, StrSubstNo('%1', «header.tableVariableName»."No."));
		    end;
		
		    local procedure CheckMandatoryHeaderFields(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    var
		        IsHandled: Boolean;
		    begin
		        IsHandled := false;
		        OnBeforeCheckMandatoryFields(«header.tableVariableName», SuppressCommit, IsHandled);
		        if not IsHandled then begin
		            «header.tableVariableName».TestField("Posting Date");
		        end;
		
		        OnAfterCheckMandatoryFields(«header.tableVariableName», SuppressCommit);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeCheckMandatoryFields(var «header.tableVariableName»: Record «header.tableName.saveQuote»; CommitIsSuppressed: Boolean; var IsHandled: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterCheckMandatoryFields(var «header.tableVariableName»: Record «header.tableName.saveQuote»; CommitIsSuppressed: Boolean)
		    begin
		    end;
		
		    local procedure CheckPostRestrictions(«header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		        OnCheckPostRestrictions(«header.tableVariableName»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnCheckPostRestrictions(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		    local procedure CheckNothingToPost(«header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		        OnCheckNothingToPost(«header.tableVariableName», Temp«line.tableVariableName»Global);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnCheckNothingToPost(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var Temp«line.tableVariableName»Global: Record «line.tableName.saveQuote» temporary)
		    begin
		    end;
		
		    [IntegrationEvent(true, false)]
		    local procedure OnBeforePost«document.shortName.clean»(var «header.tableVariableName»: Record «header.tableName.saveQuote»; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
		    begin
		    end;
		
		    local procedure Get«solution.setupTableVariableName»()
		    begin
		        if not «solution.setupTableVariableName»Read then
		            «solution.setupTableVariableName».Get;
		
		        «solution.setupTableVariableName»Read := true;
		
		        OnAfterGet«solution.setupTableVariableName»(«solution.setupTableVariableName»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterGet«solution.setupTableVariableName»(var «solution.setupTableVariableName»: Record «solution.setupTableName.saveQuote»)
		    begin
		    end;
		
		}
	'''
	
	static def doGenerateCodeunitPostYesNo(Document document) '''
		«val header = document.header»
		codeunit «management.newCodeunitNo» «document.codeunitNamePostYesNo.saveQuote»
		{
		    TableNo = «header.tableName.saveQuote»;
		
		    trigger OnRun()
		    var
		        «header.tableVariableName»: Record «header.tableName.saveQuote»;
		    begin
		        if not Find then
		            Error(NothingToPostErr);
		
		        «header.tableVariableName».Copy(Rec);
		        Code(«header.tableVariableName»);
		        Rec := «header.tableVariableName»;
		    end;
		
		    var
		        PostConfirmQst: Label 'Do you want to post the %1?';
		        NothingToPostErr: Label 'There is nothing to post.';
		
		    local procedure "Code"(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    var
		        HideDialog: Boolean;
		        IsHandled: Boolean;
		    begin
		        HideDialog := false;
		        IsHandled := false;
		        OnBeforeConfirmPost(«header.tableVariableName», HideDialog, IsHandled);
		        if IsHandled then
		            exit;
		
		        if not HideDialog then
		            if not Confirm(PostConfirmQst, false, «header.tableVariableName».TableCaption) then
		                exit;
		
		        CODEUNIT.Run(CODEUNIT::«document.codeunitNamePost.saveQuote», «header.tableVariableName»);
		
		        OnAfterPost(«header.tableVariableName»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeConfirmPost(var «header.tableVariableName»: Record «header.tableName.saveQuote»; var HideDialog: Boolean; var IsHandled: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterPost(var «header.tableVariableName»: Record «header.tableName.saveQuote»)
		    begin
		    end;
		
		}
	'''
	
	static def doGenerateCodeunitJnlCheckLine(Document document) '''
		«val solution = document.solution»
		«val ledgerEntry = solution.ledgerEntry»
		«val master = solution.master»
		codeunit «management.newCodeunitNo» «document.codeunitNameJnlCheckLine.saveQuote»
		{
		    TableNo = «solution.ledgerEntry.tableNameJournal.saveQuote»;
		
		    trigger OnRun()
		    begin
		        RunCheck(Rec);
		    end;
		
		    var
		        CannotBeClosingDateErr: Label 'cannot be a closing date';
		
		    procedure RunCheck(var «ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»)
		    var
		        IsHandled: Boolean;
		    begin
		        IsHandled := false;
		        OnBeforeRunCheck(«ledgerEntry.tableVariableNameJournal», IsHandled);
		        if IsHandled then
		            exit;
		
		        with «ledgerEntry.tableVariableNameJournal» do begin
		            if EmptyLine then
		                exit;
		
		            TestField("«master.name» No.");
		            TestField("Posting Date");
		
		            CheckPostingDate(«ledgerEntry.tableVariableNameJournal»);
		
		            if "Document Date" <> 0D then
		                if "Document Date" <> NormalDate("Document Date") then
		                    FieldError("Document Date", CannotBeClosingDateErr);
		        end;
		
		        OnAfterRunCheck(«ledgerEntry.tableVariableNameJournal»);
		    end;
		
		    local procedure CheckPostingDate(«ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»)
		    var
		        UserSetupManagement: Codeunit "User Setup Management";
		        IsHandled: Boolean;
		    begin
		        with «ledgerEntry.tableVariableNameJournal» do begin
		            if "Posting Date" <> NormalDate("Posting Date") then
		                FieldError("Posting Date", CannotBeClosingDateErr);
		
		            IsHandled := false;
		            OnCheckPostingDateOnBeforeCheckAllowedPostingDate("Posting Date", IsHandled);
		            if IsHandled then
		                exit;
		
		            UserSetupManagement.CheckAllowedPostingDate("Posting Date");
		        end;
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeRunCheck(var «ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»; var IsHandled: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterRunCheck(var «ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnCheckPostingDateOnBeforeCheckAllowedPostingDate(PostingDate: Date; var IsHandled: Boolean);
		    begin
		    end;
		
		}
	'''
	
	static def doGenerateCodeunitJnlPostLine(Document document) '''
		«val solution = document.solution»
		«val ledgerEntry = solution.ledgerEntry»
		«val master = solution.master»
		codeunit «management.newCodeunitNo» «document.codeunitNameJnlPostLine.saveQuote»
		{
		    Permissions = TableData «ledgerEntry.tableName.saveQuote» = imd,
		                  TableData «ledgerEntry.tableNameRegister.saveQuote» = imd;
		    TableNo = «ledgerEntry.tableNameJournal.saveQuote»;
		
		    trigger OnRun()
		    begin
		        RunWithCheck(Rec);
		    end;
		
		    var
		        NextEntryNo: Integer;
		        «ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»;
		        «document.codeunitVariableNameJnlCheckLine»: Codeunit «document.codeunitNameJnlCheckLine.saveQuote»;
		        «ledgerEntry.tableVariableName»: Record «ledgerEntry.tableName.saveQuote»;
		        «ledgerEntry.tableVariableNameRegister»: Record «ledgerEntry.tableNameRegister.saveQuote»;
		        «master.tableVariableName»: Record «master.tableName.saveQuote»;
		
		    procedure RunWithCheck(var «ledgerEntry.tableVariableNameJournal»2: Record «ledgerEntry.tableNameJournal.saveQuote»)
		    begin
		        «ledgerEntry.tableVariableNameJournal».Copy(«ledgerEntry.tableVariableNameJournal»2);
		        Code;
		        «ledgerEntry.tableVariableNameJournal»2 := «ledgerEntry.tableVariableNameJournal»;
		    end;
		
		    local procedure "Code"()
		    var
		        IsHandled: Boolean;
		    begin
		        OnBeforePostJnlLine(«ledgerEntry.tableVariableNameJournal»);
		
		        with «ledgerEntry.tableVariableNameJournal» do begin
		            if EmptyLine then
		                exit;
		
		            «document.codeunitVariableNameJnlCheckLine».RunCheck(«ledgerEntry.tableVariableNameJournal»);
		
		            if NextEntryNo = 0 then begin
		                «ledgerEntry.tableVariableName».LockTable();
		                NextEntryNo := «ledgerEntry.tableVariableName».GetLastEntryNo() + 1;
		            end;
		
		            if "Document Date" = 0D then
		                "Document Date" := "Posting Date";
		
		            if «ledgerEntry.tableVariableNameRegister»."No." = 0 then begin
		                «ledgerEntry.tableVariableNameRegister».LockTable;
		                if (not «ledgerEntry.tableVariableNameRegister».FindLast()) or («ledgerEntry.tableVariableNameRegister»."To Entry No." <> 0) then begin
		                    «ledgerEntry.tableVariableNameRegister».Init();
		                    «ledgerEntry.tableVariableNameRegister»."No." := «ledgerEntry.tableVariableNameRegister»."No." + 1;
		                    «ledgerEntry.tableVariableNameRegister»."From Entry No." := NextEntryNo;
		                    «ledgerEntry.tableVariableNameRegister»."To Entry No." := NextEntryNo;
		                    «ledgerEntry.tableVariableNameRegister»."Creation Date" := Today;
		                    «ledgerEntry.tableVariableNameRegister»."Creation Time" := Time;
		                    «ledgerEntry.tableVariableNameRegister»."Source Code" := "Source Code";
		                    «ledgerEntry.tableVariableNameRegister»."Journal Batch Name" := "Journal Batch Name";
		                    «ledgerEntry.tableVariableNameRegister»."User ID" := UserId;
		                    «ledgerEntry.tableVariableNameRegister».Insert();
		                end;
		            end;
		            «ledgerEntry.tableVariableNameRegister»."To Entry No." := NextEntryNo;
		            «ledgerEntry.tableVariableNameRegister».Modify();
		
		            «master.tableVariableName».Get("«master.name» No.");
		
		            IsHandled := false;
		            OnBeforeCheck«master.tableVariableName»Blocked(«master.tableVariableName», IsHandled);
		            if not IsHandled then
		                «master.tableVariableName».TestField(Blocked, false);
		
		            «ledgerEntry.tableVariableName».Init();
		            «ledgerEntry.tableVariableName».CopyFrom«ledgerEntry.tableVariableNameJournal»(«ledgerEntry.tableVariableNameJournal»);
		
		            «ledgerEntry.tableVariableName»."User ID" := UserId;
		            «ledgerEntry.tableVariableName»."Entry No." := NextEntryNo;
		
		            OnBeforeLedgerEntryInsert(«ledgerEntry.tableVariableName», «ledgerEntry.tableVariableNameJournal»);
		
		            «ledgerEntry.tableVariableName».Insert(true);
		
		            NextEntryNo := NextEntryNo + 1;
		        end;
		
		        OnAfterPostJnlLine(«ledgerEntry.tableVariableNameJournal»);
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforePostJnlLine(var «ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeCheck«master.tableVariableName»Blocked(«master.tableVariableName»: Record «master.tableName.saveQuote»; var IsHandled: Boolean)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnBeforeLedgerEntryInsert(var «ledgerEntry.tableVariableName»: Record «ledgerEntry.tableName.saveQuote»; «ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»)
		    begin
		    end;
		
		    [IntegrationEvent(false, false)]
		    local procedure OnAfterPostJnlLine(var «ledgerEntry.tableVariableNameJournal»: Record «ledgerEntry.tableNameJournal.saveQuote»)
		    begin
		    end;
		
		}
	'''
	
}