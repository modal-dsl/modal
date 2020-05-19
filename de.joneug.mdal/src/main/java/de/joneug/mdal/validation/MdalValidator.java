package de.joneug.mdal.validation;

import org.eclipse.xtext.validation.ComposedChecks;

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */

@ComposedChecks(validators = {AlExtensionValidator.class})
public class MdalValidator extends AbstractMdalValidator { }
