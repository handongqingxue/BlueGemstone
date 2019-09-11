package blueGemstone.entity;

import java.io.Serializable;

public class VarWarnLimit implements Serializable {

	private String name;
	private float upLimit;
	private float downLimit;
	private String kName;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public float getUpLimit() {
		return upLimit;
	}
	public void setUpLimit(float upLimit) {
		this.upLimit = upLimit;
	}
	public float getDownLimit() {
		return downLimit;
	}
	public void setDownLimit(float downLimit) {
		this.downLimit = downLimit;
	}
	public String getkName() {
		return kName;
	}
	public void setkName(String kName) {
		this.kName = kName;
	}
}
