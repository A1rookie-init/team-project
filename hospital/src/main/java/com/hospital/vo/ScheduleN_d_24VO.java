package com.hospital.vo;

import java.util.ArrayList;

public class ScheduleN_d_24VO {

	private String idx;
	private String team;
	private int year;
	private int month;
	
	private int shiftD_1;
	private int shiftD_2;
	private int shiftD_3;
	private int shiftD_4;
	private int shiftD_5;
	private int shiftD_6;
	private int shiftD_7;
	private int shiftD_8;
	private int shiftD_9;
	private int shiftD_10;
	private int shiftD_11;
	private int shiftD_12;
	private int shiftD_13;
	private int shiftD_14;
	private int shiftD_15;
	private int shiftD_16;
	private int shiftD_17;
	private int shiftD_18;
	private int shiftD_19;
	private int shiftD_20;
	private int shiftD_21;
	private int shiftD_22;
	private int shiftD_23;
	private int shiftD_24;
	private int shiftD_25;
	private int shiftD_26;
	private int shiftD_27;
	private int shiftD_28;
	private int shiftD_29;
	private int shiftD_30;
	private int shiftD_31;
	
	private int lastN;
	private int managerIdx;
	
	public ScheduleN_d_24VO() {
	}

	// 한달 데이 근무자 리스트로 반환해주는 메소드 
	public ArrayList<Integer> getDayList() {
		
		ArrayList<Integer> dayList = new ArrayList<Integer>();
		dayList.add(shiftD_1);
		dayList.add(shiftD_2);
		dayList.add(shiftD_3);
		dayList.add(shiftD_4);
		dayList.add(shiftD_5);
		dayList.add(shiftD_6);
		dayList.add(shiftD_7);
		dayList.add(shiftD_8);
		dayList.add(shiftD_9);
		dayList.add(shiftD_10);
		dayList.add(shiftD_11);
		dayList.add(shiftD_12);
		dayList.add(shiftD_13);
		dayList.add(shiftD_14);
		dayList.add(shiftD_15);
		dayList.add(shiftD_16);
		dayList.add(shiftD_17);
		dayList.add(shiftD_18);
		dayList.add(shiftD_19);
		dayList.add(shiftD_20);
		dayList.add(shiftD_21);
		dayList.add(shiftD_22);
		dayList.add(shiftD_23);
		dayList.add(shiftD_24);
		dayList.add(shiftD_25);
		dayList.add(shiftD_26);
		dayList.add(shiftD_27);
		dayList.add(shiftD_28);
		dayList.add(shiftD_29);
		dayList.add(shiftD_30);
		dayList.add(shiftD_31);
		return dayList;
	}
	
	// 날짜를 넣으면 해당날의 데이근무자의 사번을 돌려주는 메소드
	public int getDayWho(int i) {
		System.out.println("getDayWho()메소드 실행" + i);
		ArrayList<Integer> dayList = getDayList();
		return dayList.get(i-1);
	}
	
	
	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getShiftD_1() {
		return shiftD_1;
	}

	public void setShiftD_1(int shiftD_1) {
		this.shiftD_1 = shiftD_1;
	}

	public int getShiftD_2() {
		return shiftD_2;
	}

	public void setShiftD_2(int shiftD_2) {
		this.shiftD_2 = shiftD_2;
	}

	public int getShiftD_3() {
		return shiftD_3;
	}

	public void setShiftD_3(int shiftD_3) {
		this.shiftD_3 = shiftD_3;
	}

	public int getShiftD_4() {
		return shiftD_4;
	}

	public void setShiftD_4(int shiftD_4) {
		this.shiftD_4 = shiftD_4;
	}

	public int getShiftD_5() {
		return shiftD_5;
	}

	public void setShiftD_5(int shiftD_5) {
		this.shiftD_5 = shiftD_5;
	}

	public int getShiftD_6() {
		return shiftD_6;
	}

	public void setShiftD_6(int shiftD_6) {
		this.shiftD_6 = shiftD_6;
	}

	public int getShiftD_7() {
		return shiftD_7;
	}

	public void setShiftD_7(int shiftD_7) {
		this.shiftD_7 = shiftD_7;
	}

	public int getShiftD_8() {
		return shiftD_8;
	}

	public void setShiftD_8(int shiftD_8) {
		this.shiftD_8 = shiftD_8;
	}

	public int getShiftD_9() {
		return shiftD_9;
	}

	public void setShiftD_9(int shiftD_9) {
		this.shiftD_9 = shiftD_9;
	}

	public int getShiftD_10() {
		return shiftD_10;
	}

	public void setShiftD_10(int shiftD_10) {
		this.shiftD_10 = shiftD_10;
	}

	public int getShiftD_11() {
		return shiftD_11;
	}

	public void setShiftD_11(int shiftD_11) {
		this.shiftD_11 = shiftD_11;
	}

	public int getShiftD_12() {
		return shiftD_12;
	}

	public void setShiftD_12(int shiftD_12) {
		this.shiftD_12 = shiftD_12;
	}

	public int getShiftD_13() {
		return shiftD_13;
	}

	public void setShiftD_13(int shiftD_13) {
		this.shiftD_13 = shiftD_13;
	}

	public int getShiftD_14() {
		return shiftD_14;
	}

	public void setShiftD_14(int shiftD_14) {
		this.shiftD_14 = shiftD_14;
	}

	public int getShiftD_15() {
		return shiftD_15;
	}

	public void setShiftD_15(int shiftD_15) {
		this.shiftD_15 = shiftD_15;
	}

	public int getShiftD_16() {
		return shiftD_16;
	}

	public void setShiftD_16(int shiftD_16) {
		this.shiftD_16 = shiftD_16;
	}

	public int getShiftD_17() {
		return shiftD_17;
	}

	public void setShiftD_17(int shiftD_17) {
		this.shiftD_17 = shiftD_17;
	}

	public int getShiftD_18() {
		return shiftD_18;
	}

	public void setShiftD_18(int shiftD_18) {
		this.shiftD_18 = shiftD_18;
	}

	public int getShiftD_19() {
		return shiftD_19;
	}

	public void setShiftD_19(int shiftD_19) {
		this.shiftD_19 = shiftD_19;
	}

	public int getShiftD_20() {
		return shiftD_20;
	}

	public void setShiftD_20(int shiftD_20) {
		this.shiftD_20 = shiftD_20;
	}

	public int getShiftD_21() {
		return shiftD_21;
	}

	public void setShiftD_21(int shiftD_21) {
		this.shiftD_21 = shiftD_21;
	}

	public int getShiftD_22() {
		return shiftD_22;
	}

	public void setShiftD_22(int shiftD_22) {
		this.shiftD_22 = shiftD_22;
	}

	public int getShiftD_23() {
		return shiftD_23;
	}

	public void setShiftD_23(int shiftD_23) {
		this.shiftD_23 = shiftD_23;
	}

	public int getShiftD_24() {
		return shiftD_24;
	}

	public void setShiftD_24(int shiftD_24) {
		this.shiftD_24 = shiftD_24;
	}

	public int getShiftD_25() {
		return shiftD_25;
	}

	public void setShiftD_25(int shiftD_25) {
		this.shiftD_25 = shiftD_25;
	}

	public int getShiftD_26() {
		return shiftD_26;
	}

	public void setShiftD_26(int shiftD_26) {
		this.shiftD_26 = shiftD_26;
	}

	public int getShiftD_27() {
		return shiftD_27;
	}

	public void setShiftD_27(int shiftD_27) {
		this.shiftD_27 = shiftD_27;
	}

	public int getShiftD_28() {
		return shiftD_28;
	}

	public void setShiftD_28(int shiftD_28) {
		this.shiftD_28 = shiftD_28;
	}

	public int getShiftD_29() {
		return shiftD_29;
	}

	public void setShiftD_29(int shiftD_29) {
		this.shiftD_29 = shiftD_29;
	}

	public int getShiftD_30() {
		return shiftD_30;
	}

	public void setShiftD_30(int shiftD_30) {
		this.shiftD_30 = shiftD_30;
	}

	public int getShiftD_31() {
		return shiftD_31;
	}

	public void setShiftD_31(int shiftD_31) {
		this.shiftD_31 = shiftD_31;
	}

	public int getLastN() {
		return lastN;
	}

	public void setLastN(int lastN) {
		this.lastN = lastN;
	}

	public int getManagerIdx() {
		return managerIdx;
	}

	public void setManagerIdx(int managerIdx) {
		this.managerIdx = managerIdx;
	}

	@Override
	public String toString() {
		return "ScheduleN_d_24VO [idx=" + idx + ", team=" + team + ", year=" + year + ", month=" + month 
				+ ", shiftD_1=" + shiftD_1 + ", shiftD_2=" + shiftD_2 + ", shiftD_3=" + shiftD_3
				+ ", shiftD_4=" + shiftD_4 + ", shiftD_5=" + shiftD_5 + ", shiftD_6=" + shiftD_6 + ", shiftD_7="
				+ shiftD_7 + ", shiftD_8=" + shiftD_8 + ", shiftD_9=" + shiftD_9 + ", shiftD_10=" + shiftD_10
				+ ", shiftD_11=" + shiftD_11 + ", shiftD_12=" + shiftD_12 + ", shiftD_13=" + shiftD_13 + ", shiftD_14="
				+ shiftD_14 + ", shiftD_15=" + shiftD_15 + ", shiftD_16=" + shiftD_16 + ", shiftD_17=" + shiftD_17
				+ ", shiftD_18=" + shiftD_18 + ", shiftD_19=" + shiftD_19 + ", shiftD_20=" + shiftD_20 + ", shiftD_21="
				+ shiftD_21 + ", shiftD_22=" + shiftD_22 + ", shiftD_23=" + shiftD_23 + ", shiftD_24=" + shiftD_24
				+ ", shiftD_25=" + shiftD_25 + ", shiftD_26=" + shiftD_26 + ", shiftD_27=" + shiftD_27 + ", shiftD_28="
				+ shiftD_28 + ", shiftD_29=" + shiftD_29 + ", shiftD_30=" + shiftD_30 + ", shiftD_31=" + shiftD_31
				+ ", lastN=" + lastN + ", managerIdx=" + managerIdx + "]";
	}
	
	
}
