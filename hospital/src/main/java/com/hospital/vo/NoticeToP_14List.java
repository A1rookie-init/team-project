package com.hospital.vo;

import java.util.ArrayList;

public class NoticeToP_14List {

	private ArrayList<NoticeToP_14VO> noticeToPList = new ArrayList<NoticeToP_14VO>();

	public ArrayList<NoticeToP_14VO> getNoticeToPList() {
		return noticeToPList;
	}

	public void setNoticeToPList(ArrayList<NoticeToP_14VO> noticeToPList) {
		this.noticeToPList = noticeToPList;
	}

	@Override
	public String toString() {
		return "NoticeToP_14List [noticeToPList=" + noticeToPList + "]";
	}
}
