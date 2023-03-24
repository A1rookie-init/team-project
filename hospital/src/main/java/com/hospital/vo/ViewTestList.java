package com.hospital.vo;

import java.util.ArrayList;

public class ViewTestList {

	private ArrayList<TestBlood_17VO> testBloodList = new ArrayList<TestBlood_17VO>();
	private ArrayList<TestUrine_21VO> testUrineList = new ArrayList<TestUrine_21VO>();
	
//	totalCount == diffDay 이다 , totalCount와 startNo, endNo는 인덱스번호이다
	
	private int pageSize = 3; // 한 페이지에 표시할 글 개수
	private int totalCount = 0; // 테이블에 저장된 전체 글 개수
	private int totalPage = 0; // 전체 페이지 개수
	private int currentPage = 1; // 현재 브라우저에 표시되는 페이지 번호
	private int startNo = 0; // 현재 브라우저에 표시되는 글의 시작 인덱스 번호 => mysql은 index가 0부터 시작된다. 오라클은 1부터
	private int endNo = 0; // 현재 브라우저에 표시되는 글의 마지막 인덱스 번호
	private int startPage = 0; // 페이지 이동 하이퍼링크 또는 버튼에 표시될 시작 페이지 번호
	private int endPage = 0; // 페이지 이동 하이퍼링크 또는 버튼에 표시될 마지막 페이지 번호
	
	//	혈액검사, 소변검사 구분 키워드 저장
	private String test;
	
	public ViewTestList() {
		// TODO Auto-generated constructor stub
	}

	public ViewTestList(int pageSize, int totalCount, int currentPage) {
		super();
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.currentPage = currentPage;
		calculator();
	}
	
	public void calculator() {
		totalPage = (int) Math.ceil(totalCount / 3.0);
		currentPage = currentPage > totalPage ? totalPage : currentPage;

		startNo = (currentPage - 1) * pageSize; 
		endNo = startNo + pageSize - 1;   
		endNo = endNo > totalCount -1 ? totalCount -1 : endNo;
		startPage = (currentPage - 1) / 5 * 5 + 1;			// 밑에 나열되는 페이지들번호의 시작, 나열번호의 개수(5개씩)
		endPage = startPage + 4;
		endPage = endPage > totalPage ? totalPage : endPage;
	}

	public ArrayList<TestBlood_17VO> getTestBloodList() {
		return testBloodList;
	}

	public void setTestBloodList(ArrayList<TestBlood_17VO> testBloodList) {
		this.testBloodList = testBloodList;
	}

	public ArrayList<TestUrine_21VO> getTestUrineList() {
		return testUrineList;
	}

	public void setTestUrineList(ArrayList<TestUrine_21VO> testUrineList) {
		this.testUrineList = testUrineList;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getStartNo() {
		return startNo;
	}

	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public String getTest() {
		return test;
	}

	public void setTest(String test) {
		this.test = test;
	}

	@Override
	public String toString() {
		return "ViewTestList [testBloodList=" + testBloodList + ", testUrineList=" + testUrineList + ", pageSize="
				+ pageSize + ", totalCount=" + totalCount + ", totalPage=" + totalPage + ", currentPage=" + currentPage
				+ ", startNo=" + startNo + ", endNo=" + endNo + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", test=" + test + "]";
	}

	
}
