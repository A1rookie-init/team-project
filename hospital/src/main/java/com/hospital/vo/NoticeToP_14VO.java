package com.hospital.vo;

import java.util.Date;

public class NoticeToP_14VO {

	private int idx;
	private int patientIdx;
	private String name;
	private String alarmP;
	private String fromDP = "간호사";
	private int employeeIdx;
	private String fromName;
	private Date writedate;

	public NoticeToP_14VO() {
		// TODO Auto-generated constructor stub
	}
	public NoticeToP_14VO(int idx, int patientIdx, String name, String alarmP, String fromDP, int employeeIdx,
			String fromName, Date writedate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.name = name;
		this.alarmP = alarmP;
		this.fromDP = fromDP;
		this.employeeIdx = employeeIdx;
		this.fromName = fromName;
		this.writedate = writedate;
	}

	public int getIdx() {
		return idx;
	}

	public int getPatientIdx() {
		return patientIdx;
	}

	public String getName() {
		return name;
	}

	public String getAlarmP() {
		return alarmP;
	}

	public String getFromDP() {
		return fromDP;
	}

	public int getEmployeeIdx() {
		return employeeIdx;
	}

	public String getFromName() {
		return fromName;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public void setPatientIdx(int patientIdx) {
		this.patientIdx = patientIdx;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setAlarmP(String alarmP) {
		this.alarmP = alarmP;
	}

	public void setFromDP(String fromDP) {
		this.fromDP = fromDP;
	}

	public void setEmployeeIdx(int employeeIdx) {
		this.employeeIdx = employeeIdx;
	}

	public void setFromName(String fromName) {
		this.fromName = fromName;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	@Override
	public String toString() {
		return "NoticeToP_14VO [idx=" + idx + ", patientIdx=" + patientIdx + ", name=" + name + ", alarmP=" + alarmP
				+ ", fromDP=" + fromDP + ", employeeIdx=" + employeeIdx + ", fromName=" + fromName + ", writedate="
				+ writedate + "]";
	}

}
