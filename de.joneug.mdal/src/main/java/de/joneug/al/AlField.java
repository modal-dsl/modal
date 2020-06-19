package de.joneug.al;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.annotations.SerializedName;

public class AlField {

	@SerializedName("Id")
	protected int id;
	
	@SerializedName("Name")
	protected String name;
	
	protected String type;
	
	protected List<AlProperty> properties;
	
	public AlField() {
		this.properties = new ArrayList<>();
	}
	
	public AlField(JsonObject jsonObject) {
		this();
		
		this.id = jsonObject.get("Id").getAsInt();
		this.name = jsonObject.get("Name").getAsString();
		this.type = jsonObject.get("TypeDefinition").getAsJsonObject().get("Name").getAsString();
		
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<AlProperty> getProperties() {
		return properties;
	}

	public void setProperties(List<AlProperty> properties) {
		this.properties = properties;
	}
	
}
