package de.joneug.al;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.annotations.SerializedName;

public class AlTable {
	
	@SerializedName("Id")
	protected int id;
	
	@SerializedName("Name")
	protected String name;

	@SerializedName("Fields")
	protected List<AlField> fields;
	
	@SerializedName("Keys")
	protected List<AlKey> keys;
	
	@SerializedName("Properties")
	protected List<AlProperty> properties;
	
	public AlTable() {
		this.fields = new ArrayList<>();
		this.keys = new ArrayList<>();
		this.properties = new ArrayList<>();
	}
	
	public AlTable(JsonObject jsonObject) {
		this();
		
		this.id = jsonObject.get("Id").getAsInt();
		this.name = jsonObject.get("Name").getAsString();
		
		if (jsonObject.has("Fields")) {
			for (JsonElement jsonElement : jsonObject.get("Fields").getAsJsonArray()) {
				this.fields.add(new AlField(jsonElement.getAsJsonObject()));
			}
		}
		
		if (jsonObject.has("Keys")) {
			for (JsonElement jsonElement : jsonObject.get("Keys").getAsJsonArray()) {
				this.keys.add(new AlKey(jsonElement.getAsJsonObject()));
			}
		}
		
		if (jsonObject.has("Properties")) {
			for (JsonElement jsonElement : jsonObject.get("Properties").getAsJsonArray()) {
				this.properties.add(new AlProperty(jsonElement.getAsJsonObject()));
			}
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<AlField> getFields() {
		return fields;
	}

	public void setFields(List<AlField> fields) {
		this.fields = fields;
	}

	public List<AlKey> getKeys() {
		return keys;
	}

	public void setKeys(List<AlKey> keys) {
		this.keys = keys;
	}

	public List<AlProperty> getProperties() {
		return properties;
	}

	public void setProperties(List<AlProperty> properties) {
		this.properties = properties;
	}
	
}
