package blueGemstone.entity;

import java.io.Serializable;

public class VarAvgChange implements Serializable {


	private String id;
	private String name;
	private Float value;
	private Float upLimit;
	private Float downLimit;
	private String createTime;
	private Integer state;
	private String memo;
	private Integer timeFlag;//����˶�ò������ʷ���ݣ�1.ʮ���ӡ�2.��Сʱ��
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
