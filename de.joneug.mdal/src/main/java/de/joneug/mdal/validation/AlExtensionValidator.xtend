package de.joneug.mdal.validation

import de.joneug.mdal.mdal.MdalPackage
import de.joneug.mdal.mdal.AlExtension
import org.eclipse.xtext.validation.Check

class AlExtensionValidator extends AbstractMdalValidator {

	public static final String INVALID_ID = "invalidId";

	@Check
	def checkExtensionId(AlExtension alExtension) {
		if (alExtension.id.isNullOrEmpty) return;
		
		if (!alExtension.id.matches("[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}")) {
			warning('The provided ID is not a valid GUID', MdalPackage.Literals.AL_EXTENSION__ID, INVALID_ID);
		}
	}
	
}