package com.hobbychat.vo;

import java.util.Date;

public class HcMsg_VO {

	private String msgId;
	private String roomId;
	private String userId;
	private String nickName;
	private String msg;
	private Date writeDate;
	private int unread;
	private String unreadUser;
	private String profileImg = "null.png";
	
	public HcMsg_VO() {
	}
	
	public HcMsg_VO(String msgId, String roomId, String userId, String nickName, String msg, Date writeDate, int unread,
			String unreadUser, String profileImg) {
		super();
		this.msgId = msgId;
		this.roomId = roomId;
		this.userId = userId;
		this.nickName = nickName;
		this.msg = msg;
		this.writeDate = writeDate;
		this.unread = unread;
		this.unreadUser = unreadUser;
		this.profileImg = profileImg;
	}

	public String getMsgId() {
		return msgId;
	}
	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public int getUnread() {
		return unread;
	}
	public void setUnread(int unread) {
		this.unread = unread;
	}

	public String getUnreadUser() {
		return unreadUser;
	}

	public void setUnreadUser(String unreadUser) {
		this.unreadUser = unreadUser;
	}

	
	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	@Override
	public String toString() {
		return "HcMsg_VO [msgId=" + msgId + ", roomId=" + roomId + ", userId=" + userId + ", nickName=" + nickName
				+ ", msg=" + msg + ", writeDate=" + writeDate + ", unread=" + unread + ", unreadUser=" + unreadUser
				+ ", profileImg=" + profileImg + "]";
	}
	

}
