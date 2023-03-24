package com.hospital.vo;

public class Dpart_23VO {

	private int dpartIdx;
	private String dpartName;
	private String dpartTeam;
	private String dnumber;
	
	public Dpart_23VO() {
		// TODO Auto-generated constructor stub
	}

	public Dpart_23VO(int dpartIdx, String dpartName, String dpartTeam, String dnumber) {
		super();
		this.dpartIdx = dpartIdx;
		this.dpartName = dpartName;
		this.dpartTeam = dpartTeam;
		this.dnumber = dnumber;
	}

	public int getDpartIdx() {
		return dpartIdx;
	}

	public void setDpartIdx(int dpartIdx) {
		this.dpartIdx = dpartIdx;
	}

	public String getDpartName() {
		return dpartName;
	}

	public void setDpartName(String dpartName) {
		this.dpartName = dpartName;
	}

	public String getDpartTeam() {
		return dpartTeam;
	}

	public void setDpartTeam(String dpartTeam) {
		this.dpartTeam = dpartTeam;
	}

	public String getDnumber() {
		return dnumber;
	}

	public void setDnumber(String dnumber) {
		this.dnumber = dnumber;
	}

	@Override
	public String toString() {
		return "Dpart_23VO [dpartIdx=" + dpartIdx + ", dpartName=" + dpartName + ", dpartTeam=" + dpartTeam
				+ ", dnumber=" + dnumber + "]";
	}
	
	
	
}
