package de.joneug.mdal.ide.documentation

import com.google.inject.Inject
import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.DocumentHeader
import de.joneug.mdal.mdal.DocumentLine
import de.joneug.mdal.mdal.Entity
import de.joneug.mdal.mdal.Field
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
import static extension de.joneug.mdal.extensions.StringExtensions.*

class MdalIEObjectDocumentationProvider implements IEObjectDocumentationProvider {
	
	@Inject
	MdalGrammarAccess ga
	
	override getDocumentation(EObject object) {
		return getDocumentationInternal(object)
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
	
	protected def dispatch String getDocumentationInternal(Field field) '''
	```mdal
	field «field.name.saveQuote»
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
		switch (keyword) {
			case ga.solutionAccess.solutionKeyword_0: {
				return 'The `solution` keyword starts a solution definition.'
			}
			case ga.solutionAccess.prefixKeyword_3_0_0: {
				return 'The `Prefix` keyword defines the prefix for all AL objects.'
			}
			case ga.masterAccess.shortNameKeyword_3_0_0: {
				return 'The `ShortName` keyword defines the short version of the entity\'s name.'
			}
			default: {
				return null
			}
		}
	}
	
}
