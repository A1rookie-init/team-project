package com.hospital.vo;

import java.util.Date;

public class NursingComment_13VO {

	private int idx;
	private int patientIdx;
	private String name;
	private String recordN;
	private int employeeIdx;
	private String employeeName;
	private Date writedate;


	public NursingComment_13VO() {
		// TODO Auto-generated constructor stub
	}


	public NursingComment_13VO(int idx, int patientIdx, String name, String recordN, int employeeIdx,
			String employeeName, Date writedate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.name = name;
		this.recordN = recordN;
		this.employeeIdx = employeeIdx;
		this.employeeName = employeeName;
		this.writedate = writedate;
	}


	public int getIdx() {
		return idx;
	}


	public void setIdx(int idx) {
		this.idx = idx;
	}


	public int getPatientIdx() {
		return patientIdx;
	}


	public void setPatientIdx(int patientIdx) {
		this.patientIdx = patientIdx;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getRecordN() {
		return recordN;
	}


	public void setRecordN(String recordN) {
		this.recordN = recordN;
	}


	public int getEmployeeIdx() {
		return employeeIdx;
	}


	public void setEmployeeIdx(int employeeIdx) {
		this.employeeIdx = employeeIdx;
	}


	public String getEmployeeName() {
		return employeeName;
	}


	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}


	public Date getWritedate() {
		return writedate;
	}


	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}


	@Override
	public String toString() {
		return "NursingComment_13VO [idx=" + idx + ", patientIdx=" + patientIdx + ", name=" + name + ", recordN="
				+ recordN + ", employeeIdx=" + employeeIdx + ", employeeName=" + employeeName + ", writedate="
				+ writedate + "]";
	}
	
	
}
