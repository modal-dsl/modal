package de.joneug.mdal.ide.command

import com.google.gson.JsonPrimitive
import com.google.inject.Guice
import de.joneug.mdal.generator.MdalGenerator
import org.eclipse.lsp4j.ExecuteCommandParams
import org.eclipse.xtext.generator.GeneratorContext
import org.eclipse.xtext.generator.IGenerator2
import org.eclipse.xtext.generator.JavaIoFileSystemAccess
import org.eclipse.xtext.ide.server.ILanguageServerAccess
import org.eclipse.xtext.ide.server.commands.IExecutableCommandService
import org.eclipse.xtext.parser.IEncodingProvider
import org.eclipse.xtext.service.AbstractGenericModule
import org.eclipse.xtext.util.CancelIndicator

import static de.joneug.mdal.ide.command.CommandCodes.*
import static de.joneug.mdal.util.MdalUtils.*

import static extension de.joneug.mdal.util.ObjectExtensions.*

class MdalCommandService implements IExecutableCommandService {

	IGenerator2 generator = new MdalGenerator()
	
	static final String OUTPUT_FOLDER = "src-gen" 

	override initialize() {
		#[GENERATE, CLEAN]
	}

	override execute(ExecuteCommandParams params, ILanguageServerAccess access, CancelIndicator cancelIndicator) {
		logInfo("LSP command has been called: " + params.command + " (" + params.arguments + ")");
		
		switch (params.command) {
			case GENERATE: {
				val javaIoFileSystemAccess = getFileSystemAccess()
				val uri = params.arguments.head as JsonPrimitive
				
				if (uri !== null) {
					return access.doRead(uri.asString) [						
						javaIoFileSystemAccess.setOutputPath(OUTPUT_FOLDER)
						generator.doGenerate(resource, javaIoFileSystemAccess, new GeneratorContext())
						
						return constructSuccessMessage('''The AL source code has been generated into the «OUTPUT_FOLDER» folder.''')
					].get
				} else {
					return constructErrorMessage("No resource URI found in command arguments.")
				}
			}
			case CLEAN: {
				forceDeleteDirectory(OUTPUT_FOLDER)
				return constructSuccessMessage('''The «OUTPUT_FOLDER» folder has been cleaned successfully.''')
			}
			default: {
				return constructErrorMessage('''Command "«params.command»" is unknown.''')				
			}
		}
	}
	
	def String constructSuccessMessage(String message) {
		val successMessage = RETURN_PREFIX_SUCCESS + message
		
		logInfo(successMessage)
		return successMessage
	}
	
	def String constructErrorMessage(String message) {
		val errorMessage = RETURN_PREFIX_ERROR + message
		
		logError(errorMessage)
		return errorMessage
	}
	
	def JavaIoFileSystemAccess getFileSystemAccess() {
		val fsa = new JavaIoFileSystemAccess()
		
		Guice.createInjector(new AbstractGenericModule() {
			@SuppressWarnings("unused")
			def Class<? extends IEncodingProvider> bindIEncodingProvider() {
				return IEncodingProvider.Runtime
			}
		}).injectMembers(fsa)
		
		return fsa
	}

}
