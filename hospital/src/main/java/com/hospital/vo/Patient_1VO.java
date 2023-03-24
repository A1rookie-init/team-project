package com.hospital.vo;

import java.util.Date;

public class Patient_1VO {

	private int patientIdx;
	private String name;
	private int registNum1;
	private int registNum2;
	private int age;
	private String gender;
	private String address;
	private String insurance;
	private String room;
	private String meal = "N";
	private String doctorT;
	private String nurseT;
	private String discharge = "N";
	private Date adDate;
	private Date disDate;
	
	private String cc;
	private String pi;
	private String histroy;
	private String allergy;
	private String alcohol = "N";
	private String smoking = "N";
	private String diagnosis = "진료 전";
	private String carePlan;
	private String exDisDate;

	//	디데이 테스트 코드 ==================================================================================
	private int dDay;
	private int diffDay;
	private int dtoDay;
	//	디데이 테스트 코드 ==================================================================================
	
// 생성자 총 3가지
// 기본생성자, 모든 필드인수로받는 생성자, 원무과에서 환자등록시 받는 정보만인수로하는 생성자
	public Patient_1VO() {
		// TODO Auto-generated constructor stub
	}

	
	public Patient_1VO(int patientIdx, String name, int registNum1, int registNum2, int age, String gender,
			String address, String insurance, String room, String meal, String doctorT, String nurseT, String discharge,
			Date adDate, Date disDate, String cc, String pi, String histroy, String allergy, String alcohol,
			String smoking, String diagnosis, String carePlan, String exDisDate) {
		super();
		this.patientIdx = patientIdx;
		this.name = name;
		this.registNum1 = registNum1;
		this.registNum2 = registNum2;
		this.age = age;
		this.gender = gender;
		this.address = address;
		this.insurance = insurance;
		this.room = room;
		this.meal = meal;
		this.doctorT = doctorT;
		this.nurseT = nurseT;
		this.discharge = discharge;
		this.adDate = adDate;
		this.disDate = disDate;
		this.cc = cc;
		this.pi = pi;
		this.histroy = histroy;
		this.allergy = allergy;
		this.alcohol = alcohol;
		this.smoking = smoking;
		this.diagnosis = diagnosis;
		this.carePlan = carePlan;
		this.exDisDate = exDisDate;
		//=========
		dayCount();
		diffCount();
		//=========
	}

	


	public Patient_1VO(int patientIdx, String name, int registNum1, int registNum2, int age, String gender,
			String address, String insurance, String room, String meal, String doctorT, String nurseT, String discharge,
			Date adDate, Date disDate) {
		super();
		this.patientIdx = patientIdx;
		this.name = name;
		this.registNum1 = registNum1;
		this.registNum2 = registNum2;
		this.age = age;
		this.gender = gender;
		this.address = address;
		this.insurance = insurance;
		this.room = room;
		this.meal = meal;
		this.doctorT = doctorT;
		this.nurseT = nurseT;
		this.discharge = discharge;
		this.adDate = adDate;
		this.disDate = disDate;
		
		//=========
		dayCount();
		diffCount();
		//=========
	}
	//	디데이 테스트 코드 ==================================================================================
	public void dayCount() {
		//	오늘 날짜 
		Date today = new Date();
		Date todayForm = new Date(today.getYear(), today.getMonth() , today.getDate());
		
		//입원 날짜
		Date adDayForm = new Date(adDate.getYear() , adDate.getMonth(), adDate.getDate());
		
		long sec = (todayForm.getTime() - adDayForm.getTime()) / 1000;
		dDay = (int)(sec / (24 * 60 * 60)) + 1;
		
	}
	//	디데이 테스트 코드 ==================================================================================
	//	퇴원환자 디데이 테스트 코드 ==================================================================================
	public void diffCount() {
		//	오늘 날짜
		Date today = new Date();
		Date todayForm = new Date(today.getYear(), today.getMonth() , today.getDate());
		
		//입원 날짜
		Date adDayForm = new Date(adDate.getYear() , adDate.getMonth() , adDate.getDate());
		
		//	입원 기간
		long sec = (todayForm.getTime() - adDayForm.getTime()) / 1000;
		dDay = (int)(sec / (24 * 60 * 60)) + 1;
		diffDay = dDay;
		
		//	퇴원일로부터 오늘까지
		Date disDateForm = new Date(disDate.getYear() , disDate.getMonth(), disDate.getDate());
		long sec2 = (todayForm.getTime() - disDateForm.getTime()) / 1000;
		dtoDay = (int)(sec2 / (24 * 60 * 60)) + 1;
	}
	//	퇴원환자 디데이 테스트 코드 ==================================================================================


	public int getPatientIdx() {
		return patientIdx;
	}

	public void setPatientIdx(int patientIdx) {
		this.patientIdx = patientIdx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getRegistNum1() {
		return registNum1;
	}

	public void setRegistNum1(int registNum1) {
		this.registNum1 = registNum1;
	}

	public int getRegistNum2() {
		return registNum2;
	}

	public void setRegistNum2(int registNum2) {
		this.registNum2 = registNum2;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getInsurance() {
		return insurance;
	}

	public void setInsurance(String insurance) {
		this.insurance = insurance;
	}

	public String getRoom() {
		return room;
	}

	public void setRoom(String room) {
		this.room = room;
	}

	public String getMeal() {
		return meal;
	}

	public void setMeal(String meal) {
		this.meal = meal;
	}

	public String getDoctorT() {
		return doctorT;
	}

	public void setDoctorT(String doctorT) {
		this.doctorT = doctorT;
	}

	public String getNurseT() {
		return nurseT;
	}

	public void setNurseT(String nurseT) {
		this.nurseT = nurseT;
	}

	public String getDischarge() {
		return discharge;
	}

	public void setDischarge(String discharge) {
		this.discharge = discharge;
	}

	public Date getAdDate() {
		return adDate;
	}

	public void setAdDate(Date adDate) {
		this.adDate = adDate;
	}

	public Date getDisDate() {
		return disDate;
	}

	public void setDisDate(Date disDate) {
		this.disDate = disDate;
	}

	public String getCc() {
		return cc;
	}

	public void setCc(String cc) {
		this.cc = cc;
	}

	public String getPi() {
		return pi;
	}

	public void setPi(String pi) {
		this.pi = pi;
	}

	public String getHistroy() {
		return histroy;
	}

	public void setHistroy(String histroy) {
		this.histroy = histroy;
	}

	public String getAllergy() {
		return allergy;
	}

	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}

	public String getAlcohol() {
		return alcohol;
	}

	public void setAlcohol(String alcohol) {
		this.alcohol = alcohol;
	}

	public String getSmoking() {
		return smoking;
	}

	public void setSmoking(String smoking) {
		this.smoking = smoking;
	}

	public String getDiagnosis() {
		return diagnosis;
	}

	public void setDiagnosis(String diagnosis) {
		this.diagnosis = diagnosis;
	}

	public String getCarePlan() {
		return carePlan;
	}

	public void setCarePlan(String carePlan) {
		this.carePlan = carePlan;
	}

	public String getExDisDate() {
		return exDisDate;
	}

	public void setExDisDate(String exDisDate) {
		this.exDisDate = exDisDate;
	}

	public int getdDay() {
		return dDay;
	}

	public void setdDay(int dDay) {
		this.dDay = dDay;
	}

	public int getDiffDay() {
		return diffDay;
	}

	public void setDiffDay(int diffDay) {
		this.diffDay = diffDay;
	}

	public int getDtoDay() {
		return dtoDay;
	}

	public void setDtoDay(int dtoDay) {
		this.dtoDay = dtoDay;
	}

	@Override
	public String toString() {
		return "Patient_1VO [patientIdx=" + patientIdx + ", name=" + name + ", registNum1=" + registNum1
				+ ", registNum2=" + registNum2 + ", age=" + age + ", gender=" + gender + ", address=" + address
				+ ", insurance=" + insurance + ", room=" + room + ", meal=" + meal + ", doctorT=" + doctorT
				+ ", nurseT=" + nurseT + ", discharge=" + discharge + ", adDate=" + adDate + ", disDate=" + disDate
				+ ", cc=" + cc + ", pi=" + pi + ", histroy=" + histroy + ", allergy=" + allergy + ", alcohol=" + alcohol
				+ ", smoking=" + smoking + ", diagnosis=" + diagnosis + ", carePlan=" + carePlan + ", exDisDate="
				+ exDisDate + ", dDay=" + dDay + ", diffDay=" + diffDay + ", dtoDay=" + dtoDay + "]";
	}


}
