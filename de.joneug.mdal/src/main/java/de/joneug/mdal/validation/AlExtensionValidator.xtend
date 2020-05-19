package de.joneug.mdal.validation

import de.joneug.mdal.mdal.AlExtension
import de.joneug.mdal.mdal.MdalPackage
import org.eclipse.xtext.validation.Check

import static de.joneug.mdal.validation.IssueCodes.*

class AlExtensionValidator extends AbstractMdalValidator {

	@Check
	def checkExtensionId(AlExtension alExtension) {
		if (alExtension.id.isNullOrEmpty) return;
		
		if (!alExtension.id.matches("[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}")) {
			warning('The provided ID is not a valid GUID.', MdalPackage.Literals.AL_EXTENSION__ID, INVALID_ID);
		}
	}
	
}
