package com.hobbychat.vo;

public class HcUser_VO {

	private String userId;
	private String password;
	private String nickName;
	private String myTag;
	private String profileImg = "null.png";
	private String myComment;
	private String roomList = "";
	private int roomCnt = 0;
	
	public HcUser_VO() {
	}

	public HcUser_VO(String userId, String password, String nickName, String myTag, String profileImg, String myComment,
			String roomList, int roomCnt) {
		super();
		this.userId = userId;
		this.password = password;
		this.nickName = nickName;
		this.myTag = myTag;
		this.profileImg = profileImg;
		this.myComment = myComment;
		this.roomList = roomList;
		this.roomCnt = roomCnt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getMyTag() {
		return myTag;
	}

	public void setMyTag(String myTag) {
		this.myTag = myTag;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getMyComment() {
		return myComment;
	}

	public void setMyComment(String myComment) {
		this.myComment = myComment;
	}

	public String getRoomList() {
		return roomList;
	}

	public void setRoomList(String roomList) {
		this.roomList = roomList;
	}

	public int getRoomCnt() {
		return roomCnt;
	}

	public void setRoomCnt(int roomCnt) {
		this.roomCnt = roomCnt;
	}

	@Override
	public String toString() {
		return "HcUser_VO [userId=" + userId + ", password=" + password + ", nickName=" + nickName + ", myTag=" + myTag
				+ ", profileImg=" + profileImg + ", myComment=" + myComment + ", roomList=" + roomList + ", roomCnt="
				+ roomCnt + "]";
	}

}
