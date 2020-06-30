package de.joneug.mdal.extensions

import java.text.Normalizer
import com.google.common.base.Strings

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
	
}