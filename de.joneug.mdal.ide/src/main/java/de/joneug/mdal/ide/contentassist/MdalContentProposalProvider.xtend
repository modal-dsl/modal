package de.joneug.mdal.ide.contentassist

import com.google.inject.Inject
import de.joneug.mdal.services.MdalGrammarAccess
import java.util.Collection
import org.eclipse.xtext.AbstractElement
import org.eclipse.xtext.RuleCall
import org.eclipse.xtext.ide.editor.contentassist.ContentAssistContext
import org.eclipse.xtext.ide.editor.contentassist.IIdeContentProposalAcceptor
import org.eclipse.xtext.ide.editor.contentassist.IdeContentProposalProvider

import de.joneug.mdal.mdal.MdalPackage

import static extension de.joneug.mdal.util.ObjectExtensions.*

class MdalContentProposalProvider extends IdeContentProposalProvider {
	
	@Inject
	extension MdalGrammarAccess stAccess
	
    static val LIBS = #[
        "XX1", "XX2", "YY1", "YY2"
    ]
	
	override protected createProposals(AbstractElement assignment, ContentAssistContext context, IIdeContentProposalAcceptor acceptor) {
		logInfo("MdalContentProposalProvider - createProposals AbstractElement")
		switch(assignment) {
			case stAccess.alExtensionAccess.descriptionAssignment_9_1: {
				for (lib : LIBS) {//.filter[it.startsWith(context.prefix)]) {
					var proposal = proposalCreator.createProposal(lib + ".*;", context) [
                        source = lib
                        description = "import entire library contents"
                    ]
                    acceptor.accept(proposal, proposalPriorities.getDefaultPriority(proposal))
				}
				
			}
			default: {
				super.createProposals(assignment, context, acceptor)				
			}
		}
	}
	
	override createProposals(Collection<ContentAssistContext> contexts, IIdeContentProposalAcceptor acceptor) {
		logInfo("MdalContentProposalProvider - createProposals Collection")
		super.createProposals(contexts, acceptor)
	}
	
	override protected _createProposals(RuleCall ruleCall, ContentAssistContext context, IIdeContentProposalAcceptor acceptor) {
		logInfo("MdalContentProposalProvider - _createProposals")
		if (idRangeRule == ruleCall.rule && context.currentModel !== null) {
			val scope = scopeProvider.getScope(context.currentModel, MdalPackage.Literals.AL_EXTENSION__ID_RANGES)
			acceptor.accept(
				proposalCreator.
					createSnippet('''Hello ${1|A,B,C|} from ${2|«scope.allElements.map[name.toString].join(",")»|}!''',
						"New Greeting (Template with Choice)", context), 0)
			acceptor.accept(
				proposalCreator.createSnippet('''Hello ${1:name} from ${2:fromName}!''',
					"New Greeting (Template with Placeholder)", context), 0)
		}
	
		super._createProposals(ruleCall, context, acceptor)
	}
	
}