package com.hospital.vo;

import java.util.Date;

public class TestUrine_21VO {

	private int idx;
	private int patientIdx;
	private String color;
	private String turbidity;
	private float gravity;
	private float acidity;
	private String albumin;
	private String glucose;
	private String ketones;
	private String bilirubin;
	private String blood;
	private String bilinogen;
	private String nitrite;
	private String leukocyte;
	private int employeeIdx;
	private String employeeName;
	private String gender;
	private Date writeDate;
	
	public TestUrine_21VO() {
		// TODO Auto-generated constructor stub
	}

	public TestUrine_21VO(int idx, int patientIdx, String color, String turbidity, float gravity, float acidity,
			String albumin, String glucose, String ketones, String bilirubin, String blood, String bilinogen,
			String nitrite, String leukocyte, int employeeIdx, String employeeName, String gender, Date writeDate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.color = color;
		this.turbidity = turbidity;
		this.gravity = gravity;
		this.acidity = acidity;
		this.albumin = albumin;
		this.glucose = glucose;
		this.ketones = ketones;
		this.bilirubin = bilirubin;
		this.blood = blood;
		this.bilinogen = bilinogen;
		this.nitrite = nitrite;
		this.leukocyte = leukocyte;
		this.employeeIdx = employeeIdx;
		this.employeeName = employeeName;
		this.gender = gender;
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

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getTurbidity() {
		return turbidity;
	}

	public void setTurbidity(String turbidity) {
		this.turbidity = turbidity;
	}

	public float getGravity() {
		return gravity;
	}

	public void setGravity(float gravity) {
		this.gravity = gravity;
	}

	public float getAcidity() {
		return acidity;
	}

	public void setAcidity(float acidity) {
		this.acidity = acidity;
	}

	public String getAlbumin() {
		return albumin;
	}

	public void setAlbumin(String albumin) {
		this.albumin = albumin;
	}

	public String getGlucose() {
		return glucose;
	}

	public void setGlucose(String glucose) {
		this.glucose = glucose;
	}

	public String getKetones() {
		return ketones;
	}

	public void setKetones(String ketones) {
		this.ketones = ketones;
	}

	public String getBilirubin() {
		return bilirubin;
	}

	public void setBilirubin(String bilirubin) {
		this.bilirubin = bilirubin;
	}

	public String getBlood() {
		return blood;
	}

	public void setBlood(String blood) {
		this.blood = blood;
	}

	public String getBilinogen() {
		return bilinogen;
	}

	public void setBilinogen(String bilinogen) {
		this.bilinogen = bilinogen;
	}

	public String getNitrite() {
		return nitrite;
	}

	public void setNitrite(String nitrite) {
		this.nitrite = nitrite;
	}

	public String getLeukocyte() {
		return leukocyte;
	}

	public void setLeukocyte(String leukocyte) {
		this.leukocyte = leukocyte;
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

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	@Override
	public String toString() {
		return "TestUrine_21VO [idx=" + idx + ", patientIdx=" + patientIdx + ", color=" + color + ", turbidity="
				+ turbidity + ", gravity=" + gravity + ", acidity=" + acidity + ", albumin=" + albumin + ", glucose="
				+ glucose + ", ketones=" + ketones + ", bilirubin=" + bilirubin + ", blood=" + blood + ", bilinogen="
				+ bilinogen + ", nitrite=" + nitrite + ", leukocyte=" + leukocyte + ", employeeIdx=" + employeeIdx
				+ ", employeeName=" + employeeName + ", gender=" + gender + ", writeDate=" + writeDate + "]";
	}
	

}
