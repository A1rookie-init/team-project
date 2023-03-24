package com.hospital.vo;

import java.util.Date;

public class PrescriptionMed_4VO {

	private int idx;
	private int patientIdx;
	private String name;
	private String medicine;
	private String dosage;
	private String route;
	private String injectTime;
	private String dischargeM = "N";
	private int employeeIdx;
	private String employeeName;
	private Date writedate;


	public PrescriptionMed_4VO() {
		// TODO Auto-generated constructor stub
	}


	public PrescriptionMed_4VO(int idx, int patientIdx, String name, String medicine, String dosage, String route,
			String injectTime, String dischargeM, int employeeIdx, String employeeName, Date writedate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.name = name;
		this.medicine = medicine;
		this.dosage = dosage;
		this.route = route;
		this.injectTime = injectTime;
		this.dischargeM = dischargeM;
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


	public String getDischargeM() {
		return dischargeM;
	}


	public void setDischargeM(String dischargeM) {
		this.dischargeM = dischargeM;
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
		return "PrescriptionMed_4VO [idx=" + idx + ", patientIdx=" + patientIdx + ", name=" + name + ", medicine="
				+ medicine + ", dosage=" + dosage + ", route=" + route + ", injectTime=" + injectTime + ", dischargeM="
				+ dischargeM + ", employeeIdx=" + employeeIdx + ", employeeName=" + employeeName + ", writedate="
				+ writedate + "]";
	}


}
