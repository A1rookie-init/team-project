package com.hospital.vo;

import java.util.ArrayList;

public class MedicalComment_7List {

	private ArrayList<MedicalComment_7VO> medicalCommentList = new ArrayList<MedicalComment_7VO>();

	public MedicalComment_7List(ArrayList<MedicalComment_7VO> medicalCommentList) {
		super();
		this.medicalCommentList = medicalCommentList;
	}

	public MedicalComment_7List() {
	
	}


	public ArrayList<MedicalComment_7VO> getMedicalCommentList() {
		return medicalCommentList;
	}

	public void setMedicalCommentList(ArrayList<MedicalComment_7VO> medicalCommentList) {
		this.medicalCommentList = medicalCommentList;
	}

	@Override
	public String toString() {
		return "MedicalComment_7List [medicalCommentList=" + medicalCommentList + "]";
	}
	
	
}
