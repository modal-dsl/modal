package de.joneug.mdal.standalone;

import java.io.File;
import java.util.concurrent.Callable;

import org.apache.log4j.Logger;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.xtext.generator.GeneratorContext;
import org.eclipse.xtext.generator.IFileSystemAccess2;
import org.eclipse.xtext.generator.IGenerator2;
import org.eclipse.xtext.generator.JavaIoFileSystemAccess;

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
	
	protected IGenerator2 generator = new MdalGenerator();
	
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
		LOGGER.info("Loading model file");
		Resource resource = resourceSet.getResource(URI.createFileURI(modelFile.getAbsolutePath()), true);
		
		// Clean
		LOGGER.info("Cleaning output folder");
		MdalUtils.forceDeleteDirectory(MdalGenerator.OUTPUT_FOLDER);
		
		// Generate
		LOGGER.info("Starting generator");
		generator.doGenerate(resource, this.fsa, new GeneratorContext());
		
		return 0;
	}
	
	public static void main(String... args) {
        int exitCode = new CommandLine(new MdalStandaloneGenerator()).execute(args);
        System.exit(exitCode);
    }
	
}
