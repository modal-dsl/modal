package de.joneug.mdal.ide.documentation

import com.google.inject.Inject
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.DocumentHeader
import de.joneug.mdal.mdal.DocumentLine
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.IncludeField
import de.joneug.mdal.mdal.LedgerEntry
import de.joneug.mdal.mdal.Master
import de.joneug.mdal.mdal.Solution
import de.joneug.mdal.mdal.Supplemental
import de.joneug.mdal.mdal.TemplateField
import de.joneug.mdal.services.MdalGrammarAccess
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.Keyword
import org.eclipse.xtext.documentation.IEObjectDocumentationProvider

import static extension de.joneug.mdal.extensions.FieldTypeExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*
import static extension de.joneug.mdal.extensions.StringExtensions.*

class MdalIEObjectDocumentationProvider implements IEObjectDocumentationProvider {
	
	@Inject
	MdalGrammarAccess ga
	
	override getDocumentation(EObject object) {
		if(object === null) return null
		
		try {
			return getDocumentationInternal(object)
		} catch(Exception e) {
			this.logError("Documentation for EObject '" + object + "' could not be provided\nException:")
			e.printStackTrace(System.err)
		}
		
		return null
	}
	
	protected def dispatch String getDocumentationInternal(EObject object) {
		return null
	}
	
	protected def dispatch String getDocumentationInternal(Solution solution) '''
		```mdal
		solution «solution.name.saveQuote»
		```
	'''
	
	protected def dispatch String getDocumentationInternal(Master master) '''
		```mdal
		master «master.name»
		
		«master.fieldsDocumentation»
		```
	'''
	
	protected def dispatch String getDocumentationInternal(Supplemental supplemental) '''
		```mdal
		supplemental «supplemental.name.saveQuote»
		
		«supplemental.fieldsDocumentation»
		```
	'''
	
	protected def dispatch String getDocumentationInternal(DocumentHeader documentHeader) '''
		```mdal
		document header «documentHeader.name.saveQuote»
		
		«documentHeader.fieldsDocumentation»
		```
	'''
	
	protected def dispatch String getDocumentationInternal(DocumentLine documentLine) '''
		```mdal
		document line «documentLine.name.saveQuote»
		
		«documentLine.fieldsDocumentation»
		```
	'''
	
	protected def dispatch String getDocumentationInternal(LedgerEntry ledgerEntry) '''
		```mdal
		ledgerEntry «ledgerEntry.name.saveQuote»
		
		«ledgerEntry.fieldsDocumentation»
		```
	'''
	
	protected def dispatch String getDocumentationInternal(CustomField field) '''
		```mdal
		field «field.name.saveQuote»: «field.type.doGenerate»
		```
	'''
	
	protected def dispatch String getDocumentationInternal(TemplateField field) '''
		```mdal
		template «field.name.saveQuote»: «field.type.class.simpleName.replace('Impl', '').replace('Template', '')»
		```
	'''
	
	protected def dispatch String getDocumentationInternal(IncludeField field) '''
		```mdal
		include «field.name.saveQuote»: «field.entityName.saveQuote».«field.fieldName.saveQuote»
		```
	'''
	
	protected def getFieldsDocumentation(Entity entity) '''
		«FOR field : entity.fields»
			«IF field instanceof CustomField»
				«field.name.saveQuote.padEnd(35)»«field.type.doGenerate»
			«ELSEIF field instanceof TemplateField»
				«field.name.saveQuote.padEnd(35)»template
			«ENDIF»
		«ENDFOR»
	'''
	
	protected def dispatch String getDocumentationInternal(Keyword keyword) {
		if(keyword == ga.solutionAccess.solutionKeyword_0) {
			return 'The `solution` keyword starts a solution definition.'
		} else if(keyword == ga.documentAccess.documentKeyword_0) {
			return 'The `document` keyword starts a document definition.'
		} else if(keyword == ga.pageFieldAccess.fieldKeyword_0) {
			return 'The `field` keyword defines a page field.'
		} else if(keyword == ga.groupAccess.groupKeyword_0) {
			return 'The `group` keyword defines a group of page field inside a card page or document page.'
		} else if(keyword == ga.masterAccess.cardPageKeyword_3_2_0) {
			return 'The `cardPage` keyword stars a card page definition.'
		} else if(keyword == ga.documentHeaderAccess.documentPageKeyword_4_3_0) {
			return 'The `documentPage` keyword stars a document page definition.'
		} else if(keyword == ga.documentLineAccess.listPartPageKeyword_4_2_0) {
			return 'The `listPartPage` keyword stars a list part page (subform) definition.'
		} else if(keyword == ga.masterAccess.listPageKeyword_3_3_0 || keyword == ga.supplementalAccess.listPageKeyword_3_2_0 ||
			keyword == ga.documentHeaderAccess.listPageKeyword_4_4_0 || keyword == ga.ledgerEntryAccess.listPageKeyword_4_2_0) {
			return 'The `listPage` keyword stars a list page definition.'
		} else if(keyword == ga.solutionAccess.prefixKeyword_3_0_0) {
			return 'The `Prefix` keyword defines the prefix for all AL objects.'
		} else if(keyword == ga.masterAccess.fieldsKeyword_3_1_0 || keyword == ga.supplementalAccess.fieldsKeyword_3_1_0 ||
			keyword == ga.documentHeaderAccess.fieldsKeyword_4_2_0 || keyword == ga.ledgerEntryAccess.fieldsKeyword_4_1_0) {
			return 'The `fields` keyword starts a table fields definition.'
		} else if(keyword == ga.masterAccess.shortNameKeyword_3_0_0 || keyword == ga.supplementalAccess.shortNameKeyword_3_0_0 ||
			keyword == ga.documentAccess.shortNameKeyword_3_0_0 || keyword == ga.documentHeaderAccess.shortNameKeyword_4_0_0 ||
			keyword == ga.documentLineAccess.shortNameKeyword_4_0_0 || keyword == ga.ledgerEntryAccess.shortNameKeyword_4_0_0) {
			return 'The `ShortName` keyword defines the short version of the entity\'s name.'
		} else if(keyword == ga.customFieldAccess.tableRelationKeyword_6_1_0) {
			return 'The `TableRelation` keyword defines a relation to an existing AL table in the BC database.'
		} else if(keyword == ga.documentHeaderAccess.statusCaptionsKeyword_4_1_0) {
			return 'The `StatusCaptions` keyword defines the document header status entries.'
		} else if(keyword == ga.includeFieldAccess.validateKeyword_8_1_0) {
			return 'The `Validate` keyword defines whether or not the assignment of values form the field to be included is validated.'
		}

		return null
	}
	
}
