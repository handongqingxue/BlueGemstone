package blueGemstone.entity;

import java.io.Serializable;

public class VarAvgChange implements Serializable {


	private String id;
	private String name;
	private Float value;
	private String createTime;
	private Integer state;
	private String memo;
	private Integer timeFlag;//间隔了多久插入的历史数据（1.十分钟、2.两小时）
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Float getValue() {
		return value;
	}
	public void setValue(Float value) {
		this.value = value;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Integer getTimeFlag() {
		return timeFlag;
	}
	public void setTimeFlag(Integer timeFlag) {
		this.timeFlag = timeFlag;
	}
}
