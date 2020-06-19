package de.joneug.al;

import com.google.gson.JsonObject;
import com.google.gson.annotations.SerializedName;

public class AlProperty {

	@SerializedName("Name")
	protected String name;

	@SerializedName("Value")
	protected String value;

	public AlProperty() {
	}

	public AlProperty(JsonObject jsonObject) {
		this();

		this.name = jsonObject.get("Name").getAsString();
		this.value = jsonObject.get("Value").getAsString();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
