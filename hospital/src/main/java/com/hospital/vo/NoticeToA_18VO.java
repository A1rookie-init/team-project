package com.hospital.vo;

import java.util.Date;

public class NoticeToA_18VO {

	private int idx;
	private int patientIdx;
	private String name;
	private String alarmA;
	private String fromDP;
	private int employeeIdx;
	private String fromName;
	private Date writedate;
	
	public NoticeToA_18VO() {
		// TODO Auto-generated constructor stub
	}

	public NoticeToA_18VO(int idx, int patientIdx, String name, String alarmA, String fromDP, int employeeIdx,
			String fromName, Date writedate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.name = name;
		this.alarmA = alarmA;
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

	public String getAlarmA() {
		return alarmA;
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

	public void setAlarmA(String alarmA) {
		this.alarmA = alarmA;
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
		return "NoticeToA_18VO [idx=" + idx + ", patientIdx=" + patientIdx + ", name=" + name + ", alarmA=" + alarmA
				+ ", fromDP=" + fromDP + ", employeeIdx=" + employeeIdx + ", fromName=" + fromName + ", writedate="
				+ writedate + "]";
	}

}
