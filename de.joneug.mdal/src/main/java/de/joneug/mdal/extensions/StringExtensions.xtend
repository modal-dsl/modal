package de.joneug.mdal.extensions

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
	
	static def boolean isOnlyAlphabetic(String input) {
		return input.chars().allMatch[Character::isLetter(it)]
	}
	
	def static quote(String input) {
		return '"' + input + '"'
	}
	
	def static unquote(String input) {
		return input.replace('"', "")
	}
	
	def static saveQuote(String input) {
		if(input.isOnlyAlphabetic) {
			return input
		} else {
			return input.quote
		}
	}
	
}