package de.joneug.mdal.extensions

import com.google.common.base.Strings
import java.text.Normalizer

/**
 * This is an extension library for all {@link String objects}.
 */
class StringExtensions {
	
	static def removeSpaces(String input) {
		return input.replace(" ", "")
	}
	
	static def toSnakeCase(String input) {
		return input.toLowerCase.replace(' ', '_')
	}
	
	static def toOnlyAlphabetic(String input) {
		return Normalizer.normalize(input, Normalizer.Form.NFD).replaceAll("[^a-zA-Z ]", "")
	}
	
	def static clean(String input) {
		return input.toOnlyAlphabetic.removeSpaces
	}
	
	static def boolean isLetterOrDigit(String input) {
		return input.chars().allMatch[Character::isLetterOrDigit(it)]
	}
	
	def static quote(String input) {
		return '"' + input + '"'
	}
	
	def static unquote(String input) {
		return input.replace('"', "")
	}
	
	def static saveQuote(String input) {
		if(input.isLetterOrDigit) {
			return input
		} else {
			return input.quote
		}
	}
	
	def static padEnd(String input, int length) {
		return Strings.padEnd(input, length, ' ')
	}
	
	def static toTableFileName(String tableName) {
		return tableName.clean + '.Table.al'
	}

	def static toPageFileName(String pageName) {
		return pageName.clean + '.Page.al'
	}
	
	def static toCodeunitFileName(String codeunitName) {
		return codeunitName.clean + '.Codeunit.al'
	}
	
	def static toEnumFileName(String enumName) {
		return enumName.clean + '.Enum.al'
	}
	
	def static toEnumExtFileName(String enumExtName) {
		return enumExtName.clean + '.EnumExt.al'
	}
	
	def static toTableExtFileName(String tableExtName) {
		return tableExtName.clean + '.TableExt.al'
	}
	
	def static toPageExtFileName(String tableExtName) {
		return tableExtName.clean + '.PageExt.al'
	}
	
}