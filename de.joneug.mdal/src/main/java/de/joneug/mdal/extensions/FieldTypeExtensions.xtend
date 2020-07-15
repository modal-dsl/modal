package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.TypeBigInteger
import de.joneug.mdal.mdal.TypeBlob
import de.joneug.mdal.mdal.TypeBoolean
import de.joneug.mdal.mdal.TypeCode
import de.joneug.mdal.mdal.TypeDate
import de.joneug.mdal.mdal.TypeDateFormula
import de.joneug.mdal.mdal.TypeDateTime
import de.joneug.mdal.mdal.TypeDecimal
import de.joneug.mdal.mdal.TypeDuration
import de.joneug.mdal.mdal.TypeEnum
import de.joneug.mdal.mdal.TypeGuid
import de.joneug.mdal.mdal.TypeInteger
import de.joneug.mdal.mdal.TypeMedia
import de.joneug.mdal.mdal.TypeMediaSet
import de.joneug.mdal.mdal.TypeOption
import de.joneug.mdal.mdal.TypeRecordId
import de.joneug.mdal.mdal.TypeTableFilter
import de.joneug.mdal.mdal.TypeText
import de.joneug.mdal.mdal.TypeTime

import static extension de.joneug.mdal.extensions.CustomFieldExtensions.*
import static extension de.joneug.mdal.extensions.TypeEnumExtensions.*

class FieldTypeExtensions {
	
	/*
	 * Polymorphic dispatch for "doGenerate" on FieldType subtypes 
	 */

	static def dispatch CharSequence doGenerate(TypeBoolean fieldType) '''Boolean'''

	static def dispatch CharSequence doGenerate(TypeInteger fieldType) '''Integer'''

	static def dispatch CharSequence doGenerate(TypeBigInteger fieldType) '''BigInteger'''

	static def dispatch CharSequence doGenerate(TypeDecimal fieldType) '''Decimal'''

	static def dispatch CharSequence doGenerate(TypeCode fieldType) '''Code[«fieldType.length»]'''

	static def dispatch CharSequence doGenerate(TypeText fieldType) '''Text[«fieldType.length»]'''

	static def dispatch CharSequence doGenerate(TypeDate fieldType) '''Date'''

	static def dispatch CharSequence doGenerate(TypeTime fieldType) '''Time'''

	static def dispatch CharSequence doGenerate(TypeDateTime fieldType) '''DateTime'''

	static def dispatch CharSequence doGenerate(TypeGuid fieldType) '''Guid'''

	static def dispatch CharSequence doGenerate(TypeBlob fieldType) '''Blob'''

	static def dispatch CharSequence doGenerate(TypeEnum fieldType) {
		fieldType.doGenerate
		return '''Enum "«fieldType.customField.getEnumName()»"'''
	}

	static def dispatch CharSequence doGenerate(TypeOption fieldType) '''Option'''

	static def dispatch CharSequence doGenerate(TypeMedia fieldType) '''Media'''

	static def dispatch CharSequence doGenerate(TypeMediaSet fieldType) '''MediaSet'''

	static def dispatch CharSequence doGenerate(TypeDateFormula fieldType) '''DateFormula'''

	static def dispatch CharSequence doGenerate(TypeDuration fieldType) '''Duration'''

	static def dispatch CharSequence doGenerate(TypeRecordId fieldType) '''RecordId'''

	static def dispatch CharSequence doGenerate(TypeTableFilter fieldType) '''TableFilter'''

}
