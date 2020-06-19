package de.joneug.al

import java.io.File
import org.junit.jupiter.api.Test

import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertNotNull

class SymbolReferenceTest {

	@Test
	def void testParseFile() {
		val symbolReference = SymbolReference.parseFile(new File("src/test/resources/example.app"))

		assertNotNull(symbolReference)
		assertEquals("81937f44-e6e8-4b51-a54e-5d97a5641cb7", symbolReference.getAppId())
		assertEquals("Example Extensions", symbolReference.getName())
		assertEquals("joneug", symbolReference.getPublisher())
		assertEquals("0.0.1.0", symbolReference.getVersion())
		assertEquals(1, symbolReference.getTables().size)
		val table = symbolReference.getTables().get(0)
		assertEquals(1234567890, table.getId())
		assertEquals("Module Setup", table.getName())
		assertEquals(4, table.getFields().size)
		assertEquals(1, table.getProperties().size)
		assertEquals(1, table.getKeys().size)
		val key = table.getKeys().get(0)
		assertEquals("Key1", key.getName())
		assertEquals(#["Primary Key"], key.getFieldNames())
		val field = table.getFields().get(0)
		assertEquals(1, field.getProperties().size)
		assertEquals(1, field.getId())
		assertEquals("Primary Key", field.getName())
		assertEquals("Code[10]", field.getType())
	}

}
