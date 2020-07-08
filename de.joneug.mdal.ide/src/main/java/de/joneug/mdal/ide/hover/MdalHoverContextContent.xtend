package de.joneug.mdal.ide.hover

import com.google.inject.Inject
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.services.MdalGrammarAccess
import de.joneug.mdal.ide.documentation.MdalIEObjectDocumentationProvider

import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*

class MdalHoverContextContent {
	
	@Inject
	MdalGrammarAccess ga
	
	@Inject
	MdalIEObjectDocumentationProvider documentationProvider
	
	def content(MdalHoverContext context) {
		val directGrammarElement = context.directGrammarElement
		val element = context.element
		
		switch (directGrammarElement) {
			case ga.includeFieldAccess.entityNameSTRINGTerminalRuleCall_4_0: {
				if(element instanceof IncludeField) {
					return documentationProvider.getDocumentation(element.entity)
				}
			}
			default: {
				return documentationProvider.getDocumentation(directGrammarElement)
			}
        }
    }
	
}
