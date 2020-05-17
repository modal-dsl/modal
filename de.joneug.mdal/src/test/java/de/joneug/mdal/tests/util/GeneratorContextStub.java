package de.joneug.mdal.tests.util;

import org.eclipse.xtext.generator.IGeneratorContext;
import org.eclipse.xtext.util.CancelIndicator;

public class GeneratorContextStub implements IGeneratorContext {

	@Override
	public CancelIndicator getCancelIndicator() {
		return CancelIndicator.NullImpl;
	}
	
}
