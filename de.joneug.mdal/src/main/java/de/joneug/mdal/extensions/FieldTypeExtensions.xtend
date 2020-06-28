package de.joneug.mdal.extensions

import de.joneug.mdal.mdal.CustomField
import de.joneug.mdal.mdal.FieldType
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
import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.TypeEnumExtensions.*

class FieldTypeExtensions {

	static def String doGenerate(FieldType fieldType) {
		if (fieldType instanceof TypeBoolean) {
			return 'Boolean'
		} else if (fieldType instanceof TypeInteger) {
			return 'Integer'
		} else if (fieldType instanceof TypeBigInteger) {
			return 'BigInteger'
		} else if (fieldType instanceof TypeDecimal) {
			return 'Decimal'
		} else if (fieldType instanceof TypeCode) {
			return '''Code[«fieldType.length»]'''
		} else if (fieldType instanceof TypeText) {
			return '''Text[«fieldType.length»]'''
		} else if (fieldType instanceof TypeDate) {
			return 'Date'
		} else if (fieldType instanceof TypeTime) {
			return 'Time'
		} else if (fieldType instanceof TypeDateTime) {
			return 'DateTime'
		} else if (fieldType instanceof TypeGuid) {
			return 'Guid'
		} else if (fieldType instanceof TypeBlob) {
			return 'Blob'
		} else if (fieldType instanceof TypeEnum) {
			fieldType.doGenerate
			return '''Enum "«fieldType.getContainerOfType(CustomField).getEnumName()»"'''
		} else if (fieldType instanceof TypeOption) {
			return 'Option'
		} else if (fieldType instanceof TypeMedia) {
			return 'Media'
		} else if (fieldType instanceof TypeMediaSet) {
			return 'MediaSet'
		} else if (fieldType instanceof TypeDateFormula) {
			return 'DateFormula'
		} else if (fieldType instanceof TypeDuration) {
			return 'Duration'
		} else if (fieldType instanceof TypeRecordId) {
			return 'RecordId'
		} else if (fieldType instanceof TypeTableFilter) {
			return 'TableFilter'
		}
	}

}
