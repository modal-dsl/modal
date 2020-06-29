package de.joneug.mdal.ide.extensions

import org.eclipse.lsp4j.Position
import org.eclipse.lsp4j.Range

class RangeExtensions {
	
	def static getRangeBefore(Range range) {
		val end = range.start
		val start = new Position(end.line, 0)
		
		return new Range(start, end)
	}
	
}
