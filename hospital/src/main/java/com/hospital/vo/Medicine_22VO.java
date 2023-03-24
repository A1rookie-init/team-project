package com.hospital.vo;

public class Medicine_22VO {

	private String code;
	private String medicine;
	private String dosage;
	private String route;
	private String injectTime;

	public Medicine_22VO() {
		// TODO Auto-generated constructor stub
	}

	public Medicine_22VO(String code, String medicine, String dosage, String route, String injectTime) {
		super();
		this.code = code;
		this.medicine = medicine;
		this.dosage = dosage;
		this.route = route;
		this.injectTime = injectTime;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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

	@Override
	public String toString() {
		return "Medicine_22VO [code=" + code + ", medicine=" + medicine + ", dosage=" + dosage + ", route=" + route
				+ ", injectTime=" + injectTime + "]";
	}
	
	
	
}
