package com.hospital.vo;

import java.util.Date;

public class TestBlood_17VO {

	private int idx;
	private int patientIdx;
	private String gender;
	private int WBC;
	private float Hb;
	private float Hct;
	private int RBC;
	private int MCV;
	private int MCH;
	private int MCHC;
	private Integer Platelet;
	private int employeeIdx;
	private String employeeName;
	private Date writeDate;

	public TestBlood_17VO() {
		// TODO Auto-generated constructor stub
	}

	public TestBlood_17VO(int idx, int patientIdx, String gender, int wBC, float hb, float hct, int rBC, int mCV,
			int mCH, int mCHC, Integer platelet, int employeeIdx, String employeeName, Date writeDate) {
		super();
		this.idx = idx;
		this.patientIdx = patientIdx;
		this.gender = gender;
		WBC = wBC;
		Hb = hb;
		Hct = hct;
		RBC = rBC;
		MCV = mCV;
		MCH = mCH;
		MCHC = mCHC;
		Platelet = platelet;
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

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getWBC() {
		return WBC;
	}

	public void setWBC(int wBC) {
		WBC = wBC;
	}

	public float getHb() {
		return Hb;
	}

	public void setHb(float hb) {
		Hb = hb;
	}

	public float getHct() {
		return Hct;
	}

	public void setHct(float hct) {
		Hct = hct;
	}

	public int getRBC() {
		return RBC;
	}

	public void setRBC(int rBC) {
		RBC = rBC;
	}

	public int getMCV() {
		return MCV;
	}

	public void setMCV(int mCV) {
		MCV = mCV;
	}

	public int getMCH() {
		return MCH;
	}

	public void setMCH(int mCH) {
		MCH = mCH;
	}

	public int getMCHC() {
		return MCHC;
	}

	public void setMCHC(int mCHC) {
		MCHC = mCHC;
	}

	public int getPlatelet() {
		return Platelet;
	}

	public void setPlatelet(int platelet) {
		Platelet = platelet;
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
		return "TestBlood_17VO [idx=" + idx + ", patientIdx=" + patientIdx + ", gender=" + gender + ", WBC=" + WBC
				+ ", Hb=" + Hb + ", Hct=" + Hct + ", RBC=" + RBC + ", MCV=" + MCV + ", MCH=" + MCH + ", MCHC=" + MCHC
				+ ", Platelet=" + Platelet + ", employeeIdx=" + employeeIdx + ", employeeName=" + employeeName
				+ ", writeDate=" + writeDate + "]";
	}
	
	

}
