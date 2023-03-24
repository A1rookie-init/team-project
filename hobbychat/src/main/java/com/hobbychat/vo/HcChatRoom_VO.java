package com.hobbychat.vo;

public class HcChatRoom_VO {

	private String roomId;
	private String roomName;
	private String roomTag;
	private String rComment;
	private int userCnt;
	private String userList; 
	private String coverImg;
	
	public HcChatRoom_VO() {
	}

	public HcChatRoom_VO(String roomId, String roomName, String roomTag, String rComment, int userCnt,
			String userList, String coverImg) {
		super();
		this.roomId = roomId;
		this.roomName = roomName;
		this.roomTag = roomTag;
		this.rComment = rComment;
		this.userCnt = userCnt;
		this.userList = userList;
		this.coverImg = coverImg;
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

	public String getRoomTag() {
		return roomTag;
	}

	public void setRoomTag(String roomTag) {
		this.roomTag = roomTag;
	}

	public String getrComment() {
		return rComment;
	}

	public void setrComment(String rComment) {
		this.rComment = rComment;
	}

	public int getUserCnt() {
		return userCnt;
	}

	public void setUserCnt(int userCnt) {
		this.userCnt = userCnt;
	}

	public String getUserList() {
		return userList;
	}

	public void setUserList(String userList) {
		this.userList = userList;
	}

	public String getCoverImg() {
		return coverImg;
	}

	public void setCoverImg(String coverImg) {
		this.coverImg = coverImg;
	}

	@Override
	public String toString() {
		return "HcChatRoom_VO [roomId=" + roomId + ", roomName=" + roomName + ", roomTag=" + roomTag
				+ ", rComment=" + rComment + ", userCnt=" + userCnt + ", userList=" + userList + ", coverImg="
				+ coverImg + "]";
	}
	
}
