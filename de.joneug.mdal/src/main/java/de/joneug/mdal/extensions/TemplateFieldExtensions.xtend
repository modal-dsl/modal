package de.joneug.mdal.extensions

import de.joneug.mdal.generator.GeneratorManagement
import de.joneug.mdal.mdal.TemplateDimensions
import de.joneug.mdal.mdal.TemplateField
import de.joneug.mdal.mdal.TemplateGenProdPostingGroup
import org.eclipse.emf.ecore.EObject

class TemplateFieldExtensions {

	static GeneratorManagement management = GeneratorManagement.getInstance()

	static def doGenerate(TemplateField templateField, EObject object) {
		if (templateField instanceof TemplateGenProdPostingGroup) {
			return doGenerateGenProdPostingGroupField(object)
		} else if (templateField.type instanceof TemplateDimensions) {
			return doGenerateGlobalDimensionCodeField(object)
		}
	}
	
	static def doGenerateGenProdPostingGroupField(EObject object) '''
		field(«management.getNewFieldNo(object)»; "Gen. Prod. Posting Group"; Code[20])
		{
			Caption = 'Gen. Prod. Posting Group';
			TableRelation = "Gen. Product Posting Group";
		}
	'''

	static def doGenerateGlobalDimensionCodeField(EObject object) '''
		field(«management.getNewFieldNo(object)»; "Global Dimension 1 Code"; Code[20])
		{
			CaptionClass = '1,1,1';
			Caption = 'Global Dimension 1 Code';
			TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
			
			trigger OnValidate()
			begin
				ValidateShortcutDimCode(1, "Global Dimension 1 Code");
			end;
		}
		field(«management.getNewFieldNo(object)»; "Global Dimension 2 Code"; Code[20])
		{
			CaptionClass = '1,1,2';
			Caption = 'Global Dimension 2 Code';
			TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
			
			trigger OnValidate()
			begin
				ValidateShortcutDimCode(2, "Global Dimension 2 Code");
			end;
		}
	'''

}
