package de.joneug.mdal.validation

import org.eclipse.xtext.validation.ComposedChecks

@ComposedChecks(validators = #[
 	AlExtensionValidator
 ])
class MdalValidator extends AbstractMdalValidator {}
