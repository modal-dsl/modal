package de.joneug.mdal.ide.hover;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.ide.server.hover.HoverContext;
import org.eclipse.xtext.nodemodel.ILeafNode;

public class MdalHoverContext extends HoverContext {

	protected EObject directGrammarElement;

	public MdalHoverContext(HoverContext hoverContext, ILeafNode leafNode) {
		super(hoverContext.getDocument(), hoverContext.getResource(), hoverContext.getOffset(),
				leafNode.getTextRegion(), hoverContext.getElement());
		
		this.directGrammarElement = leafNode.getGrammarElement();		
	}
	
	public EObject getDirectGrammarElement() {
		return this.directGrammarElement;
	}

}
