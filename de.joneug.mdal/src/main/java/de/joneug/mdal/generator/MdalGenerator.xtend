package de.joneug.mdal.generator

import de.joneug.mdal.mdal.AlExtension
import de.joneug.mdal.mdal.Model
import java.util.UUID
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

import static extension de.joneug.mdal.util.ObjectExtensions.*
import static extension de.joneug.mdal.util.StringExtensions.*

class MdalGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		logInfo('''Generator called with resource "«resource.getURI»"''')
		(resource.contents.head as Model).alExtensions.forEach[doGenerate(fsa)]
	}
	
	def doGenerate(AlExtension alExtension, IFileSystemAccess2 fsa) {
		logInfo('''Generating extension "«alExtension.name»"''')
		
		val basePath = alExtension.name.toSnakeCase
		
		fsa.generateFile(basePath + '/app.json', generateAppJson(alExtension))
	}
	
	def generateAppJson(AlExtension alExtension) {
		alExtension.replaceEmptyField("id", UUID.randomUUID().toString)
		alExtension.replaceEmptyField("publisher", "Default publisher")
		alExtension.replaceEmptyField("version", "1.0.0.0")
		alExtension.replaceEmptyField("runtime", "16.0.0.0")
		alExtension.replaceEmptyField("runtime", "5.0")
		alExtension.replaceEmptyField("contextSensitiveHelpUrl", '''https://«alExtension.name.removeSpaces».com/help/'''.toString)
		
		return generateAppJsonContent(alExtension)
	}
	
	def generateAppJsonContent(AlExtension alExtension) '''
		{
			"id": "«alExtension.id»",
			"name": "«alExtension.name»",
			"publisher": "«alExtension.publisher»",
			"version": "«alExtension.version»",
			"brief": "«alExtension.brief»",
			"description": "«alExtension.description»",
			"privacyStatement": "«alExtension.privacyStatement»",
			"EULA": "«alExtension.eula»",
			"help": "«alExtension.help»",
			"url": "«alExtension.url»",
			"logo": "",
			"dependencies": [
				{
				"id": "63ca2fa4-4f03-4f2b-a480-172fef340d3f",
				"publisher": "Microsoft",
				"name": "System Application",
				"version": "16.0.0.0"
				},
				{
				"id": "437dbf0e-84ff-417a-965d-ed2bb9650972",
				"publisher": "Microsoft",
				"name": "Base Application",
				"version": "16.0.0.0"
				}
			],
			"screenshots": [],
			"platform": "«alExtension.platform»",
			"idRanges": [
				{
				"from": 50100,
				"to": 50149
				}
			],
			"contextSensitiveHelpUrl": "«alExtension.contextSensitiveHelpUrl»",
			"showMyCode": «alExtension.showMyCode»,
			"runtime": "«alExtension.runtime»"
		}
	'''
	
}
