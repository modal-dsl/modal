package de.joneug.mdal.generator

import com.google.inject.Inject
import de.joneug.al.ObjectRange
import de.joneug.mdal.mdal.Model
import de.joneug.mdal.tests.MdalInjectorProvider
import de.joneug.mdal.util.ExampleContentGenerator
import java.util.TreeSet
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.InMemoryFileSystemAccess
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertFalse

import static extension de.joneug.mdal.extensions.EObjectExtensions.*
import static extension de.joneug.mdal.extensions.ObjectExtensions.*

@ExtendWith(InjectionExtension)
@InjectWith(MdalInjectorProvider)
class GeneratorManagementTest {

	@Inject
	ParseHelper<Model> parseHelper
	
	Model model
	
	IFileSystemAccess2 fsa
	
	GeneratorManagement management

	@BeforeEach
    def void setUp() {
    	this.model = parseHelper.parse(ExampleContentGenerator.generateCorrectModel)
    	this.fsa = new InMemoryFileSystemAccess()
    	this.management = GeneratorManagement.getInstance()
    	this.management.initializeFileSystemAccess(fsa)
		logDebug(model.dump)
    }
    
    @Test
    def void testReadAppJson() {
    	this.fsa.generateFile("app.json", ExampleContentGenerator.generateAppJson())
    	this.management.readAppJson()
    	
    	assertFalse(this.management.objectRanges.isEmpty)
    	
    	val TreeSet<ObjectRange> expected = new TreeSet<ObjectRange>()
    	expected.add(new ObjectRange(123456700, 123456799))
    	expected.add(new ObjectRange(123456800, 123456899))
    	assertEquals(expected, this.management.objectRanges)
    }

	@Test
	def void testReset() {
		val master = model.solution.master
		
		this.management.reset()
		assertEquals(this.management.getLastFieldNo(master), -1)
		this.management.getNewFieldNo(master)
		assertEquals(this.management.getLastFieldNo(master), 1)
		this.management.reset()
		assertEquals(this.management.getLastFieldNo(master), -1)
	}
	
	@Test
	def void testGetNewFieldNo() {
		val master = model.solution.master
		this.management.reset()

		assertEquals(this.management.getNewFieldNo(master), 1)
		assertEquals(this.management.getNewFieldNo(master), 2)
	}
	
	@Test
	def void testGetLastFieldNo() {
		val master = model.solution.master
		this.management.reset()
		
		assertEquals(this.management.getLastFieldNo(master), -1)
		this.management.getNewFieldNo(master)
		assertEquals(this.management.getLastFieldNo(master), 1)
		this.management.getNewFieldNo(master)
		assertEquals(this.management.getLastFieldNo(master), 2)
	}

}
