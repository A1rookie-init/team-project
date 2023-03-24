package com.hospital.vo;

import java.util.Date;

public class HandoverD_3VO {

	private int idx;
	private int gup;
	private int lev = 0;
	private String commentD;
	private String fromDT;
	private int employeeIdx;
	private String fromName;
	private Date writedate;
	
	public HandoverD_3VO() {
		// TODO Auto-generated constructor stub
	}

	public HandoverD_3VO(int idx, int gup, int lev, String commentD, String fromDT, int employeeIdx, String fromName,
			Date writedate) {
		super();
		this.idx = idx;
		this.gup = gup;
		this.lev = lev;
		this.commentD = commentD;
		this.fromDT = fromDT;
		this.employeeIdx = employeeIdx;
		this.fromName = fromName;
		this.writedate = writedate;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getGup() {
		return gup;
	}

	public void setGup(int gup) {
		this.gup = gup;
	}

	public int getLev() {
		return lev;
	}

	public void setLev(int lev) {
		this.lev = lev;
	}

	public String getCommentD() {
		return commentD;
	}

	public void setCommentD(String commentD) {
		this.commentD = commentD;
	}

	public String getFromDT() {
		return fromDT;
	}

	public void setFromDT(String fromDT) {
		this.fromDT = fromDT;
	}

	public int getEmployeeIdx() {
		return employeeIdx;
	}

	public void setEmployeeIdx(int employeeIdx) {
		this.employeeIdx = employeeIdx;
	}

	public String getFromName() {
		return fromName;
	}

	public void setFromName(String fromName) {
		this.fromName = fromName;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	@Override
	public String toString() {
		return "HandoverD_3VO [idx=" + idx + ", gup=" + gup + ", lev=" + lev + ", commentD=" + commentD + ", fromDT="
				+ fromDT + ", employeeIdx=" + employeeIdx + ", fromName=" + fromName + ", writedate=" + writedate + "]";
	}
	

}
