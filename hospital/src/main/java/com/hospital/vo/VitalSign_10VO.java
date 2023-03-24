package com.hospital.vo;

import java.util.Date;

public class VitalSign_10VO {

	private int idx;
	private int patientIdx;
	private String name;
	private String bp;
	private int hr;
	private float bt;
	private int rr;
	private String vitalTime;
	private int employeeIdx;
	private String employeeName;
	private Date writeDate;

	public VitalSign_10VO() {
		// TODO Auto-generated constructor stub
	}

	public VitalSign_10VO(int idx, int patientIdx, String name, String bp, int hr, float bt, int rr, String vitalTime,
			int employeeIdx, String employeeName, Date writeDate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.name = name;
		this.bp = bp;
		this.hr = hr;
		this.bt = bt;
		this.rr = rr;
		this.vitalTime = vitalTime;
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

	public String getBp() {
		return bp;
	}

	public void setBp(String bp) {
		this.bp = bp;
	}

	public int getHr() {
		return hr;
	}

	public void setHr(int hr) {
		this.hr = hr;
	}

	public float getBt() {
		return bt;
	}

	public void setBt(float bt) {
		this.bt = bt;
	}

	public int getRr() {
		return rr;
	}

	public void setRr(int rr) {
		this.rr = rr;
	}

	public String getVitalTime() {
		return vitalTime;
	}

	public void setVitalTime(String vitalTime) {
		this.vitalTime = vitalTime;
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
		return "VitalSign_10VO [idx=" + idx + ", patientIdx=" + patientIdx + ", name=" + name + ", bp=" + bp + ", hr="
				+ hr + ", bt=" + bt + ", rr=" + rr + ", vitalTime=" + vitalTime + ", employeeIdx=" + employeeIdx
				+ ", employeeName=" + employeeName + ", writeDate=" + writeDate + "]";
	}
	
	
	

}
