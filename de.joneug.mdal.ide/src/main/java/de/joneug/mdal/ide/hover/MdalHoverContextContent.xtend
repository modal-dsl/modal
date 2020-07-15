package de.joneug.mdal.ide.hover

import com.google.inject.Inject
import de.joneug.mdal.ide.documentation.MdalIEObjectDocumentationProvider
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.PageField
import de.joneug.mdal.services.MdalGrammarAccess

import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
import static extension de.joneug.mdal.extensions.PageFieldExtensions.*

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
			case ga.includeFieldAccess.fieldNameSTRINGTerminalRuleCall_6_0: {
				if(element instanceof IncludeField) {
					return documentationProvider.getDocumentation(element.field)
				}
			}
			case ga.pageFieldAccess.fieldNameSTRINGTerminalRuleCall_2_0: {
				if(element instanceof PageField) {
					val fieldEither = element.fieldEither
					if (fieldEither.isLeft) {
						return documentationProvider.getDocumentation(fieldEither.getLeft)
					} else {
						return documentationProvider.getDocumentation(fieldEither.getRight)
					}
				}
			}
			default: {
				return documentationProvider.getDocumentation(directGrammarElement)
			}
        }
    }
	
}
