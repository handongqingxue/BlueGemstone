package blueGemstone.entity;

import java.io.Serializable;

public class VarWarnLimit implements Serializable {

	private String name;
	private Float upLimit=null;
	private Float downLimit=null;
	private Float max=null;
	private Float min=null;
	private String kName;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Float getUpLimit() {
		return upLimit;
	}
	public void setUpLimit(Float upLimit) {
		this.upLimit = upLimit;
	}
	public Float getDownLimit() {
		return downLimit;
	}
	public void setDownLimit(Float downLimit) {
		this.downLimit = downLimit;
	}
	public Float getMax() {
		return max;
	}
	public void setMax(Float max) {
		this.max = max;
	}
	public Float getMin() {
		return min;
	}
	public void setMin(Float min) {
		this.min = min;
	}
	public String getkName() {
		return kName;
	}
	public void setkName(String kName) {
		this.kName = kName;
	}
}
