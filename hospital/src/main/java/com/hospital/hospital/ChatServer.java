package com.hospital.hospital;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


//endpoint : 커뮤니케이션채널의 한쪽 끝을 의미하는 단어
//@ServerEndpoint 을 설정해서 웹소켓 요청을 받는 서버쪽 endpoint를 만든다.
//에플리케이션 배포 시 @ServerEndpoint 에 지정된 주소로 서버의 endpoint 접근가능.

@ServerEndpoint("/chatserver")   // 웹소켓 endpoint 경로
public class ChatServer {
	
	// 웹소켓 session과 http session은 다른 것 임. 
	
	// 현재 채팅 서버에 접속한 클라이언트(WebSocket Session) 목록
	// static 붙여야함!!
	private static List<Session> list = new ArrayList<Session>();
	
	private void print(String msg) {
		System.out.printf("[%tT] %s\n", Calendar.getInstance(), msg);
	}
	// %t는 날짜형 의미
	// %t ( T-시간전부, H-시간, M-분, S-초, p -오전오후, L - 1000/1초, N-10억/1초, z -타임존)

	
	
//	웹소켓 연결이 구성되면, Session(Session 인스턴스는 웹소켓이 닫히기 전까지 유효)이 생성되고 
//  @OnOpen 어노테이션이 붙은 메소드가 호출된다. 	
	@OnOpen
	public void handleOpen(Session session) {
		print("클라이언트 연결");
		list.add(session); // 접속자 관리(****)
	}

	
//	웹소켓 endpoint가 메시지를 수신하면 @OnMessage 어노테이션이 붙은 매서드가 호출 된다.	
	@OnMessage
	public void handleMessage(String msg, Session session) {
		
		// 로그인할 때: 1#유저명
		// 대화  할 때: 2유저명#메세지	
		int index = msg.indexOf("#", 2);
		String no = msg.substring(0, 1);	// 메세지종류(1접속/2대화/3종료)
		String user = msg.substring(2, index);
		String txt = msg.substring(index + 1);
		
		if (no.equals("1")) {
			// 누군가 접속 > 1#아무개
			for (Session s : list) { // 현재 접속자가 아닌 나머지 사람들
				if (s != session) { 
					
					try {
						s.getBasicRemote().sendText("1#" + user + "#");
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
			}
			
		} else if (no.equals("2")) {
			// 누군가 메세지를 전송 > 2#아무개
			for (Session s : list) {
				
				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
					try {
						s.getBasicRemote().sendText("2#" + user + "#" + txt);
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
				
			} 
		} else if (no.equals("3")) {
			// 누군가 종료 > 3#아무개
			for (Session s : list) {
				
				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
					try {
						s.getBasicRemote().sendText("3#" + user + "#");
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				
			}
			list.remove(session);
		}
		
	}
	
	@OnClose
	public void handleClose() {
		
	}
	
	@OnError
	public void handleError(Throwable t) {
		
	}

}