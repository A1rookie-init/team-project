package com.hobbychat.mybatis;

import java.util.ArrayList;
import java.util.HashMap;

import com.hobbychat.vo.HcChatRoom_List;
import com.hobbychat.vo.HcChatRoom_VO;
import com.hobbychat.vo.HcMsg_VO;
import com.hobbychat.vo.HcUser_VO;


public interface MyBatisDAO {


// < Home 페이지 >

	// userVO 조회
	HcUser_VO selectUser(String userId);

	// 참여중인 채팅방 리스트 조회
	ArrayList<HcChatRoom_VO> selectRoomListByUserId(String userId);

	// 채팅방VO 조회
	HcChatRoom_VO selectRoom(String roomId);

	// 채팅방의 새메세지 개수 조회
	int selectCountNewMsg(HashMap<String, String> hmap);
	
	
	
// < 방검색 페이지 >
	
	int selectCountChatRoomList_rName(String item);
	int selectCountChatRoomList_rTag(String item);

	ArrayList<HcChatRoom_VO> selectChatRoomListByRName(HcChatRoom_List chatRoomList);
	ArrayList<HcChatRoom_VO> selectChatRoomListByRTag(HcChatRoom_List chatRoomList);

// < 방 입장 >
	void updateRoomUser(HashMap<String, String> hmap);

	
// < 채팅방 페이지 >
	
	// 채팅방의 대화 목록 조회
	ArrayList<HcMsg_VO> selectMsgList(String roomId);
	
	// 새메세지(안읽은 메세지) -> 읽은 메세지로 변경
	void updateMsgUnread(HashMap<String, String> hmap);
	
	// 유저아이디로 유저의 프로필이미지 조회
	String selectUserImg(String userId);
	
	// 메세지에 발신한 유저의 프로필이미지 담기
	void updateMsgImg(HashMap<String, String> hmap);
	
	// 메세지 전송 시, DB에 insert
	void insertMsg(HcMsg_VO msgVO);

	// 방에서 퇴장하기 (참여자에서 제거)
	void updateRoomUserExit(HcChatRoom_VO chatRoomVO);
	
	
	
// < 마이페이지 >
	// 유저 수정하기
	void updateUser(HcUser_VO hcUser_VO);

	
// < 방 생성 페이지 >
	
	// 방이름으로 방 개수 조회
	int selectCountRoomByRName(String roomName);

	// 방 생성 요청 
	void insertRoom(HcChatRoom_VO hcChatRoom_VO);


// < 회원 가입 >
	
	// < 아이디 중복 검사를 위한 아이디 조회 >
	int selectCountId(String userId);

	// < 닉네임 중복 검사를 위한 아이디 조회 >
	int selectCountNickName(String nickName);
	
	// < 회원 가입 완료 >
	void insertUser(HcUser_VO hcUser_VO);



	
	




	

	
	
	


}
