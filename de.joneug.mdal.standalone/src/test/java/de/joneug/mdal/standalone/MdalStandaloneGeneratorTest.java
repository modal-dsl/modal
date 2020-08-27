package de.joneug.mdal.standalone;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

import java.io.FileWriter;
import java.io.IOException;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import de.joneug.mdal.generator.MdalGenerator;
import de.joneug.mdal.util.ExampleContentGenerator;
import de.joneug.mdal.util.MdalUtils;
import picocli.CommandLine;

public class MdalStandaloneGeneratorTest {

	protected CommandLine cmd;

	@BeforeEach
	public void setup() throws IOException {
		cmd = new CommandLine(new MdalStandaloneGenerator());

		MdalUtils.forceDeleteFile("model.mdal");
		MdalUtils.forceDeleteFile("app.json");

		FileWriter writer = new FileWriter("model.mdal");
		writer.write(ExampleContentGenerator.generateCorrectModel().toString());
		writer.close();

		writer = new FileWriter("app.json");
		writer.write(ExampleContentGenerator.generateAppJson().toString());
		writer.close();
	}

	@AfterEach
	public void tearDown() {
		MdalUtils.forceDeleteFile("model.mdal");
		MdalUtils.forceDeleteFile("app.json");
		MdalUtils.forceDeleteDirectory(MdalGenerator.OUTPUT_FOLDER);
	}

	@Test
	public void testMissingParameters() {
		assertNotEquals(0, cmd.execute());
	}

	@Test
	public void testModelFileParameter() {
		assertEquals(0, cmd.execute("model.mdal"));
	}

}
