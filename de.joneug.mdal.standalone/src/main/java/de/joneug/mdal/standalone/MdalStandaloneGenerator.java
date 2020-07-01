package de.joneug.mdal.standalone;

import java.io.File;
import java.util.List;
import java.util.concurrent.Callable;

import org.apache.log4j.Logger;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.xtext.diagnostics.Severity;
import org.eclipse.xtext.generator.GeneratorContext;
import org.eclipse.xtext.generator.IFileSystemAccess2;
import org.eclipse.xtext.generator.IGenerator2;
import org.eclipse.xtext.generator.JavaIoFileSystemAccess;
import org.eclipse.xtext.util.CancelIndicator;
import org.eclipse.xtext.validation.CheckMode;
import org.eclipse.xtext.validation.IResourceValidator;
import org.eclipse.xtext.validation.Issue;

import com.google.inject.Inject;
import com.google.inject.Injector;

import de.joneug.mdal.MdalStandaloneSetup;
import de.joneug.mdal.generator.MdalGenerator;
import de.joneug.mdal.util.MdalUtils;
import picocli.CommandLine;
import picocli.CommandLine.Command;
import picocli.CommandLine.Parameters;

@Command(name = "mdal-standalone", mixinStandardHelpOptions = true, version = "mdal-standalone 0.1.0", description = "Executes the mdAL code generator on a mdAL model file.")
public class MdalStandaloneGenerator implements Callable<Integer> {
	
	protected final Logger LOGGER = Logger.getLogger(MdalStandaloneGenerator.class);
	
	@Inject
	protected IGenerator2 generator;
	
	@Inject
	protected IResourceValidator validator;
	
	@Inject
	protected ResourceSet resourceSet;
	
	protected IFileSystemAccess2 fsa;
	
	@Parameters(index = "0", description = "The mdAL model file.")
    private File modelFile;
	
	public MdalStandaloneGenerator() {
		// Prepare dependency injection
		Injector injector = new MdalStandaloneSetup().createInjectorAndDoEMFRegistration();
		injector.injectMembers(this);
		
		// Prepare file system access
		JavaIoFileSystemAccess javaIoFileSystemAccess = MdalUtils.getJavaIoFileSystemAccess();
		javaIoFileSystemAccess.setOutputPath(MdalGenerator.OUTPUT_FOLDER);
		this.fsa = javaIoFileSystemAccess;
	}

	@Override
	public Integer call() throws Exception {
		// Load model
		Resource resource = resourceSet.getResource(URI.createFileURI(modelFile.getAbsolutePath()), true);
		
		// Validate model
		List<Issue> issues = validator.validate(resource, CheckMode.ALL, CancelIndicator.NullImpl);
		if (!issues.isEmpty()) {
			LOGGER.error("There are issues in the given model file");
			for (Issue issue : issues) {
				if(issue.getSeverity() == Severity.ERROR) {
					LOGGER.error(issue);
				} else {
					LOGGER.warn(issue);
				}
			}
			return 1;
		}
		
		// Clean
		MdalUtils.forceDeleteDirectory(MdalGenerator.OUTPUT_FOLDER);
		
		// Generate
		generator.doGenerate(resource, this.fsa, new GeneratorContext());
		
		return 0;
	}
	
	public static void main(String... args) {
        int exitCode = new CommandLine(new MdalStandaloneGenerator()).execute(args);
        System.exit(exitCode);
    }
	
}
