package com.hospital.vo;

import java.util.ArrayList;

public class NoticeToA_18List{

	private ArrayList<NoticeToA_18VO> noticeToAlist = new ArrayList<NoticeToA_18VO>();

	public ArrayList<NoticeToA_18VO> getNoticeToAList() {
		return noticeToAlist;
	}

	public void setNoticeToAList(ArrayList<NoticeToA_18VO> noticeToAlist) {
		this.noticeToAlist = noticeToAlist;
	}

	@Override
	public String toString() {
		return "NoticeToA_18List [noticeToAlist=" + noticeToAlist + "]";
	}


}
