package com.hospital.vo;

import java.util.Date;

public class WorkMemoA_19VO {

	private int idx;
	private int employeeIdx;
	private String commentA;
	private Date writedate;
	
	public WorkMemoA_19VO() {
		// TODO Auto-generated constructor stub
	}

	public WorkMemoA_19VO(int idx, int employeeIdx, String commentA, Date writedate) {
		super();
		this.idx = idx;
		this.employeeIdx = employeeIdx;
		this.commentA = commentA;
		this.writedate = writedate;
	}

	public int getIdx() {
		return idx;
	}

	public int getEmployeeIdx() {
		return employeeIdx;
	}

	public String getCommentA() {
		return commentA;
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

	public void setCommentA(String commentA) {
		this.commentA = commentA;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	@Override
	public String toString() {
		return "WorkMemoA_19VO [idx=" + idx + ", employeeIdx=" + employeeIdx + ", commentA=" + commentA + ", writedate="
				+ writedate + "]";
	}

}
