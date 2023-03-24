package com.hospital.vo;

import java.util.ArrayList;

public class Patient_1List_All {

	private ArrayList<Patient_1VO> patient_1List_All = new ArrayList<Patient_1VO>();

	public ArrayList<Patient_1VO> getPatient_1List_All() {
		return patient_1List_All;
	}

	public void setPatient_1List_All(ArrayList<Patient_1VO> patient_1List_All) {
		this.patient_1List_All = patient_1List_All;
	}

	@Override
	public String toString() {
		return "Patient_1List_All [patient_1List_All=" + patient_1List_All + "]";
	}

}
