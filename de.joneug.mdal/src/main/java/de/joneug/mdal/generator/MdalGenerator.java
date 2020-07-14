package de.joneug.mdal.generator;

import java.util.List;

import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.Resource.Diagnostic;
import org.eclipse.xtext.diagnostics.Severity;
import org.eclipse.xtext.generator.AbstractGenerator;
import org.eclipse.xtext.generator.IFileSystemAccess2;
import org.eclipse.xtext.generator.IGeneratorContext;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.util.CancelIndicator;
import org.eclipse.xtext.validation.CheckMode;
import org.eclipse.xtext.validation.IResourceValidator;
import org.eclipse.xtext.validation.Issue;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

import de.joneug.mdal.extensions.ObjectExtensions;
import de.joneug.mdal.extensions.SolutionExtensions;
import de.joneug.mdal.mdal.Model;

public class MdalGenerator extends AbstractGenerator {
	
	protected GeneratorManagement management = GeneratorManagement.getInstance();
	
	public static final String APP_JSON_FILENAME = "app.json";
	public static final String OUTPUT_FOLDER = "src-gen" ;
	public static final String TABLE_PATH = "Table";
	public static final String PAGE_PATH = "Page";
	public static final String CODEUNIT_PATH = "Codeunit";
	public static final String ENUM_PATH = "Enum";
	public static final String ENUM_EXT_PATH = "EnumExt";
	public static final String TABLE_EXT_PATH = "TableExt";
	
	@Override
	public void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {		
		ObjectExtensions.logInfo(this, "Generator called with resource '" + resource.getURI() + "'");
		management.setGeneratorFsa(fsa);
		management.reset();
		management.readAppJson();
		management.readSymbolReferences();
		Model model = (Model)IterableExtensions.head(resource.getContents());
		
		// Check for parsing errors
		List<Diagnostic> parsingErrors = model.eResource().getErrors();
		if(!parsingErrors.isEmpty()) {
			throw new IllegalArgumentException("The model in the provided resource could not be parsed successfully: \n" + parsingErrors);
		}
		
		// Validate
		IResourceValidator validator = ((XtextResource)resource).getResourceServiceProvider().getResourceValidator();
		List<Issue> issues = validator.validate(resource, CheckMode.ALL, CancelIndicator.NullImpl);
		if(issues.stream().anyMatch(it -> it.getSeverity() == Severity.ERROR)) {
			throw new IllegalArgumentException("The model in the provided resource contains errors.");
		}
		for (Issue issue : issues) {
			if(issue.getSeverity() == Severity.ERROR) {
				ObjectExtensions.logError(this, issue);
			} else {
				ObjectExtensions.logWarn(this, issue);
			}
		}
		
		SolutionExtensions.doGenerate(model.getSolution());
		ObjectExtensions.logInfo(this, "Done");
	}
	
}
