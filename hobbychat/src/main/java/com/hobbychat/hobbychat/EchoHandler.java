package com.hobbychat.hobbychat;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.hobbychat.mybatis.MyBatisDAO;
import com.hobbychat.vo.HcChatRoom_VO;
import com.hobbychat.vo.HcMsg_VO;
import com.hobbychat.vo.HcUser_VO;


public class EchoHandler extends TextWebSocketHandler{

	@Autowired
	private SqlSession sqlSession;
	
    // 채팅방 목록 <방 아이디, ArrayList<session> >이 들어간다.
    private Map<String, ArrayList<WebSocketSession>> roomList = new ConcurrentHashMap<String, ArrayList<WebSocketSession>>();
    
    // 세션 목록 <session, 방 아이디> 가 들어간다.
    private Map<WebSocketSession, String> sessionList = new ConcurrentHashMap<WebSocketSession, String>();
    
    // 로그인한 유저 목록 <userId, session> 
    private Map<String, WebSocketSession> userList = new ConcurrentHashMap<String, WebSocketSession>();
	
    
	// 웹 소켓 연결  (클라이언트가 서버로 연결 시)
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		// 입장한 유저의 웹소켓세션을 roomList, sessionList에 담기
		putUserIntoRoom(session);
		
		// 유저가 로그인해서 Home 페이지로 이동 시
		if(getRoomId(session) == null) {

// ## 추가하기!@@@@			
			
		// 유저가 대화방 접속 시 (단순히 참여가 아닌 실시간을 의미함)
		} else {
			
			// 해당 대화방에 실시간 접속중인 유저들 목록을 메세지로 전송한다.
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
			
			String roomId = getRoomId(session);
			HcUser_VO userVO = null;
			String userId = null;
			String msgConnect = "connectingList";
			
			for(WebSocketSession sess : roomList.get(roomId)) {
				userId = getUserId(sess);
				userVO = mapper.selectUser(userId);
				msgConnect += "<li class='list-group-item'>" + userVO.getNickName() + "</li>";
			}
			
			TextMessage tmpMsg = new TextMessage(msgConnect);
			
			for(WebSocketSession targetSession : roomList.get(roomId)) {
				targetSession.sendMessage(tmpMsg);
			} 
			
		}
		
	}
	
	
	// 서버가 메세지를 수신 시 (클라이언트=유저 가 Data 전송 시)
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		String msg = message.getPayload();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		if(msg != null) {
			
			int index = msg.indexOf("/");
			int lastIndex = msg.lastIndexOf("/");
			
			log(msg);
			
			String userId = msg.substring(0, index);
			String roomId = msg.substring(lastIndex + 1); 
			
			// 수신된 메세지가 유저가 채팅방에 접속했다는 알림일때
			if(userId.substring(index-1, index).equals("#")) {
				
				userId = msg.substring(0, index -1);
				int newMsg = Integer.parseInt((msg.substring(index + 1, lastIndex)));
				ArrayList<HcMsg_VO> msgList = mapper.selectMsgList(roomId);
				
				System.out.println("여기1");
				
				// 새메세지(읽지않은메세지)가 존재하면 -> 읽은메세지로 변경해주는 코드
				if (newMsg != msgList.size()) {
					
					int userIdSize = userId.length();
					int userIdIndex = 0;
					String unreadUser = "";
					HashMap<String, String> hmap = null;
					System.out.println("여기2");

					for (int i=0; i<msgList.size(); i++) {
						if (i >= newMsg) {
							System.out.println("여기3");

							hmap = new HashMap<String, String>();
							userIdIndex = msgList.get(i).getUnreadUser().indexOf(" " + userId + "/");
							System.out.println("유저인덱스 :" + userIdIndex);
							
							if (msgList.get(i).getUnreadUser().length() > (userIdIndex + userIdSize + 2)) {
								
								if (userIdIndex == 0) {
									unreadUser = msgList.get(i).getUnreadUser().substring(userIdIndex + userIdSize + 2);
								} else {
									unreadUser = msgList.get(i).getUnreadUser().substring(0, userIdIndex) 
											+ msgList.get(i).getUnreadUser().substring(userIdIndex + userIdSize + 2);
								}
							} 
								
							hmap.put("msgId", msgList.get(i).getMsgId());
							hmap.put("unreadUser", unreadUser);
							mapper.updateMsgUnread(hmap);
							
						}
					}
				} // 새메세지가 존재하지 않으면 바로 통과
				System.out.println("여기4");

				
			// 수신된 메세지가 대화메세지 일떄
			} else {
				System.out.println("여기5");

				String content = msg.substring(index + 1, lastIndex);
				HcUser_VO userVO = mapper.selectUser(userId);
				String nickName = userVO.getNickName();
				String profileImg = userVO.getProfileImg();
				
				HcChatRoom_VO chatRoomVO = mapper.selectRoom(roomId);
				int unread = chatRoomVO.getUserCnt() - roomList.get(roomId).size();
				String userOne = null;
				ArrayList<String> readUserList = new ArrayList<String>();
				
				// 안읽음 추가해야함 @@@@@@@
				TextMessage tmpMsg = new TextMessage(nickName + "/" + content + "/" + profileImg);
				
				for(WebSocketSession targetSession : roomList.get(roomId)) {
					userOne = getUserId(targetSession);
					readUserList.add(userOne);
					targetSession.sendMessage(tmpMsg);
				} 
				
				AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
				HcMsg_VO msgVO = ctx.getBean("msgVO", HcMsg_VO.class);
				
				
				String[] array = chatRoomVO.getUserList().split("/");
				String unreadUser = "";
				
				for (int i=0; i<array.length; i++) {
					if(!readUserList.contains(array[i].substring(1))) {
						unreadUser += " " + array[i].substring(1) + "/";
					} 
				}
				msgVO.setUserId(userId);
				msgVO.setNickName(nickName);
				msgVO.setRoomId(roomId);
				msgVO.setMsg(content);
				msgVO.setUnread(unread);
				msgVO.setUnreadUser(unreadUser);
				System.out.println(msgVO);
				mapper.insertMsg(msgVO);
			}
		}
	}
	
	// 웹 소켓 종료(클라이언트와 서버 연결 해제) : 유저 대화방 나갈 시 (더이상 참여하지 않는 완전한 퇴장 의미 아님.) 
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String,Object> map = session.getAttributes();
		
		String roomId = (String) map.get("roomId");
		String userId = (String) map.get("userId");
		
		if(userId!=null) {	
			
			roomList.get(roomId).remove(session);
			sessionList.remove(session);
			
			// 해당 대화방에 실시간 접속중인 유저들 목록을 메세지로 전송한다.
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
			HcUser_VO userVO = null;
			String yourId = null;
			String msgConnect = "connectingList";
			
			for(WebSocketSession sess : roomList.get(roomId)) {
				yourId = getUserId(sess);
				userVO = mapper.selectUser(yourId);
				msgConnect += "<li class='list-group-item'>" + userVO.getNickName() + "</li>";
			}
			
			TextMessage tmpMsg = new TextMessage(msgConnect);
			
			for(WebSocketSession targetSession : roomList.get(roomId)) {
	        	targetSession.sendMessage(tmpMsg);
	        }
			log(userId + " 님 연결 종료");
		}	
	}
	
	
	// 웹소켓 에러발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());

	}
	
	// log찍기
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}
	
	// 웹소켓세션으로 http세션정보-userId 찾는 함수
	private String getUserId(WebSocketSession session) {
		
		Map<String, Object> map = session.getAttributes();
		String userId = (String) map.get("userId");
		return userId == null ? null : userId;
	}
	
	// 웹소켓세션으로 http세션정보-roomId 찾는 함수
	private String getRoomId(WebSocketSession session) {
		
		Map<String,Object> map = session.getAttributes();
		String roomId = (String) map.get("roomId");
		return roomId == null ? null : roomId;
	}
	
	// 유저의 웹소켓세션 roomList, sessionList에 담기
	private void putUserIntoRoom(WebSocketSession session) {
	
		Map<String, Object> map = session.getAttributes();
		
		String userId = (String) map.get("userId");
		String roomId = (String) map.get("roomId");
		
		if(roomId != null) {
			sessionList.put(session, roomId);
			
			if(roomList.containsKey(roomId)) {
				roomList.get(roomId).add(session);
			} else {
				ArrayList<WebSocketSession> newRoom = new ArrayList<WebSocketSession>();
				newRoom.add(session);
				roomList.put(roomId, newRoom);
			}
		} else {
			userList.put(userId, session);
		}
		log(userId + " 님 연결 성공");
	}
	
	
	
	
	
	
	
	
	
	
	
}