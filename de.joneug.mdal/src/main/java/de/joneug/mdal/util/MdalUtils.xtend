package de.joneug.mdal.util

import com.google.common.hash.Hashing
import com.google.inject.Guice
import java.io.File
import java.nio.file.Files
import java.nio.file.Paths
import java.util.Comparator
import java.util.HashMap
import java.util.List
import org.eclipse.xtext.generator.JavaIoFileSystemAccess
import org.eclipse.xtext.parser.IEncodingProvider
import org.eclipse.xtext.service.AbstractGenericModule

class MdalUtils {
	
	static def constructMap(List<String> keys, List<String> values) {
		if(keys.length != values.length) {
			throw new IllegalArgumentException("List lengths must be equal")
		}
		
		var map = new HashMap<String, String>()
		for (i : 0 ..< keys.length) {
			map.put(keys.get(i), values.get(i))
		}
		return map
	}
	
	def static JavaIoFileSystemAccess getJavaIoFileSystemAccess() {
		val fsa = new JavaIoFileSystemAccess()
		
		Guice.createInjector(new AbstractGenericModule() {
			@SuppressWarnings("unused")
			def Class<? extends IEncodingProvider> bindIEncodingProvider() {
				return IEncodingProvider.Runtime
			}
		}).injectMembers(fsa)
		
		return fsa
	}
	
	def static forceDeleteDirectory(String path) {
		if (!(new File(path)).exists) {
			return
		}
		
		deleteDirectory(path)
	}
	
	def static deleteDirectory(String path) {
		Files.walk(Paths.get(path)).sorted(Comparator.reverseOrder()).map[it.toFile].forEach[it.delete]
	}
	
	def static forceDeleteFile(String path) {
		if ((new File(path)).delete) {}
	}
	
	def static calcFileHashCode(File file) {
		return com.google.common.io.Files.asByteSource(file).hash(Hashing.sha256()).asInt
	}
	
}
