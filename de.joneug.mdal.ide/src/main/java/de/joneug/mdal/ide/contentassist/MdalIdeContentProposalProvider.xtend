package de.joneug.mdal.ide.contentassist

import com.google.inject.Inject
import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.DocumentHeader
import de.joneug.mdal.mdal.DocumentLine
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.LedgerEntry
import de.joneug.mdal.mdal.Master
import de.joneug.mdal.mdal.PageField
import de.joneug.mdal.mdal.Supplemental
import de.joneug.mdal.services.MdalGrammarAccess
import org.eclipse.xtext.AbstractElement
import org.eclipse.xtext.RuleCall
import org.eclipse.xtext.ide.editor.contentassist.ContentAssistContext
import org.eclipse.xtext.ide.editor.contentassist.ContentAssistEntry
import org.eclipse.xtext.ide.editor.contentassist.IIdeContentProposalAcceptor
import org.eclipse.xtext.ide.editor.contentassist.IdeContentProposalProvider

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.IncludeFieldExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*
import static extension de.joneug.mdal.extensions.PageFieldExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class MdalIdeContentProposalProvider extends IdeContentProposalProvider {

	protected GeneratorManagement management = GeneratorManagement.getInstance()

	@Inject
	extension MdalGrammarAccess ga

	override protected createProposals(AbstractElement assignment, ContentAssistContext context, IIdeContentProposalAcceptor acceptor) {
		try {			
			if(assignment == ga.includeFieldAccess.entityNameAssignment_4) {				
				val currentModel = context.currentModel
				
				var String prefix = null
				if(currentModel instanceof IncludeField) {
					prefix = currentModel.entityName
				}
	
				if(currentModel.getContainerOfType(DocumentHeader) !== null) {
					addEntityProposals(context, acceptor, prefix, #[Master, Supplemental])
					return
				} else if(currentModel.getContainerOfType(DocumentLine) !== null) {
					addEntityProposals(context, acceptor, prefix, #[Master, Supplemental, DocumentHeader])
					return
				} else if(currentModel.getContainerOfType(LedgerEntry) !== null) {
					addEntityProposals(context, acceptor, prefix, #[Master, Supplemental, DocumentHeader, DocumentLine])
					return
				}
			} else if(assignment == ga.includeFieldAccess.fieldNameAssignment_6) {				
				if(context.currentModel instanceof IncludeField) {
					val includeField = context.currentModel as IncludeField
					val entity = includeField.entity
		
					if(entity !== null) {
						entity.inferredFieldNames.forEach [
							addProposal(context, acceptor, it, includeField.fieldName, ContentAssistEntry.KIND_FIELD)
						]
						return
					}
				}
			} else if(assignment == ga.customFieldAccess.tableRelationAssignment_6_1_2) {
				management.symbolReferences.forEach [symbolReference |
					var tables = symbolReference.tables
					
					var String prefix = null
					if(context.currentModel instanceof CustomField) {
						val customField = context.currentModel as CustomField
						prefix = customField.tableRelation			
					}
					val prefixFinal = prefix
	
					tables.forEach [
						addProposal(context, acceptor, it.name, prefixFinal, ContentAssistEntry.KIND_CLASS)
					]
					return
				]
			} else if(assignment == ga.pageFieldAccess.fieldNameAssignment_2) {
				if(context.currentModel instanceof PageField) {
					val pageField = context.currentModel as PageField
					val entity = pageField.entity
					
					if(entity !== null) {
						entity.fields.forEach [
							addProposal(context, acceptor, it.name, pageField.fieldName, ContentAssistEntry.KIND_FIELD)
						]
						entity.inferredIncludeFields.forEach[
							addProposal(context, acceptor, it.name, pageField.fieldName, ContentAssistEntry.KIND_FIELD)
						]
						return
					}
				}
			}
		} catch(Exception e) {
			this.logError("No proposals could be provided with context '" + context + "'\nException:")
			e.printStackTrace(System.err)
		}
		
		super.createProposals(assignment, context, acceptor)
	}

	override protected _createProposals(RuleCall ruleCall, ContentAssistContext context, IIdeContentProposalAcceptor acceptor) {
		val masterTemplate = '''
			master ${1:"Name"} {
				ShortName = ${2:"Short Name"};
				
				fields {
					template("Description"; Description)
				}
				cardPage {
					group("General") {
						field("Description")
					}
				}
				listPage {
					field("Description")
				}
			}
		'''
		val documentHeaderTemplate = '''
			header ${1:"Name"} {
				ShortName = ${2:"Short Name"};
				StatusCaptions = ["Open", "Released"];
				
				fields {
					template("Salesperson"; Salesperson)
				}
				
				documentPage {
					group("General") {
						field("Salesperson")
					}
				}
				
				listPage {
					field("Salesperson")
				}
			}
		'''
		val documentLineTemplate = '''
			line ${1:"Name"} {
				ShortName = ${2:"Short Name"};
				
				fields {
					field("Quantity"; Decimal)
				}
				listPartPage {
					field("Quantity")
				}
			}
		'''
		val documentTemplate = '''
			document ${1:"Name"} {
				ShortName = ${2:"Short Name"};
				
				«documentHeaderTemplate.replace('${1:', '${3:').replace('${2:', '${4:')»
				
				«documentLineTemplate.replace('${1:', '${5:').replace('${2:', '${6:')»
			}
		'''
		val supplementalTemplate = '''
			supplemental ${1:"Name"} {
				ShortName = ${2:"Short Name"};
				
				fields {
					template("Name"; Name)
				}
				
				listPage {
					field("Name")
				}
			}
		'''
		val ledgerEntryTemplate = '''
			ledgerEntry ${1:"Name"} {
				ShortName = ${2:"Short Name"};
				
				fields {
					field("Quantity"; Decimal)
				}
				listPage {
					field("Quantity")
				}
			}
		'''
		val solutionTemplate = '''
			solution ${1:"Name"} {
				Prefix = ${2:"PRE"};
			}
		'''
		if(ruleCall == ga.modelAccess.solutionSolutionParserRuleCall_0) {
			addSnippet(context, acceptor, solutionTemplate, "solution (template)")
		} else if(ruleCall == ga.solutionAccess.masterMasterParserRuleCall_3_1_0) {
			addSnippet(context, acceptor, masterTemplate, "master (template)")
		} else if(ruleCall == ga.solutionAccess.supplementalsSupplementalParserRuleCall_3_2_0) {
			addSnippet(context, acceptor, supplementalTemplate, "supplemental (template)")
		} else if(ruleCall == ga.solutionAccess.documentDocumentParserRuleCall_3_3_0) {
			addSnippet(context, acceptor, documentTemplate, "document (template)")
		} else if(ruleCall == ga.documentAccess.headerDocumentHeaderParserRuleCall_3_1_0) {
			addSnippet(context, acceptor, documentHeaderTemplate, "header (template)")
		} else if(ruleCall == ga.documentAccess.lineDocumentLineParserRuleCall_3_2_0) {
			addSnippet(context, acceptor, documentLineTemplate, "line (template)")
		} else if(ruleCall == ga.solutionAccess.ledgerEntryLedgerEntryParserRuleCall_3_4_0) {
			addSnippet(context, acceptor, ledgerEntryTemplate, "ledgerEntry (template)")
		} else if(ruleCall == ga.fieldAccess.templateFieldParserRuleCall_1) {
			addSnippet(context, acceptor, '''template(${1:"FieldName"}; ${2:Description})''', "template (template)")
		} else if(ruleCall == ga.fieldAccess.customFieldParserRuleCall_0) {
			addSnippet(context, acceptor, '''field(${1:"FieldName"}; ${2:Decimal})''', "field (template)")
		} else {
			super._createProposals(ruleCall, context, acceptor)
		}
	}

	protected def addProposal(ContentAssistContext context, IIdeContentProposalAcceptor acceptor, String proposalText, String prefix, String kind) {
		val proposal = proposalCreator.createProposal(prefix === null ? proposalText.quote : proposalText, prefix === null ? "" : prefix, context, kind, null)
		acceptor.accept(proposal, proposalPriorities.getDefaultPriority(proposal))
	}

	protected def <T extends Entity> addEntityProposals(ContentAssistContext context, IIdeContentProposalAcceptor acceptor, String prefix, Class<T>[] entityTypes) {
		entityTypes.forEach [ entityType |
			context.currentModel.getAllContentsOfTypeFromRoot(entityType).forEach [ entity |
				addProposal(context, acceptor, entity.name, prefix, ContentAssistEntry.KIND_CLASS)
			]
		]
	}

	protected def addSnippet(ContentAssistContext context, IIdeContentProposalAcceptor acceptor, String snippetText, String description) {
		val snippet = proposalCreator.createSnippet(snippetText, description, context)
		acceptor.accept(snippet, proposalPriorities.getDefaultPriority(snippet))
	}

}
