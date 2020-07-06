package de.joneug.mdal.validation;

import org.eclipse.xtext.validation.ComposedChecks;

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
@ComposedChecks(validators = {IncludeFieldValidator.class, CustomFieldValidator.class, EntityValidator.class, PageFieldValidator.class})
public class MdalValidator extends AbstractMdalValidator {
	
	public static final String FIELD_NAME_EXISTS = "f-name-exists";
	public static final String ENTITY_NAME_EXISTS = "e-name-exists";
	public static final String ENTITY_NAME_DESCRIPTION = "e-name-description";
	public static final String INCLUDE_FIELD_UNKNOWN_ENTITY = "if-unknown-entity";
	public static final String INCLUDE_FIELD_UNKNOWN_FIELD = "if-unknown-field";
	public static final String CUSTOM_FIELD_UNKNOWN_TABLE = "cf-unknown-table";
	public static final String PAGE_FIELD_UNKNOWN_FIELD= "pf-unknown-field";
	
}
