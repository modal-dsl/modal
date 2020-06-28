package de.joneug.mdal.ide.contentassist

import com.google.inject.Inject
import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.DocumentHeader
import de.joneug.mdal.mdal.DocumentLine
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.Journal
import de.joneug.mdal.mdal.Master
import de.joneug.mdal.mdal.Supplemental
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

class MdalIdeContentProposalProvider extends IdeContentProposalProvider {

	protected GeneratorManagement management = GeneratorManagement.getInstance()

	@Inject
	extension MdalGrammarAccess grammarAccess

	override protected createProposals(AbstractElement assignment, ContentAssistContext context, IIdeContentProposalAcceptor acceptor) {
		switch (assignment) {
			case grammarAccess.includeFieldAccess.entityNameAssignment_2: {
				logInfo("Adding Entity proposals for IncludeField")
				
				val currentModel = context.currentModel

				if(currentModel.getContainerOfType(DocumentHeader) !== null) {
					addEntityProposals(context, acceptor, #[Master, Supplemental])
				} else if(currentModel.getContainerOfType(DocumentLine) !== null) {
					addEntityProposals(context, acceptor, #[Master, Supplemental, DocumentHeader])
				} else if(currentModel.getContainerOfType(Journal) !== null) {
					addEntityProposals(context, acceptor, #[Master, Supplemental, DocumentHeader, DocumentLine])
				} else {
					super.createProposals(assignment, context, acceptor)
				}
			}
			case grammarAccess.includeFieldAccess.fieldNameAssignment_4: {
				logInfo("Adding Field proposals for IncludeField")
				
				if(!(context.currentModel instanceof IncludeField)) {
					super.createProposals(assignment, context, acceptor)
				}

				val includeField = context.currentModel as IncludeField
				val entity = includeField.entity

				if(entity === null) {
					super.createProposals(assignment, context, acceptor)
				}

				entity.fields.forEach [
					addProposal(context, acceptor, it.name, ContentAssistEntry.KIND_FIELD)
				]
			}
			case grammarAccess.customFieldAccess.tableRelationAssignment_6_1_1_2: {
				management.symbolReferences.forEach [symbolReference |
					var tables = symbolReference.tables
					
					// Filter based on typed string
					if(context.currentModel instanceof CustomField) {
						val customField = context.currentModel as CustomField
						
						if(!customField.tableRelation.isNullOrEmpty) {
							tables = tables.filter [table |
								table.name.contains(customField.tableRelation)
							].toList
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

	protected def <T extends Entity> addEntityProposals(ContentAssistContext context, IIdeContentProposalAcceptor acceptor, Class<T>[] entityTypes) {
		entityTypes.forEach [ entityType |
			context.currentModel.getAllContentsOfTypeFromRoot(entityType).forEach [ entity |
				addProposal(context, acceptor, entity.name, ContentAssistEntry.KIND_CLASS)
			]
		]
	}

	protected def addSnippet(ContentAssistContext context, IIdeContentProposalAcceptor acceptor, String snippetText, String description, String documentation) {
		val snippet = proposalCreator.createSnippet(snippetText, description, context)
		if(!documentation.isNullOrEmpty) {
			snippet.documentation = "Snippet: " + documentation + " (mdAL)"
		}
		acceptor.accept(snippet, proposalPriorities.getDefaultPriority(snippet))
	}

}
