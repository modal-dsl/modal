package de.joneug.al;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.annotations.SerializedName;

public class AlKey {
	
	@SerializedName("Name")
	protected String name;
	
	@SerializedName("FieldNames")
	protected List<String> fieldNames;
	
	
	public AlKey() {
		this.fieldNames = new ArrayList<>();
	}
	
	public AlKey(JsonObject jsonObject) {
		this();
		
		this.name = jsonObject.get("Name").getAsString();
		
		if (jsonObject.has("FieldNames")) {
			for (JsonElement jsonElement : jsonObject.get("FieldNames").getAsJsonArray()) {
				this.fieldNames.add(jsonElement.getAsString());
			}
		}
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<String> getFieldNames() {
		return fieldNames;
	}

	public void setFieldNames(List<String> fieldNames) {
		this.fieldNames = fieldNames;
	}
	
}
