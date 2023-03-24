package com.hospital.vo;


public class ViewNursingVO {
	
	private VitalSign_10List vitalSignList;
	
	private Injection_11List injectionList;
	
	private NursingComment_13_List nursingCommentList;
	
	
	public ViewNursingVO() {
		// TODO Auto-generated constructor stub
	}


	public VitalSign_10List getVitalSignList() {
		return vitalSignList;
	}


	public void setVitalSignList(VitalSign_10List vitalSignList) {
		this.vitalSignList = vitalSignList;
	}


	public Injection_11List getInjectionList() {
		return injectionList;
	}


	public void setInjectionList(Injection_11List injectionList) {
		this.injectionList = injectionList;
	}


	public NursingComment_13_List getNursingCommentList() {
		return nursingCommentList;
	}


	public void setNursingCommentList(NursingComment_13_List nursingCommentList) {
		this.nursingCommentList = nursingCommentList;
	}


	@Override
	public String toString() {
		return "ViewNursingVO [vitalSignList=" + vitalSignList + ", injectionList=" + injectionList
				+ ", nursingCommentList=" + nursingCommentList + "]";
	}


	
	
	
	
	
}
