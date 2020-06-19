package de.joneug.mdal.extensions

import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.InMemoryFileSystemAccess

/**
 * This is an extension library for all {@link IFileSystemAccess objects}.
 */
class InMemoryFileSystemAccessExtensions {
	
	static def hasFileInDefaultOutput(InMemoryFileSystemAccess fsa, String filePath) {
		fsa.allFiles.containsKey(IFileSystemAccess::DEFAULT_OUTPUT + filePath)
	}
	
	static def getFileInDefaultOutput(InMemoryFileSystemAccess fsa, String filePath) {
		fsa.allFiles.get(IFileSystemAccess::DEFAULT_OUTPUT + filePath)
	}
	
}