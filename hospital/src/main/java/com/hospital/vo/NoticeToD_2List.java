package com.hospital.vo;

import java.util.ArrayList;

public class NoticeToD_2List {

	private ArrayList<NoticeToD_2VO> noticeToDList = new ArrayList<NoticeToD_2VO>();

	public ArrayList<NoticeToD_2VO> getNoticeToDList() {
		return noticeToDList;
	}

	public void setNoticeToDList(ArrayList<NoticeToD_2VO> noticeToDList) {
		this.noticeToDList = noticeToDList;
	}

	@Override
	public String toString() {
		return "NoticeToD_2List [noticeToDList=" + noticeToDList + "]";
	}

	
	
}
