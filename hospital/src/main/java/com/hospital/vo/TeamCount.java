package com.hospital.vo;

public class TeamCount {

	private int countDTeamA;
	private int countDTeamB;
	private int countNTeamA;
	private int countNTeamB;
	private int countNTeamC;
	
	public TeamCount() { }

	
	public int getCountDTeamA() {
		return countDTeamA;
	}
	public void setCountDTeamA(int countDTeamA) {
		this.countDTeamA = countDTeamA;
	}
	public int getCountDTeamB() {
		return countDTeamB;
	}
	public void setCountDTeamB(int countDTeamB) {
		this.countDTeamB = countDTeamB;
	}
	public int getCountNTeamA() {
		return countNTeamA;
	}
	public void setCountNTeamA(int countNTeamA) {
		this.countNTeamA = countNTeamA;
	}
	public int getCountNTeamB() {
		return countNTeamB;
	}
	public void setCountNTeamB(int countNTeamB) {
		this.countNTeamB = countNTeamB;
	}
	public int getCountNTeamC() {
		return countNTeamC;
	}
	public void setCountNTeamC(int countNTeamC) {
		this.countNTeamC = countNTeamC;
	}

	@Override
	public String toString() {
		return "TeamCount [countDTeamA=" + countDTeamA + ", countDTeamB=" + countDTeamB + ", countNTeamA=" + countNTeamA
				+ ", countNTeamB=" + countNTeamB + ", countNTeamC=" + countNTeamC + "]";
	}
	
}
