package de.joneug.mdal.ide.hover

import com.google.inject.Inject
import de.joneug.mdal.ide.documentation.MdalIEObjectDocumentationProvider
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.PageField
import de.joneug.mdal.services.MdalGrammarAccess

import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
import static extension de.joneug.mdal.extensions.PageFieldExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*

class MdalHoverContextContent {
	
	@Inject
	MdalGrammarAccess ga
	
	@Inject
	MdalIEObjectDocumentationProvider documentationProvider
	
	def content(MdalHoverContext context) {
		val directGrammarElement = context.directGrammarElement
		val element = context.element
		
		try {
			if(element instanceof IncludeField) {
				if(directGrammarElement == ga.includeFieldAccess.entityNameSTRINGTerminalRuleCall_4_0) {
					return documentationProvider.getDocumentation(element.entity)
				} else if(directGrammarElement == ga.includeFieldAccess.fieldNameSTRINGTerminalRuleCall_6_0) {
					return documentationProvider.getDocumentation(element.field)
				}
			} else if(element instanceof PageField) {
				if(directGrammarElement == ga.pageFieldAccess.fieldNameSTRINGTerminalRuleCall_2_0) {
					val fieldEither = element.fieldEither
					if(fieldEither !== null) {
						if(fieldEither.isLeft) {
							return documentationProvider.getDocumentation(fieldEither.getLeft)
						} else {
							return documentationProvider.getDocumentation(fieldEither.getRight)
						}					
					}
				}
			}
		} catch(Exception e) {
			this.logError("No hover content could be provided with context '" + context + "'\nException:")
			e.printStackTrace(System.err)
		}
		
		return documentationProvider.getDocumentation(directGrammarElement)
    }
	
}
