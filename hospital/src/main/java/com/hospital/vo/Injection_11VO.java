package com.hospital.vo;

import java.util.Date;

public class Injection_11VO {

	private int idx;
	private int patientIdx;
	private String name;
	private String medicine;
	private String dosage;
	private String route;
	private String injectTime;
	private String realTime9A = "N";
	private String realTime1P = "N";
	private String realTime6P = "N";
	private String realTime9P = "N";
	private int employeeIdx;
	private String employeeName;
	private Date writedate;

	public Injection_11VO() {
		// TODO Auto-generated constructor stub
	}

	public Injection_11VO(int idx, int patientIdx, String name, String medicine, String dosage, String route,
			String injectTime, String realTime9A, String realTime1P, String realTime6P, String realTime9P,
			int employeeIdx, String employeeName, Date writedate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.name = name;
		this.medicine = medicine;
		this.dosage = dosage;
		this.route = route;
		this.injectTime = injectTime;
		this.realTime9A = realTime9A;
		this.realTime1P = realTime1P;
		this.realTime6P = realTime6P;
		this.realTime9P = realTime9P;
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

	public String getMedicine() {
		return medicine;
	}

	public void setMedicine(String medicine) {
		this.medicine = medicine;
	}

	public String getDosage() {
		return dosage;
	}

	public void setDosage(String dosage) {
		this.dosage = dosage;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public String getInjectTime() {
		return injectTime;
	}

	public void setInjectTime(String injectTime) {
		this.injectTime = injectTime;
	}

	public String getRealTime9A() {
		return realTime9A;
	}

	public void setRealTime9A(String realTime9A) {
		this.realTime9A = realTime9A;
	}

	public String getRealTime1P() {
		return realTime1P;
	}

	public void setRealTime1P(String realTime1P) {
		this.realTime1P = realTime1P;
	}

	public String getRealTime6P() {
		return realTime6P;
	}

	public void setRealTime6P(String realTime6P) {
		this.realTime6P = realTime6P;
	}

	public String getRealTime9P() {
		return realTime9P;
	}

	public void setRealTime9P(String realTime9P) {
		this.realTime9P = realTime9P;
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
		return "Injection_11VO [idx=" + idx + ", patientIdx=" + patientIdx + ", name=" + name + ", medicine=" + medicine
				+ ", dosage=" + dosage + ", route=" + route + ", injectTime=" + injectTime + ", realTime9A="
				+ realTime9A + ", realTime1P=" + realTime1P + ", realTime6P=" + realTime6P + ", realTime9P="
				+ realTime9P + ", employeeIdx=" + employeeIdx + ", employeeName=" + employeeName + ", writedate="
				+ writedate + "]";
	}

	

}
