package blueGemstone.entity;

import java.io.Serializable;

public class VarChange implements Serializable {

	private String id;
	private String name;
	private Float value;
	private Float upLimit;
	private Float downLimit;
	private String createTime;
	private Integer state;
	private Boolean updated1;//�Ƿ������ÿ��ʮ���Ӳ��������
	private Boolean updated2;//�Ƿ������ÿ����Сʱ���������
	private String memo;
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
	public Boolean getUpdated1() {
		return updated1;
	}
	public void setUpdated1(Boolean updated1) {
		this.updated1 = updated1;
	}
	public Boolean getUpdated2() {
		return updated2;
	}
	public void setUpdated2(Boolean updated2) {
		this.updated2 = updated2;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
}
