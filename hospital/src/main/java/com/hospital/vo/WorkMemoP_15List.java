package com.hospital.vo;

import java.util.ArrayList;

public class WorkMemoP_15List {

	private ArrayList<WorkMemoP_15VO> workmemoPList = new ArrayList<WorkMemoP_15VO>();

	public ArrayList<WorkMemoP_15VO> getWorkmemoPList() {
		return workmemoPList;
	}

	public void setWorkmemoPList(ArrayList<WorkMemoP_15VO> workmemoPList) {
		this.workmemoPList = workmemoPList;
	}

	@Override
	public String toString() {
		return "WorkMemoP_15List [workmemoPList=" + workmemoPList + "]";
	}

}
