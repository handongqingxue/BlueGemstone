package blueGemstone.entity;

import java.io.Serializable;

public class WarnHistoryRecord implements Serializable {

	private String id;
	private String name;
	private Float value;
	private String createTime;
	private Integer state;
	private String memo;
	private Integer rowNumber;
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
	public Integer getRowNumber() {
		return rowNumber;
	}
	public void setRowNumber(Integer rowNumber) {
		this.rowNumber = rowNumber;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		String str="id="+id+",name="+name+",value="+value+",createTime="+createTime+",state="+state+",memo="+memo;
		return str;
	}
}
