package de.joneug.mdal.util

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
	
}