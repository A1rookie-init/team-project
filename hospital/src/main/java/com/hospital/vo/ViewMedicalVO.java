package com.hospital.vo;



public class ViewMedicalVO {
	
	private PrescriptionMed_4List prescriptionMedList;
	
	private PrescriptionTest_5List prescriptionTestList;
	
	private MedicalComment_7List medicalCommentList;
	
	
	public ViewMedicalVO() {
		// TODO Auto-generated constructor stub
	}


	public PrescriptionMed_4List getPrescriptionMedList() {
		return prescriptionMedList;
	}


	public void setPrescriptionMedList(PrescriptionMed_4List prescriptionMedList) {
		this.prescriptionMedList = prescriptionMedList;
	}


	public PrescriptionTest_5List getPrescriptionTestList() {
		return prescriptionTestList;
	}


	public void setPrescriptionTestList(PrescriptionTest_5List prescriptionTestList) {
		this.prescriptionTestList = prescriptionTestList;
	}


	public MedicalComment_7List getMedicalCommentList() {
		return medicalCommentList;
	}


	public void setMedicalCommentList(MedicalComment_7List medicalCommentList) {
		this.medicalCommentList = medicalCommentList;
	}


	@Override
	public String toString() {
		return "ViewMedicalVO [prescriptionMedList=" + prescriptionMedList + ", prescriptionTestList="
				+ prescriptionTestList + ", medicalCommentList=" + medicalCommentList + "]";
	}

	
	

	
	
	
	
	
}
