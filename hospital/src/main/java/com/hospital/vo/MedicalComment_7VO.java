package com.hospital.vo;

import java.util.Date;

public class MedicalComment_7VO {

	private int idx;
	private int patientIdx;
	private String name;
	private String recordD;
	private String dischargeC = "N";
	private int employeeIdx;
	private String employeeName;
	private Date writeDate;


	public MedicalComment_7VO() {
		// TODO Auto-generated constructor stub
	}


	public MedicalComment_7VO(int idx, int patientIdx, String name, String recordD, String dischargeC, int employeeIdx,
			String employeeName, Date writeDate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.name = name;
		this.recordD = recordD;
		this.dischargeC = dischargeC;
		this.employeeIdx = employeeIdx;
		this.employeeName = employeeName;
		this.writeDate = writeDate;
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


	public String getRecordD() {
		return recordD;
	}


	public void setRecordD(String recordD) {
		this.recordD = recordD;
	}


	public String getDischargeC() {
		return dischargeC;
	}


	public void setDischargeC(String dischargeC) {
		this.dischargeC = dischargeC;
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


	public Date getWriteDate() {
		return writeDate;
	}


	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}


	@Override
	public String toString() {
		return "MedicalComment_7VO [idx=" + idx + ", patientIdx=" + patientIdx + ", name=" + name + ", recordD="
				+ recordD + ", dischargeC=" + dischargeC + ", employeeIdx=" + employeeIdx + ", employeeName="
				+ employeeName + ", writeDate=" + writeDate + "]";
	}
	
	
}
