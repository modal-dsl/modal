package de.joneug.mdal.ide.command

import com.google.gson.JsonPrimitive
import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.generator.MdalGenerator
import de.joneug.mdal.util.MdalUtils
import org.eclipse.lsp4j.ExecuteCommandParams
import org.eclipse.xtext.generator.GeneratorContext
import org.eclipse.xtext.generator.IGenerator2
import org.eclipse.xtext.ide.server.ILanguageServerAccess
import org.eclipse.xtext.ide.server.commands.IExecutableCommandService
import org.eclipse.xtext.util.CancelIndicator

import static de.joneug.mdal.util.MdalUtils.*

import static extension de.joneug.mdal.extensions.ObjectExtensions.*

class MdalCommandService implements IExecutableCommandService {

	public static final String RETURN_PREFIX_SUCCESS = "mdal.command.success"
	public static final String RETURN_PREFIX_ERROR = "mdal.command.error"

	public static final String GENERATE = "mdal.generate"
	public static final String CLEAN = "mdal.clean"
	public static final String LOAD_SYMBOL_REFERENCES = 'mdal.loadSymbolReferences'
	
	public static final String PROXY_SUFFIX = '.proxy'
	
	protected IGenerator2 generator = new MdalGenerator
	protected GeneratorManagement management = GeneratorManagement.getInstance()

	override initialize() {
		#[GENERATE, CLEAN, LOAD_SYMBOL_REFERENCES]
	}

	override execute(ExecuteCommandParams params, ILanguageServerAccess access, CancelIndicator cancelIndicator) {
		logInfo("LSP command has been called: " + params.command + " (" + params.arguments + ")")
		
		switch (params.command) {
			case GENERATE: {
				val javaIoFileSystemAccess = MdalUtils.getJavaIoFileSystemAccess()
				val uri = params.arguments.head as JsonPrimitive
				
				if (uri !== null) {
					return access.doRead(uri.asString) [						
						javaIoFileSystemAccess.setOutputPath(MdalGenerator.OUTPUT_FOLDER)
						forceDeleteDirectory(MdalGenerator.OUTPUT_FOLDER)
						generator.doGenerate(resource, javaIoFileSystemAccess, new GeneratorContext())
						return constructSuccessMessage('''The AL source code has been generated into the «MdalGenerator.OUTPUT_FOLDER» folder.''')
					].get
				} else {
					return constructErrorMessage("No resource URI found in command arguments.")
				}
			}
			case CLEAN: {
				forceDeleteDirectory(MdalGenerator.OUTPUT_FOLDER)
				return constructSuccessMessage('''The «MdalGenerator.OUTPUT_FOLDER» folder has been cleaned successfully.''')
			}
			case LOAD_SYMBOL_REFERENCES: {
				management.readSymbolReferences()
				return constructSuccessMessage('''The symbol references have been loaded successfully.''')
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

}
