package de.joneug.mdal.generator

import de.joneug.mdal.mdal.Model
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

import static extension de.joneug.mdal.extensions.SolutionExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*

class MdalGenerator extends AbstractGenerator {

	public static final String APP_JSON_FILENAME = "app.json";
	public static final String OUTPUT_FOLDER = "src-gen" 
	public static final String TABLE_PATH = 'Table'
	public static final String PAGE_PATH = 'Page'
	public static final String CODEUNIT_PATH = 'Codeunit'
	public static final String ENUM_PATH = 'Enum'
	public static final String ENUM_EXT_PATH = 'EnumExt'
	public static final String TABLE_EXT_PATH = 'TableExt'

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		logInfo('''Generator called with resource "«resource.getURI»"''')
		(resource.contents.head as Model).solution.doGenerate(fsa)
	}

}
