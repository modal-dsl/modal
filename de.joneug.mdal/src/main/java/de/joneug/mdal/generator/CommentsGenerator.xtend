package de.joneug.mdal.generator

import de.joneug.mdal.mdal.Solution

import static extension de.joneug.mdal.extensions.EntityExtensions.*
import static extension de.joneug.mdal.extensions.SolutionExtensions.*

class CommentsGenerator {
	
	static def void doGenerateSetup(Solution solution) {
		// EnumExt
		solution.saveEnumExt(solution.getInferredPrefix + 'CommentLineTableNameExt', solution.doGenerateCommentLineTableNameEnumExt)

	}
	
	static def doGenerateCommentLineTableNameEnumExt(Solution solution) '''
		enumextension 123456700 "«solution.getInferredPrefix» Comment Line Table Name Ext" extends "Comment Line Table Name"
		{
			value(50000; "«solution.master.cleanedName»") { }
		}
	'''
	
	static def doGenerateCommentDocumentTypeEnum(Solution solution) '''
		enum 123456700 "SEM Seminar Comment Document Type"
		{
			Extensible = true;
			
			value(0; "Seminar Registration") { Caption = 'Seminar Registration'; }
			value(1; "Posted Seminar Registration") { Caption = 'Posted Seminar Registration'; }
		}
	'''
	
}