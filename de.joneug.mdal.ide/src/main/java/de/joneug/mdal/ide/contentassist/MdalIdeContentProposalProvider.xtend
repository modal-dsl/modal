package de.joneug.mdal.ide.contentassist

import com.google.inject.Inject
import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.services.MdalGrammarAccess
import org.eclipse.xtext.AbstractElement
import org.eclipse.xtext.RuleCall
import org.eclipse.xtext.ide.editor.contentassist.ContentAssistContext
import org.eclipse.xtext.ide.editor.contentassist.ContentAssistEntry
import org.eclipse.xtext.ide.editor.contentassist.IIdeContentProposalAcceptor
import org.eclipse.xtext.ide.editor.contentassist.IdeContentProposalProvider

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*
import org.eclipse.xtext.Keyword

class MdalIdeContentProposalProvider extends IdeContentProposalProvider {

	protected GeneratorManagement management = GeneratorManagement.getInstance()

	@Inject
	extension MdalGrammarAccess grammarAccess

	override protected createProposals(AbstractElement assignment, ContentAssistContext context, IIdeContentProposalAcceptor acceptor) {
		switch (assignment) {
			case grammarAccess.includeFieldAccess.entityAssignment_2: {
				logInfo("Adding Entity proposals for IncludeField")
				context.currentModel.getAllContentsOfTypeFromRoot(Entity).forEach [
					addProposal(context, acceptor, it.name, ContentAssistEntry.KIND_CLASS)
				]
			}
			case grammarAccess.includeFieldAccess.fieldAssignment_4: {
				if(!(context.currentModel instanceof IncludeField)) {
					super.createProposals(assignment, context, acceptor)
				}

				logInfo("Adding Field proposals for IncludeField")
				val includeField = context.currentModel as IncludeField
				includeField.getEntityObject.fields.forEach [
					addProposal(context, acceptor, it.name, ContentAssistEntry.KIND_FIELD)
				]
			}
			case grammarAccess.customFieldAccess.tableRelationAssignment_6_1_1_2: {
				management.symbolReferences.forEach [
					var tables = it.tables
					
					if(!(context.currentModel instanceof CustomField)) {
						val customField = context.currentModel as CustomField
						
						if(!customField.name.isNullOrEmpty) {
							print("filtering")
							tables = tables.filter[
								it.name.contains(customField.name)
							].toList
							print(tables)
						}
					}
					
					tables.forEach [
						addProposal(context, acceptor, it.name, ContentAssistEntry.KIND_CLASS)
					]
				]
			}
			default: {
				super.createProposals(assignment, context, acceptor)
			}
		}
	}
	
	override protected filterKeyword(Keyword keyword, ContentAssistContext context) {
		print("Filter Keyword")
		print(keyword)
		print(context)
		super.filterKeyword(keyword, context)
	}
	
	override protected _createProposals(RuleCall ruleCall, ContentAssistContext context, IIdeContentProposalAcceptor acceptor) {
		switch (ruleCall.rule) {
			case grammarAccess.solutionRule: {
				addSnippet(context, acceptor, '''
				solution "Seminar Management" {
					Prefix = "SEM";
					
					master "Seminar" {
						ShortName = "Sem.";
					}
				}
				''', "mdAL Solution", "Solution")			
			}
			case grammarAccess.templateFieldRule: {
				addSnippet(context, acceptor, '''template(${1:FieldName}; ${1:TemplateName})''', "Template Field", "Template Field")
			}
			default: {
				super._createProposals(ruleCall, context, acceptor)				
			}
		}
	}

	protected def addProposal(ContentAssistContext context, IIdeContentProposalAcceptor acceptor, String proposalText, String kind) {
		val proposal = proposalCreator.createProposal(proposalText.quote, "", context, kind, null)
		acceptor.accept(proposal, proposalPriorities.getDefaultPriority(proposal))
	}
	
	protected def addSnippet(ContentAssistContext context, IIdeContentProposalAcceptor acceptor, String snippetText, String description, String documentation) {
		val snippet = proposalCreator.createSnippet(snippetText, description, context)
		if(!documentation.isNullOrEmpty) {
			snippet.documentation = "Snippet: " + documentation + " (mdAL)"
		}
		acceptor.accept(snippet, proposalPriorities.getDefaultPriority(snippet))
	} 

}
