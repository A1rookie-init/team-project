package com.hospital.hospital;


import java.util.Arrays;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.Employee_20VO;
import com.hospital.vo.Patient_1VO;

public class EchoHandler extends TextWebSocketHandler{

	@Autowired
	private SqlSession sqlSession;
	
	// 로그인 중인 전체유저
	Map<String, WebSocketSession> usersAll = new ConcurrentHashMap<String, WebSocketSession>();
	
	// 로그인 중인 팀유저
	Map<String, WebSocketSession> usersA = new ConcurrentHashMap<String, WebSocketSession>();
	Map<String, WebSocketSession> usersP = new ConcurrentHashMap<String, WebSocketSession>();
	Map<String, WebSocketSession> usersD_a = new ConcurrentHashMap<String, WebSocketSession>();
	Map<String, WebSocketSession> usersD_b = new ConcurrentHashMap<String, WebSocketSession>();
	Map<String, WebSocketSession> usersD_c = new ConcurrentHashMap<String, WebSocketSession>();
	Map<String, WebSocketSession> usersN_a = new ConcurrentHashMap<String, WebSocketSession>();
	Map<String, WebSocketSession> usersN_b = new ConcurrentHashMap<String, WebSocketSession>();
	Map<String, WebSocketSession> usersN_c = new ConcurrentHashMap<String, WebSocketSession>();

	
	// 클라이언트가 서버로 연결시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		putMemberId(session);
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		String msgLogin = "loginList";
		
		Employee_20VO employeeVO = null;
		
		for(String userId : usersAll.keySet()) {
			employeeVO = mapper.selectEmployee(Integer.parseInt(userId));
			msgLogin += "<li><a href=''>" + employeeVO.getEmployeeIdx() + " " + employeeVO.getName() + " " + employeeVO.getDpart() +"</a></li>";
		}
		
		TextMessage tmpMsg = new TextMessage(msgLogin);
		
		WebSocketSession targetSession = null;
        for(String recieverId : usersAll.keySet()) {
        	targetSession = usersAll.get(recieverId);
        	targetSession.sendMessage(tmpMsg);
        } 
	}
	
	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		// 특정 유저에게 보내기
		String msg = message.getPayload();
		
		if(msg != null) {
			String[] strs = msg.split(",");
			log(Arrays.toString(strs));
			
			if(strs != null) {
				String dpart = strs[0].trim();
				String target = strs[1].trim();  // 받는이
				String ptIdx = strs[2].trim();
				String ptName = strs[3].trim();
				String content = strs[4].trim();
				String dDay = strs[5].trim();
				
				TextMessage tmpMsg2 = new TextMessage("<a style='color: black; text-decoration: none;' "
						+ "href='#'><b>[전체공지]</b> "
						+ " " + content + "  From <strong>" + dpart + "</strong></a>");
				
				TextMessage tmpMsg3 = new TextMessage("<a style='color: black; text-decoration: none;' "
						+ "href='chatAction'><b>[채팅초대]</b> "
						+ "  From <strong>" + dpart + "</strong></a>");
				
				TextMessage tmpMsg4 = new TextMessage("<a style='color: black; text-decoration: none;' "
						+ "href='#'><b>[팀공지]</b> "
						+ " " + content + "  From <strong>" + dpart + "</strong></a>");
				
				
				WebSocketSession targetSession = null;
				
//				관리자모드에서 실시간공지 (전체공지) : 실시간접속자 전체
				if (target.equals("All")) {
			        for(String recieverId : usersAll.keySet()) {
			        	targetSession = usersAll.get(recieverId);
			        	targetSession.sendMessage(tmpMsg2);
			        } 
//			    관리자모드에서 실시간공지 (팀공지) : 실시간접속자 중 해당팀
				} else if (dpart.equals("관리자")) {
					
//					공지보낼 팀
					switch(ptName) {
						case "A" :
					        for(String recieverId : usersA.keySet()) {
					        	targetSession = usersA.get(recieverId);
					        	targetSession.sendMessage(tmpMsg4);
					        }
							break;
						case "P" :
							for(String recieverId : usersP.keySet()) {
								targetSession = usersP.get(recieverId);
								targetSession.sendMessage(tmpMsg4);
							}
							break;
						case "DA" :
								for(String recieverId : usersD_a.keySet()) {
									targetSession = usersD_a.get(recieverId);
									targetSession.sendMessage(tmpMsg4);
								}
								break;  
						case "DB":
							for(String recieverId : usersD_b.keySet()) {
								targetSession = usersD_b.get(recieverId);
								targetSession.sendMessage(tmpMsg4);
							}
							break;  
						case "DC":
							for(String recieverId : usersD_c.keySet()) {
								targetSession = usersD_c.get(recieverId);
								targetSession.sendMessage(tmpMsg4);
							}
							break;  
						case "NA":
							for(String recieverId : usersN_a.keySet()) {
								targetSession = usersN_a.get(recieverId);
								targetSession.sendMessage(tmpMsg4);
							}
							break;  
						case "NB":
							for(String recieverId : usersN_b.keySet()) {
								targetSession = usersN_b.get(recieverId);
								targetSession.sendMessage(tmpMsg4);
							}
							break;  
						default:
							for(String recieverId : usersN_c.keySet()) {
								targetSession = usersN_c.get(recieverId);
								targetSession.sendMessage(tmpMsg4);
							}
							break;  
					}
					
//				채팅초대 : 해당하는 팀원 모두에게 발송					
				} else if (content.equals("채팅초대")) {
					switch(ptName) {
						case "A" :
					        for(String recieverId : usersA.keySet()) {
					        	targetSession = usersA.get(recieverId);
					        	targetSession.sendMessage(tmpMsg3);
					        }
							break;
						case "P" :
							for(String recieverId : usersP.keySet()) {
								targetSession = usersP.get(recieverId);
								targetSession.sendMessage(tmpMsg3);
							}
							break;
						case "DA" :
							for(String recieverId : usersD_a.keySet()) {
								targetSession = usersD_a.get(recieverId);
								targetSession.sendMessage(tmpMsg3);
							}
							break;  
						case "DB":
							for(String recieverId : usersD_b.keySet()) {
								targetSession = usersD_b.get(recieverId);
								targetSession.sendMessage(tmpMsg3);
							}
							break;  
						case "DC":
							for(String recieverId : usersD_c.keySet()) {
								targetSession = usersD_c.get(recieverId);
								targetSession.sendMessage(tmpMsg3);
							}
							break;  
						case "NA":
							for(String recieverId : usersN_a.keySet()) {
								targetSession = usersN_a.get(recieverId);
								targetSession.sendMessage(tmpMsg3);
							}
							break;  
						case "NB":
							for(String recieverId : usersN_b.keySet()) {
								targetSession = usersN_b.get(recieverId);
								targetSession.sendMessage(tmpMsg3);
							}
							break;  
						default:
							for(String recieverId : usersN_c.keySet()) {
								targetSession = usersN_c.get(recieverId);
								targetSession.sendMessage(tmpMsg3);
							}
							break;  
					}
				} else {
				
					MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
					Patient_1VO patientVO = mapper.selectPatient(Integer.parseInt(ptIdx));
					String doctorT = patientVO.getDoctorT();
					String nurseT = patientVO.getNurseT();
					
					String href = "";
					String tmpMsgContent = "";
					TextMessage tmpMsg = null;
	
//					실시간 접속 중인 해당 팀의 전 인원에게 알림 발송 (쪽지클릭시 업무페이지연결)
					switch(target) {
						case "A" :
							href = "viewAccept";
							tmpMsgContent = "<a style='color: black; text-decoration: none;' "
									+ "href='" + href + "?patientIdx="+ptIdx+"&dDay="+dDay+"'><b>["+content+"]</b> "+ptIdx 
									+ " " + ptName + "  From <strong>" + dpart + "</strong></a>";
							tmpMsg = new TextMessage(tmpMsgContent);
					        for(String recieverId : usersA.keySet()) {
					        	targetSession = usersA.get(recieverId);
					        	targetSession.sendMessage(tmpMsg);
					        }
							break;
							
						case "P" :
							href = "viewTest";
							tmpMsgContent = "<a style='color: black; text-decoration: none;' "
									+ "href='" + href + "?patientIdx="+ptIdx+"&dDay="+dDay+"'><b>["+content+"]</b> "+ptIdx 
									+ " " + ptName + "  From <strong>" + dpart + "</strong></a>";
							tmpMsg = new TextMessage(tmpMsgContent);
							for(String recieverId : usersP.keySet()) {
								targetSession = usersP.get(recieverId);
								targetSession.sendMessage(tmpMsg);
							}
							break;
							
						case "D" :
							href = "viewPatientDetail";
							tmpMsgContent = "<a style='color: black; text-decoration: none;' "
									+ "href='" + href + "?patientIdx="+ptIdx+"&dDay="+dDay+"'><b>["+content+"]</b> "+ptIdx 
									+ " " + ptName + "  From <strong>" + dpart + "</strong></a>";
							tmpMsg = new TextMessage(tmpMsgContent);
							switch(doctorT) {
								case "A":
									for(String recieverId : usersD_a.keySet()) {
										targetSession = usersD_a.get(recieverId);
										targetSession.sendMessage(tmpMsg);
									}
									break;  
								case "B":
									for(String recieverId : usersD_b.keySet()) {
										targetSession = usersD_b.get(recieverId);
										targetSession.sendMessage(tmpMsg);
									}
									break;  
								default:
									for(String recieverId : usersD_c.keySet()) {
										targetSession = usersD_c.get(recieverId);
										targetSession.sendMessage(tmpMsg);
									}
									break;  
							}
							break;
							
						default : // 간호사 
							href = "viewNursing";
							tmpMsgContent = "<a style='color: black; text-decoration: none;' "
									+ "href='" + href + "?patientIdx="+ptIdx+"&dDay="+dDay+"'><b>["+content+"]</b> "+ptIdx 
									+ " " + ptName + "  From <strong>" + dpart + "</strong></a>";
							tmpMsg = new TextMessage(tmpMsgContent);
							switch(nurseT) {
								case "A":
									for(String recieverId : usersN_a.keySet()) {
										targetSession = usersN_a.get(recieverId);
										targetSession.sendMessage(tmpMsg);
									}
									break;  
								case "B":
									for(String recieverId : usersN_b.keySet()) {
										targetSession = usersN_b.get(recieverId);
										targetSession.sendMessage(tmpMsg);
									}
									break;  
								default:
									for(String recieverId : usersN_c.keySet()) {
										targetSession = usersN_c.get(recieverId);
										targetSession.sendMessage(tmpMsg);
									}
									break;  
							}
							break;
					}
				}
			}
		}
	}
	
	// 연결 해제될 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		Map<String,Object> map = session.getAttributes();
		String userDpart = (String) map.get("dpart");
		String userId = (String) map.get("employeeIdx");
		
		if(userId!=null) {	// 로그인 값이 있는 경우만
			
			usersAll.remove(userId);	// 로그인중인 전체유저목록에서 삭제
			
			// 로그인중인 팀유저목록에서 삭제
			switch(userDpart) {
				case "원무과" :
					usersA.remove(userId);   
					log(userId + " 님 연결 종료");
					break;
				case "병리사" :
					usersP.remove(userId);
					log(userId + " 님 연결 종료");
					break;
				case "의사" :
					String doctorT = (String) map.get("doctorT");
					switch(doctorT) {
						case "A":
							usersD_a.remove(userId);
							log(userId + " 님 연결 종료");
							break;  
						case "B":
							usersD_b.remove(userId);
							log(userId + " 님 연결 종료");
							break;  
						default:
							usersD_c.remove(userId);
							log(userId + " 님 연결 종료");
							break;  
					}
					break;
				default :	// 간호사 		
					String nurseT = (String) map.get("nurseT");
					switch(nurseT) {
						case "A":
							usersN_a.remove(userId);
							log(userId + " 님 연결 종료");
							break;  
						case "B":
							usersN_b.remove(userId);
							log(userId + " 님 연결 종료");
							break;  
						default:
							usersN_c.remove(userId);
							log(userId + " 님 연결 종료");
							break;  
					}
					break;
			}
		
		}
		
		// 메인페이지 좌측에 나오는 실시간접속자 목록 업데이트 
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		String msgLogin = "loginList";
		
		Employee_20VO employeeVO = null;
		
		for(String userId2 : usersAll.keySet()) {
			employeeVO = mapper.selectEmployee(Integer.parseInt(userId2));
			msgLogin += "<li><a href=''>" + employeeVO.getEmployeeIdx() + " " + employeeVO.getName() + " " + employeeVO.getDpart() +"</a></li>";
		}
		
		TextMessage tmpMsg = new TextMessage(msgLogin);
		
		WebSocketSession targetSession = null;
        for(String recieverId : usersAll.keySet()) {
        	targetSession = usersAll.get(recieverId);
        	targetSession.sendMessage(tmpMsg);
        } 
		
	}
	
	// 에러 발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());

	}
	
	// 로그 메시지
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}
	
	// 웹소켓에 id 가져오기
    // 접속한 유저의 http세션을 조회하여 id를 얻는 함수	
	private String getMemberId(WebSocketSession session) {
		
		Map<String,Object> map = session.getAttributes();
		String userId = (String) map.get("employeeIdx");
		return userId == null ? null : userId;
	}
	private String getMemberDpart(WebSocketSession session) {
		
		Map<String,Object> map = session.getAttributes();
		String userDpart = (String) map.get("dpart");
		return userDpart == null ? null : userDpart;
	}
	
	private void putMemberId(WebSocketSession session) {
	
		Map<String,Object> map = session.getAttributes();
		String userDpart = (String) map.get("dpart");
		String userId = (String) map.get("employeeIdx");
		
		if(userId!=null) {	// 로그인 값이 있는 경우만
			
			usersAll.put(userId, session); // 로그인 중인 전체유저목록에 저장
			
			// 로그인 중인 팀유저목록에 저장
			switch(userDpart) {
				case "원무과":
					log(userId + " 님 연결 성공");
					usersA.put(userId, session);  
					break;
				case "병리사":
					log(userId + " 님 연결 성공");
					usersP.put(userId, session);   
					break;
				case "의사":
					String doctorT = (String) map.get("doctorT");
					switch(doctorT) {
						case "A":
							log(userId + " 님 연결 성공");
							usersD_a.put(userId, session);   
							break;  
						case "B":
							log(userId + " 님 연결 성공");
							usersD_b.put(userId, session);   
							break;  
						default:
							log(userId + " 님 연결 성공");
							usersD_c.put(userId, session);   
							break;  
					}
					break;
				default :	// 간호사 		
					String nurseT = (String) map.get("nurseT");
					switch(nurseT) {
						case "A":
							log(userId + " 님 연결 성공");
							usersN_a.put(userId, session);   
							break;  
						case "B":
							log(userId + " 님 연결 성공");
							usersN_b.put(userId, session);   
							break;  
						default:
							log(userId + " 님 연결 성공");
							usersN_c.put(userId, session);   
							break;  
					}
					break;
			}
		}
	}
	
}