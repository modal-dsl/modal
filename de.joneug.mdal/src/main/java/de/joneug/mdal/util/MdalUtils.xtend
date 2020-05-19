package de.joneug.mdal.util

import java.io.File
import java.nio.file.Files
import java.nio.file.Paths
import java.util.Comparator

class MdalUtils {
	
	def static forceDeleteDirectory(String path) {
		if (!(new File(path)).exists) {
			return
		}
		
		deleteDirectory(path)
	}
	
	def static deleteDirectory(String path) {
		Files.walk(Paths.get(path)).sorted(Comparator.reverseOrder()).map[it.toFile].forEach[it.delete]
	}
	
}
