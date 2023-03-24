package com.hospital.vo;

import java.util.Date;

public class NoticeToN_8VO {

	private int idx;
	private int patientIdx;
	private String name;
	private String alarmN;
	private String fromDP;
	private int employeeIdx;
	private String fromName;
	private Date writedate;


	public NoticeToN_8VO() {
		// TODO Auto-generated constructor stub
	}


	public NoticeToN_8VO(int idx, int patientIdx, String name, String alarmN, String fromDP, int employeeIdx,
			String fromName, Date writedate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.name = name;
		this.alarmN = alarmN;
		this.fromDP = fromDP;
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


	public String getAlarmN() {
		return alarmN;
	}


	public void setAlarmN(String alarmN) {
		this.alarmN = alarmN;
	}


	public String getFromDP() {
		return fromDP;
	}


	public void setFromDP(String fromDP) {
		this.fromDP = fromDP;
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
		return "NoticeToN_8VO [idx=" + idx + ", patientIdx=" + patientIdx + ", name=" + name + ", alarmN=" + alarmN
				+ ", fromDP=" + fromDP + ", employeeIdx=" + employeeIdx + ", fromName=" + fromName + ", writedate="
				+ writedate + "]";
	}
	
	

}
