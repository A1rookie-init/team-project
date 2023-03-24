package com.hospital.hospital;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.NoticeToA_18VO;
import com.hospital.vo.NoticeToD_2VO;
import com.hospital.vo.NoticeToN_8VO;
import com.hospital.vo.NoticeToP_14VO;
import com.hospital.vo.Patient_1VO;

@Controller
public class ChatController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/chatAction")
	public String chat() {
		
		logger.info("chat컨트롤러의 chatAction()실행");
		return "main/chat";
	}
	
	
	@RequestMapping("/inviteA")
	public String inviteA(HttpServletRequest request) {
		logger.info("chat컨트롤러의 inviteA()실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		HttpSession session = request.getSession();
		System.out.println(session.getAttribute("employeeIdx"));

		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		String fromDP = (String) session.getAttribute("dpart");
		String alarmA = "채팅방초대";
		String name = " ";
		int patientIdx = 0;
		
		NoticeToA_18VO noticeToAVO = ctx.getBean("noticeToAVO", NoticeToA_18VO.class);
		
		noticeToAVO.setAlarmA(alarmA);
		noticeToAVO.setEmployeeIdx(employeeIdx);
		noticeToAVO.setFromDP(fromDP);
		noticeToAVO.setFromName(fromName);
		noticeToAVO.setName(name);
		noticeToAVO.setPatientIdx(patientIdx);
		
		mapper.insertNoticeToA(noticeToAVO);
		return "main/chat";
		
	}
	
	@RequestMapping("/inviteNTeamA")
	public String inviteNTeamA(HttpSession session) {
		logger.info("chat컨트롤러의 inviteNTeamA()실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		// A팀 간호사 호출 
		Patient_1VO patientVO = mapper.selectRecentPatientByNTeam("A");
		
		// 메인페이지 간호사알림이 담당간호사팀을 기준으로 조회되는데, 간호사팀을 알림대상이된 환자에 등록된 정보에서
		// 빼오게 되어있다. 
		// 그래서 초대 시에도 환자idx가 존재해야 팀에 맞게 알림이 전송된다.
		
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		String fromDP = (String) session.getAttribute("dpart");
		String alarmN = "채팅방초대";
		String name = " ";
		int patientIdx = patientVO.getPatientIdx();
		
		NoticeToN_8VO noticeToNVO = ctx.getBean("noticeToNVO", NoticeToN_8VO.class);
		
		noticeToNVO.setAlarmN(alarmN);
		noticeToNVO.setEmployeeIdx(employeeIdx);
		noticeToNVO.setFromDP(fromDP);
		noticeToNVO.setFromName(fromName);
		noticeToNVO.setName(name);
		noticeToNVO.setPatientIdx(patientIdx);
		
		mapper.insertNoticeToN(noticeToNVO);
		return "main/chat";
	}
	@RequestMapping("/inviteNTeamB")
	public String inviteNTeamB(HttpSession session) {
		logger.info("chat컨트롤러의 inviteNTeamB()실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		// B팀 간호사 호출 
		Patient_1VO patientVO = mapper.selectRecentPatientByNTeam("B");
		
		// 메인페이지 간호사알림이 담당간호사팀을 기준으로 조회되는데, 간호사팀을 알림대상이된 환자에 등록된 정보에서
		// 빼오게 되어있다. 
		// 그래서 초대 시에도 환자idx가 존재해야 팀에 맞게 알림이 전송된다.
		
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		String fromDP = (String) session.getAttribute("dpart");
		String alarmN = "채팅방초대";
		String name = " ";
		int patientIdx = patientVO.getPatientIdx();
		
		NoticeToN_8VO noticeToNVO = ctx.getBean("noticeToNVO", NoticeToN_8VO.class);
		
		noticeToNVO.setAlarmN(alarmN);
		noticeToNVO.setEmployeeIdx(employeeIdx);
		noticeToNVO.setFromDP(fromDP);
		noticeToNVO.setFromName(fromName);
		noticeToNVO.setName(name);
		noticeToNVO.setPatientIdx(patientIdx);
		
		mapper.insertNoticeToN(noticeToNVO);
		return "main/chat";
	}
	@RequestMapping("/inviteNTeamC")
	public String inviteNTeamC(HttpSession session) {
		logger.info("chat컨트롤러의 inviteNTeamC()실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		// C팀 간호사 호출 
		Patient_1VO patientVO = mapper.selectRecentPatientByNTeam("C");
		
		// 메인페이지 간호사알림이 담당간호사팀을 기준으로 조회되는데, 간호사팀을 알림대상이된 환자에 등록된 정보에서
		// 빼오게 되어있다. 
		// 그래서 초대 시에도 환자idx가 존재해야 팀에 맞게 알림이 전송된다.
		
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		String fromDP = (String) session.getAttribute("dpart");
		String alarmN = "채팅방초대";
		String name = " ";
		int patientIdx = patientVO.getPatientIdx();
		
		NoticeToN_8VO noticeToNVO = ctx.getBean("noticeToNVO", NoticeToN_8VO.class);
		
		noticeToNVO.setAlarmN(alarmN);
		noticeToNVO.setEmployeeIdx(employeeIdx);
		noticeToNVO.setFromDP(fromDP);
		noticeToNVO.setFromName(fromName);
		noticeToNVO.setName(name);
		noticeToNVO.setPatientIdx(patientIdx);
		
		mapper.insertNoticeToN(noticeToNVO);
		return "main/chat";
	}
	
	@RequestMapping("/inviteDTeamA")
	public String inviteDTeamA(HttpSession session) {
		logger.info("chat컨트롤러의 inviteDTeamA()실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		// A팀 의사 호출 
		Patient_1VO patientVO = mapper.selectRecentPatientByDTeam("A");
		
		// 메인페이지 의사알림이 담당의사팀을 기준으로 조회되는데, 의사팀을 알림대상이된 환자에 등록된 정보에서
		// 빼오게 되어있다. 
		// 그래서 초대 시에도 환자idx가 존재해야 팀에 맞게 알림이 전송된다.
		
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		String fromDP = (String) session.getAttribute("dpart");
		String alarmD = "채팅방초대";
		String name = " ";
		int patientIdx = patientVO.getPatientIdx();
		
		NoticeToD_2VO noticeToDVO = ctx.getBean("noticeToDVO", NoticeToD_2VO.class);
		
		noticeToDVO.setAlarmD(alarmD);
		noticeToDVO.setEmployeeIdx(employeeIdx);
		noticeToDVO.setFromDP(fromDP);
		noticeToDVO.setFromName(fromName);
		noticeToDVO.setName(name);
		noticeToDVO.setPatientIdx(patientIdx);
		
		mapper.insertNoticeToD(noticeToDVO);
		return "main/chat";
	}
	
	@RequestMapping("/inviteDTeamB")
	public String inviteDTeamB(HttpSession session) {
		logger.info("chat컨트롤러의 inviteDTeamB()실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		// B팀 의사 호출 
		Patient_1VO patientVO = mapper.selectRecentPatientByDTeam("B");
		
		// 메인페이지 의사알림이 담당의사팀을 기준으로 조회되는데, 의사팀을 알림대상이된 환자에 등록된 정보에서
		// 빼오게 되어있다. 
		// 그래서 초대 시에도 환자idx가 존재해야 팀에 맞게 알림이 전송된다.
		
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		String fromDP = (String) session.getAttribute("dpart");
		String alarmD = "채팅방초대";
		String name = " ";
		int patientIdx = patientVO.getPatientIdx();
		
		NoticeToD_2VO noticeToDVO = ctx.getBean("noticeToDVO", NoticeToD_2VO.class);
		
		noticeToDVO.setAlarmD(alarmD);
		noticeToDVO.setEmployeeIdx(employeeIdx);
		noticeToDVO.setFromDP(fromDP);
		noticeToDVO.setFromName(fromName);
		noticeToDVO.setName(name);
		noticeToDVO.setPatientIdx(patientIdx);
		
		mapper.insertNoticeToD(noticeToDVO);
		return "main/chat";
	}
	
	@RequestMapping("/inviteDTeamC")
	public String inviteDTeamC(HttpSession session) {
		logger.info("chat컨트롤러의 inviteDTeamC()실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		// C팀 의사 호출 
		Patient_1VO patientVO = mapper.selectRecentPatientByDTeam("C");
		
		// 메인페이지 의사알림이 담당의사팀을 기준으로 조회되는데, 의사팀을 알림대상이된 환자에 등록된 정보에서
		// 빼오게 되어있다. 
		// 그래서 초대 시에도 환자idx가 존재해야 팀에 맞게 알림이 전송된다.
		
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		String fromDP = (String) session.getAttribute("dpart");
		String alarmD = "채팅방초대";
		String name = " ";
		int patientIdx = patientVO.getPatientIdx();
		
		NoticeToD_2VO noticeToDVO = ctx.getBean("noticeToDVO", NoticeToD_2VO.class);
		
		noticeToDVO.setAlarmD(alarmD);
		noticeToDVO.setEmployeeIdx(employeeIdx);
		noticeToDVO.setFromDP(fromDP);
		noticeToDVO.setFromName(fromName);
		noticeToDVO.setName(name);
		noticeToDVO.setPatientIdx(patientIdx);
		
		mapper.insertNoticeToD(noticeToDVO);
		return "main/chat";
	}
	
	@RequestMapping("/inviteP")
	public String inviteP(HttpSession session) {
		logger.info("chat컨트롤러의 inviteP()실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		String fromDP = (String) session.getAttribute("dpart");
		String alarmP = "채팅방초대";
		String name = " ";
		int patientIdx = 0;
		
		NoticeToP_14VO noticeToPVO = ctx.getBean("noticeToPVO", NoticeToP_14VO.class);
		
		noticeToPVO.setAlarmP(alarmP);
		noticeToPVO.setEmployeeIdx(employeeIdx);
		noticeToPVO.setFromDP(fromDP);
		noticeToPVO.setFromName(fromName);
		noticeToPVO.setName(name);
		noticeToPVO.setPatientIdx(patientIdx);
		System.out.println(fromName);
		mapper.insertNoticeToP(noticeToPVO);
		return "main/chat";
	}
		
	
	
	
		
		
}

