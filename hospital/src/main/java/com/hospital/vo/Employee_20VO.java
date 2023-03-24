package com.hospital.vo;

import java.sql.Date;

public class Employee_20VO {

	private int employeeIdx;
	private String password;
	private String name;
	private String gender;
	private int age;
	private String dpart;
	private String doctorT;
	private String nurseT;
	private String dnumber;
	private String enumber;
	private String admin;
	private String orgFileName;
	private String savedFileName;
	private String sign;
	private Date hiredate;
	private Date firedate;
	
	public Employee_20VO() {
		// TODO Auto-generated constructor stub
	}

	public int getEmployeeIdx() {
		return employeeIdx;
	}

	public void setEmployeeIdx(int employeeIdx) {
		this.employeeIdx = employeeIdx;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getDpart() {
		return dpart;
	}

	public void setDpart(String dpart) {
		this.dpart = dpart;
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

	public String getDnumber() {
		return dnumber;
	}

	public void setDnumber(String dnumber) {
		this.dnumber = dnumber;
	}

	public String getEnumber() {
		return enumber;
	}

	public void setEnumber(String enumber) {
		this.enumber = enumber;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public String getOrgFileName() {
		return orgFileName;
	}

	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}

	public String getSavedFileName() {
		return savedFileName;
	}

	public void setSavedFileName(String savedFileName) {
		this.savedFileName = savedFileName;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	
	public Date getHiredate() {
		return hiredate;
	}

	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}

	public Date getFiredate() {
		return firedate;
	}

	public void setFiredate(Date firedate) {
		this.firedate = firedate;
	}

	@Override
	public String toString() {
		return "Employee_20VO [employeeIdx=" + employeeIdx + ", password=" + password + ", name=" + name + ", gender="
				+ gender + ", age=" + age + ", dpart=" + dpart + ", doctorT=" + doctorT + ", nurseT=" + nurseT
				+ ", dnumber=" + dnumber + ", enumber=" + enumber + ", admin=" + admin + ", orgFileName=" + orgFileName
				+ ", savedFileName=" + savedFileName + ", sign=" + sign + ", hiredate=" + hiredate + ", firedate="
				+ firedate + "]";
	}

	
	
}
