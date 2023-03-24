package com.hospital.vo;

import java.util.Date;

public class WorkMemoP_15VO {

	private int idx;
	private int employeeIdx;
	private String commentP;
	private Date writedate;

	public WorkMemoP_15VO() {
		// TODO Auto-generated constructor stub
	}
	
	public WorkMemoP_15VO(int idx, int employeeIdx, String commentP, Date writedate) {
		super();
		this.idx = idx;
		this.employeeIdx = employeeIdx;
		this.commentP = commentP;
		this.writedate = writedate;
	}

	public int getIdx() {
		return idx;
	}

	public int getEmployeeIdx() {
		return employeeIdx;
	}

	public String getCommentP() {
		return commentP;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public void setEmployeeIdx(int employeeIdx) {
		this.employeeIdx = employeeIdx;
	}

	public void setCommentP(String commentP) {
		this.commentP = commentP;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	@Override
	public String toString() {
		return "WorkMemoP_15VO [idx=" + idx + ", employeeIdx=" + employeeIdx + ", commentP=" + commentP + ", writedate="
				+ writedate + "]";
	}

}
