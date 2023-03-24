package com.hospital.vo;

import java.util.ArrayList;

public class Patient_1List_My {

	private ArrayList<Patient_1VO> patient_1List_My = new ArrayList<>();

	public ArrayList<Patient_1VO> getPatient_1List_My() {
		return patient_1List_My;
	}

	public void setPatient_1List_My(ArrayList<Patient_1VO> patient_1List_My) {
		this.patient_1List_My = patient_1List_My;
	}

	@Override
	public String toString() {
		return "Patient_1List_Doctor [patient_1List_My=" + patient_1List_My + "]";
	}
	
	
}
