package com.hospital.vo;

import java.util.Date;

public class NoticeToD_2VO {

	private int idx;
	private int patientIdx;
	private String name;
	private String alarmD;
	private String fromDP;
	private int employeeIdx;
	private String fromName;
	private Date writedate;

	public NoticeToD_2VO() {
		// TODO Auto-generated constructor stub
	}

	public NoticeToD_2VO(int idx, int patientIdx, String name, String alarmD, String fromDP, int employeeIdx,
			String fromName, Date writedate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.name = name;
		this.alarmD = alarmD;
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

	public String getAlarmD() {
		return alarmD;
	}

	public void setAlarmD(String alarmD) {
		this.alarmD = alarmD;
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
		return "NoticeToD_2VO [idx=" + idx + ", patientIdx=" + patientIdx + ", name=" + name + ", alarmD=" + alarmD
				+ ", fromDP=" + fromDP + ", employeeIdx=" + employeeIdx + ", fromName=" + fromName + ", writedate="
				+ writedate + "]";
	}

	
	

}
