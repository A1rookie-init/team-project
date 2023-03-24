package com.hospital.vo;

import java.util.ArrayList;

public class PrescriptionMed_4List {

	private ArrayList<PrescriptionMed_4VO> prescriptionMedList = new ArrayList<PrescriptionMed_4VO>();

	public ArrayList<PrescriptionMed_4VO> getPrescriptionMedList() {
		return prescriptionMedList;
	}

	public void setPrescriptionMedList(ArrayList<PrescriptionMed_4VO> prescriptionMedList) {
		this.prescriptionMedList = prescriptionMedList;
	}

	@Override
	public String toString() {
		return "PrescriptionMed_4List [prescriptionMedList=" + prescriptionMedList + "]";
	}

	
	
}
