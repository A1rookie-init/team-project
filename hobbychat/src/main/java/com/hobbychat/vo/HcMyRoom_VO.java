package com.hobbychat.vo;

public class HcMyRoom_VO {

	private String roomId;
	private String roomName;
	private int userCnt;
	private String coverImg = "null.png";
	private int newMsg;
	
	public HcMyRoom_VO() {
	}

	public HcMyRoom_VO(String roomId, String roomName, int userCnt, String coverImg, int newMsg) {
		super();
		this.roomId = roomId;
		this.roomName = roomName;
		this.userCnt = userCnt;
		this.coverImg = coverImg;
		this.newMsg = newMsg;
	}

	public String getRoomId() {
		return roomId;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public int getUserCnt() {
		return userCnt;
	}

	public void setUserCnt(int userCnt) {
		this.userCnt = userCnt;
	}

	public String getCoverImg() {
		return coverImg;
	}

	public void setCoverImg(String coverImg) {
		this.coverImg = coverImg;
	}

	public int getNewMsg() {
		return newMsg;
	}

	public void setNewMsg(int newMsg) {
		this.newMsg = newMsg;
	}

	@Override
	public String toString() {
		return "HcMyRoom_VO [roomId=" + roomId + ", roomName=" + roomName + ", userCnt=" + userCnt + ", coverImg="
				+ coverImg + ", newMsg=" + newMsg + "]";
	}
	
}
