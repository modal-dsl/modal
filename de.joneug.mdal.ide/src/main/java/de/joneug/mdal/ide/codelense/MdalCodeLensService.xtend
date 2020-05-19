package de.joneug.mdal.ide.codelense

import org.eclipse.lsp4j.CodeLensParams
import org.eclipse.xtext.ide.server.Document
import org.eclipse.xtext.ide.server.codelens.ICodeLensService
import org.eclipse.xtext.resource.XtextResource
import org.eclipse.xtext.util.CancelIndicator

class MdalCodeLensService implements ICodeLensService {
	
	override computeCodeLenses(Document document, XtextResource resource, CodeLensParams params, CancelIndicator indicator) {
		return #[]
	}
	
}