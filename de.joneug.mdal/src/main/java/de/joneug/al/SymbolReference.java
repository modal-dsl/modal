package de.joneug.al;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.annotations.SerializedName;
import com.google.gson.stream.JsonReader;

import de.joneug.mdal.util.MdalUtils;

public class SymbolReference {

	public static String SYMBOL_REFERENCE_FILENAME = "SymbolReference.json";

	@SerializedName("AppId")
	protected String appId;

	@SerializedName("Name")
	protected String name;

	@SerializedName("Publisher")
	protected String publisher;

	@SerializedName("Version")
	protected String version;

	@SerializedName("Tables")
	protected List<AlTable> tables;
	
	protected int hashCode;
	
	public SymbolReference() {
		this.tables = new ArrayList<>();
	}
	
	public SymbolReference(JsonObject jsonObject) {
		this();
		
		this.appId = jsonObject.get("AppId").getAsString();
		this.name = jsonObject.get("Name").getAsString();
		this.publisher = jsonObject.get("Publisher").getAsString();
		this.version = jsonObject.get("Version").getAsString();
		
		for (JsonElement jsonElement : jsonObject.get("Tables").getAsJsonArray()) {
			this.tables.add(new AlTable(jsonElement.getAsJsonObject()));
		}
	}

	public static SymbolReference parseFile(File appFile) throws IOException {		
		try(ZipFile zipFile = new ZipFile(appFile)) {
			ZipEntry jsonFile = zipFile.getEntry(SYMBOL_REFERENCE_FILENAME);
			InputStream inputStream = zipFile.getInputStream(jsonFile);
			String jsonString = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8)).lines()
					.collect(Collectors.joining("\n"));
			
			JsonReader reader = new JsonReader(new StringReader(jsonString));
			reader.setLenient(true);
			SymbolReference symbolReference = new SymbolReference(JsonParser.parseReader(reader).getAsJsonObject());
			symbolReference.setHashCode(MdalUtils.calcFileHashCode(appFile));
			return symbolReference;
		}
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public List<AlTable> getTables() {
		return tables;
	}

	public void setTables(List<AlTable> tables) {
		this.tables = tables;
	}

	public void setHashCode(int hashCode) {
		this.hashCode = hashCode;
	}
	
	@Override
	public int hashCode() {
		return this.hashCode;
	}

}
