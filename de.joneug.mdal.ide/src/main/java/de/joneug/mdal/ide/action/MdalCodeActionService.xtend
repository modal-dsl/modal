package de.joneug.mdal.ide.action

import de.joneug.mdal.validation.MdalValidator
import org.eclipse.emf.common.util.URI
import org.eclipse.lsp4j.CodeAction
import org.eclipse.lsp4j.CodeActionKind
import org.eclipse.lsp4j.Command
import org.eclipse.lsp4j.Diagnostic
import org.eclipse.lsp4j.Range
import org.eclipse.lsp4j.TextEdit
import org.eclipse.lsp4j.WorkspaceEdit
import org.eclipse.lsp4j.jsonrpc.messages.Either
import org.eclipse.xtext.ide.server.codeActions.ICodeActionService2

import static extension de.joneug.mdal.ide.extensions.RangeExtensions.*
import de.joneug.mdal.ide.command.MdalCommandService

class MdalCodeActionService implements ICodeActionService2 {
	
	override getCodeActions(Options options) {
		val codeActions = <CodeAction>newArrayList
		
		val document = options.document
		val resource = options.resource
		
		for (diagnostic : options.codeActionParams.context.diagnostics) {
			switch(diagnostic.code.get) {
				case MdalValidator.ENTITY_NAME_DESCRIPTION: {
					val contentBefore = document.getSubstring(diagnostic.range.rangeBefore)
					
					codeActions += createCodeAction('Add Description field.', resource.URI, diagnostic, new TextEdit => [
						newText = 'template("Description"; Description)\n' + contentBefore
						range = new Range(diagnostic.range.start, diagnostic.range.start)
					])
					
					codeActions += createCodeAction('Add Name field.', resource.URI, diagnostic, new TextEdit => [
						newText = 'template("Name"; Name)\n' + contentBefore
						range = new Range(diagnostic.range.start, diagnostic.range.start)
					])
				}
				case MdalValidator.CUSTOM_FIELD_UNKNOWN_TABLE: {
					codeActions += createCodeActionCommand('Load symbol references.', MdalCommandService.LOAD_SYMBOL_REFERENCES + MdalCommandService.PROXY_SUFFIX, diagnostic)
				}
			}
		}
				
		return codeActions.map[Either.forRight(it)]
	}
	
	protected def CodeAction createCodeAction(String codeActionTitle, URI uri, Diagnostic diagnostic, TextEdit... edits) {
		return new CodeAction => [
			kind = CodeActionKind.QuickFix
			title = codeActionTitle
			isPreferred = true
			diagnostics = #[diagnostic]
			edit = new WorkspaceEdit => [
				changes.put(uri.toString, edits.toList)
			]
		]
	}
	
	protected def CodeAction createCodeActionCommand(String codeActionTitle, String commandId, Diagnostic diagnostic) {
		return new CodeAction => [
			kind = CodeActionKind.QuickFix
			title = codeActionTitle
			isPreferred = false
			diagnostics = #[diagnostic]
			command = new Command => [
				command = commandId
				title = codeActionTitle
			]
		]
	}
	
}