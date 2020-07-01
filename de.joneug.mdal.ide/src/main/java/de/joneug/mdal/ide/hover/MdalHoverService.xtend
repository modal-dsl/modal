package de.joneug.mdal.ide.hover

import com.google.inject.Inject
import org.eclipse.lsp4j.Hover
import org.eclipse.xtext.Keyword
import org.eclipse.xtext.RuleCall
import org.eclipse.xtext.ide.server.Document
import org.eclipse.xtext.ide.server.hover.HoverContext
import org.eclipse.xtext.ide.server.hover.HoverService
import org.eclipse.xtext.resource.XtextResource

import static extension org.eclipse.xtext.nodemodel.util.NodeModelUtils.*

class MdalHoverService extends HoverService {
	
	@Inject
	MdalHoverContextContent mdalHoverContextContent

	override protected createContext(Document document, XtextResource resource, int offset) {
		var context = super.createContext(document, resource, offset)
		
		val parseResult = resource.parseResult
		if(parseResult === null) return null
		
		var leafNode = parseResult.rootNode.findLeafNodeAtOffset(offset)
		if (leafNode !== null && leafNode.hidden && leafNode.offset == offset) {
			leafNode = parseResult.rootNode.findLeafNodeAtOffset(offset - 1)
		}
		if(leafNode === null) return null
		
		if(leafNode.grammarElement instanceof Keyword || leafNode.grammarElement instanceof RuleCall) {
			context = new MdalHoverContext(context, leafNode)
		}
		
		return context
	}

	override protected hover(HoverContext context) {
		if(context instanceof MdalHoverContext) {
			val content = mdalHoverContextContent.content(context)
			
			if(!content.isNullOrEmpty) {
				return createHover(context, content)
			}
		}

		return super.hover(context)
	}
	
	protected def createHover(HoverContext context, String contentString) {
		val contents = toMarkupContent(context.kind, contentString)
		
		val range = context.range
		if(range === null) return EMPTY_HOVER
		
		return new Hover(contents, range)
	}

}
