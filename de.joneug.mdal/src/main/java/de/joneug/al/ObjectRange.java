package de.joneug.al;

import com.google.gson.annotations.SerializedName;

public class ObjectRange implements Comparable<ObjectRange> {

	@SerializedName("from")
	protected int minValue;
	@SerializedName("to")
	protected int maxValue;

	public ObjectRange() {
	}

	public ObjectRange(int minValue, int maxValue) {
		if (maxValue < minValue) {
			throw new IllegalArgumentException("minValue must not be greater than maxValue");
		}
		this.minValue = minValue;
		this.maxValue = maxValue;
	}

	public int getMinValue() {
		return minValue;
	}

	public void setMinValue(int minValue) {
		if (minValue > this.maxValue) {
			throw new IllegalArgumentException("minValue must not be greater than maxValue");
		}
		
		this.minValue = minValue;
	}

	public int getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(int maxValue) {
		if (maxValue < this.minValue) {
			throw new IllegalArgumentException("maxValue must not be less than minValue");
		}
		
		this.maxValue = maxValue;
	}

	public boolean isInRange(int value) {
		return (minValue <= value) && (value <= maxValue);
	}

	public boolean isSpaceLeft(int value) {
		return isInRange(value) && (value < maxValue);
	}

	@Override
	public int compareTo(ObjectRange other) {
		return Integer.valueOf(this.minValue).compareTo(other.minValue);
	}

	@Override
	public String toString() {
		return "[" + this.minValue + "..." + this.maxValue + "]";
	}

}
