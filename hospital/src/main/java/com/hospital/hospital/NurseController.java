package com.hospital.hospital;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.HandoverN_9List;
import com.hospital.vo.HandoverN_9VO;
import com.hospital.vo.Injection_11List;
import com.hospital.vo.NoticeToA_18VO;
import com.hospital.vo.NoticeToD_2VO;
import com.hospital.vo.NoticeToN_8List;
import com.hospital.vo.NoticeToP_14VO;
import com.hospital.vo.NursingComment_13VO;
import com.hospital.vo.NursingComment_13_List;
import com.hospital.vo.Patient_1List_All;
import com.hospital.vo.Patient_1List_My;
import com.hospital.vo.Patient_1VO;
import com.hospital.vo.PrescriptionMed_4List;
import com.hospital.vo.VitalSign_10List;
import com.hospital.vo.VitalSign_10VO;


@Controller
public class NurseController {
	
	private static final Logger logger = LoggerFactory.getLogger(NurseController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	// 간호사 메인페이지		
	@RequestMapping("/viewMainN")
	public String viewMainN(HttpServletRequest request, Model model) {
		logger.info("viewMainN()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
		
		// 간호사 업무 알림 리스트
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		String nurseT = (String) session.getAttribute("nurseT");
		NoticeToN_8List noticeToNList = ctx.getBean("noticeToNList", NoticeToN_8List.class);
		noticeToNList.setNoticeToNList(mapper.selectNoticeToNList(nurseT));
		model.addAttribute("noticeToNList", noticeToNList);
		
		// 간호사 업무인계 리스트
		HandoverN_9List handoverNList = ctx.getBean("handoverNList", HandoverN_9List.class);
		handoverNList.setHandoverNList(mapper.selectHandoverNList(nurseT));
		model.addAttribute("handoverNList", handoverNList);
		
		// 재원환자 리스트
		ArrayList<Patient_1VO> patientList = new ArrayList<Patient_1VO>();
		patientList.addAll(mapper.selectPatientList_All());
		
		//	디데이 넣는 코드
		for (int i = 0; i < patientList.size(); i++) {
			patientList.get(i).dayCount();
			patientList.get(i).setdDay(patientList.get(i).getdDay());
		}
		
		Patient_1List_All patient_1List_All = ctx.getBean("patient_1List_All", Patient_1List_All.class);
		patient_1List_All.setPatient_1List_All(patientList);
		model.addAttribute("patient_1List_All", patient_1List_All);
		
		// 담당환자 리스트
		Patient_1List_My patient_1List_My = ctx.getBean("patient_1List_My", Patient_1List_My.class);
		ArrayList<Patient_1VO> patientNList = mapper.selectPatientList_Nurse(nurseT);
		
//				디데이 넣는 코드
		for (int i = 0; i < patientNList.size(); i++) {
			patientNList.get(i).dayCount();
			patientNList.get(i).setdDay(patientNList.get(i).getdDay());
		}
		patient_1List_My.setPatient_1List_My(patientNList);
		model.addAttribute("patient_1List_My", patient_1List_My);
		

		return "viewMainN";
		
	}
	
	// 업무 인계 삽입
	@RequestMapping("/insertHandoverN")
	public String insertHandoverN(HttpServletRequest request, Model model, HandoverN_9VO handoverNVO, HttpServletResponse response) {
		logger.info("insertHandoverN()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int employeeIdx = Integer.parseInt(request.getParameter("employeeIdx"));
		String fromName = request.getParameter("fromName");
		String commentN = request.getParameter("commentN");
		String fromDT = request.getParameter("fromDT");
		int lev = Integer.parseInt(request.getParameter("lev"));
		int gup = Integer.parseInt(request.getParameter("gup"));
		
		handoverNVO.setCommentN(commentN);
		handoverNVO.setEmployeeIdx(employeeIdx);
		handoverNVO.setFromDT(fromDT);
		handoverNVO.setFromName(fromName);
		handoverNVO.setGup(gup);
		handoverNVO.setLev(lev);
		
		if (commentN == null || commentN.equals("")) {
			Alert.alertAndRedirect(response, "내용을 입력하세요", "viewMainN");
		}
		
		if (lev == 0) {
			mapper.insertHandoverN_new(handoverNVO);
		} else {
			mapper.insertHandoverN_reply(handoverNVO);
		}
		return "redirect:viewMainN";
	}
	
	// 업무 인계 삭제
	@RequestMapping("/handoverNdeleteOK")
	public String handoverNdeleteOK(HttpServletRequest request, Model model, HandoverN_9VO handoverNVO, HttpServletResponse response) {
		logger.info("handoverNdeleteOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		int idx = Integer.parseInt(request.getParameter("idx"));
		mapper.deleteNhandover(idx);
		Alert.alertAndRedirect(response, "업무 인계 삭제 완료!", "viewMainN");
		return "redirect:viewMainN";
	}
	
	// 업무 인계 수정
	@RequestMapping("/handoverNupdateOK")
	public String handoverNupdateOK(HttpServletRequest request, Model model, HandoverN_9VO handoverNVO, HttpServletResponse response) {
		logger.info("handoverNupdateOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		String commentN = request.getParameter("commentN");
		
		if (commentN == null || commentN.equals("")) {
			Alert.alertAndRedirect(response, "수정할 내용을 입력하세요", "viewMainN");
		}
		mapper.updateNhandover(handoverNVO);
		Alert.alertAndRedirect(response, "업무 인계 수정 완료!", "viewMainN");
		return "redirect:viewMainN";
	}
	
	@RequestMapping("/viewNursing")
	public String viewNursing(HttpServletRequest request, Model model) {
		logger.info("컨트롤러의 viewNursing()메소드 실행");
		
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		request.setAttribute("patientVO", patientVO);
		
	// 활력징후 		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		VitalSign_10List vitalSignList = ctx.getBean("vitalSignList", VitalSign_10List.class);
		vitalSignList.setVitalSignList(mapper.selectVitalSignList(patientIdx));
		model.addAttribute("vitalSignList", vitalSignList);
		
	// 간호투약
		
		Injection_11List injectionList = ctx.getBean("injectionList", Injection_11List.class);
		injectionList.setInjectionList(mapper.selectInjectionList(patientIdx));
		model.addAttribute("injectionList", injectionList);

	// 간호기록	
		NursingComment_13_List nursingCommentList = ctx.getBean("nursingCommentList", NursingComment_13_List.class);
		nursingCommentList.setNursingCommentList(mapper.selectNursingCommentList(patientIdx));
		model.addAttribute("nursingCommentList", nursingCommentList);
	
		return "/nurse/viewNursing";
	}
	
	@RequestMapping("/insertNursing")
	public String insertNursing(HttpServletRequest request, Model model, VitalSign_10VO vitalSign_10VO, NoticeToP_14VO noticeToP_14VO, NursingComment_13VO nursingComment_13VO) {
		logger.info("컨트롤러의 insertNursing()메소드 실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		if (request.getParameter("vitalTime") != null) {
			mapper.insertVital(vitalSign_10VO);
// 검사의뢰알림 (구버젼) -----------------------------------------------------		
		} else if(request.getParameter("test") != null) {
			if (request.getParameter("test").equals("blood")) {
				noticeToP_14VO.setAlarmP("혈액검사의뢰");
			} else {
				noticeToP_14VO.setAlarmP("소변검사의뢰");
			}
			noticeToP_14VO.setFromDP("간호사");
			mapper.insertNoticeToP(noticeToP_14VO);
// ----------------------------------------------------------------------------			
		} else if (request.getParameter("recordN") != null) {
			mapper.insertNursingComment(nursingComment_13VO);
		} else {
			model.addAttribute("blank", true); 		
		}
		model.addAttribute("patientIdx", request.getParameter("patientIdx"));
		model.addAttribute("dDay", request.getParameter("dDay"));
		
		return "/nurse/alertInsertNursing";
	}

// 검사의뢰알림 (ajax버젼)
	@RequestMapping("/insertNoticeToPFromN")
	@ResponseBody
	public String insertNoticeToPFromN(HttpServletRequest request, NoticeToP_14VO noticeToP_14VO) {
		logger.info("컨트롤러의 insertNoticeToPFromN()메소드 실행");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.insertNoticeToP(noticeToP_14VO);
		return "insert into DB : success";
	}
	
	
	@RequestMapping("/updateNursingInject")
	public String updateNursingInject(HttpServletRequest request, Model model) {
		logger.info("컨트롤러의 updateNursingInject()메소드 실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int time = Integer.parseInt(request.getParameter("time"));
		
		String realTime = null;
		
		switch (time) {
			case 90:
				realTime = "9A";
				mapper.updateInjection9Y(idx);
				break;
			case 91:
				realTime = "9A";
				mapper.updateInjection9N(idx);
				break;
			case 130:
				realTime = "1P";
				mapper.updateInjection13Y(idx);
				break;
			case 131:
				realTime = "1P";
				mapper.updateInjection13N(idx);
				break;
			case 180:
				realTime = "6P";
				mapper.updateInjection18Y(idx);
				break;
			case 181:
				realTime = "6P";
				mapper.updateInjection18N(idx);
				break;
			case 210:
				realTime = "9P";
				mapper.updateInjection21Y(idx);
				break;
			case 211:
				realTime = "9P";
				mapper.updateInjection21N(idx);
				break;
		}
		
		model.addAttribute("realTime", realTime);
		System.out.println("이거다 : " + realTime);
		model.addAttribute("patientIdx", request.getParameter("patientIdx"));
		model.addAttribute("dDay", request.getParameter("dDay"));
		
		return "/nurse/alertUpdateNursing";
	}
	
	@RequestMapping("/updateNursingComment")
	public String updateNursingComment(HttpServletRequest request, Model model, NursingComment_13VO nursingComment_13VO) {
		logger.info("컨트롤러의 updateNursingComment()메소드 실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.updateNursingComment(nursingComment_13VO);
		model.addAttribute("dDay", request.getParameter("dDay"));
		return "/nurse/alertUpdateNursing";
	}
	@RequestMapping("/deleteNursingVital")
	public String deleteNursingVital(HttpServletRequest request, Model model) {
		logger.info("컨트롤러의 deleteNursingVital()메소드 실행");
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		mapper.deleteNursingVital(idx);
		
		model.addAttribute("vitalTime", request.getParameter("vitalTime"));
		model.addAttribute("patientIdx", request.getParameter("patientIdx"));		
		model.addAttribute("dDay", request.getParameter("dDay"));
		
		return "/nurse/alertDeleteNursing";
	}
	@RequestMapping("/deleteNursingComment")
	public String deleteNursingComment(HttpServletRequest request, Model model) {
		logger.info("컨트롤러의 deleteNursingComment()메소드 실행");
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		mapper.deleteNursingComment(idx);
		
		model.addAttribute("cIdx", idx);
		model.addAttribute("patientIdx", request.getParameter("patientIdx"));		
		model.addAttribute("dDay", request.getParameter("dDay"));
		
		return "/nurse/alertDeleteNursing";
	}
	
//	환자이상보고 알림 발송 (구버젼) 	
	@RequestMapping("/insertNoticeToDFromN")
	public String insertNoticeToDFromN(HttpServletRequest request, Model model, NoticeToD_2VO noticeToD_2VO) {
		logger.info("Nurse 컨트롤러의 insertNoticeToDFromN()메소드 실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		noticeToD_2VO.setAlarmD("환자이상");
		noticeToD_2VO.setFromDP("간호사");
		
		mapper.insertNoticeToDFromN(noticeToD_2VO);
		
		model.addAttribute("patientIdx", request.getParameter("patientIdx"));		
		model.addAttribute("dDay", request.getParameter("dDay"));
		
		return "/nurse/alertInsertNursing";
	}

//	환자이상보고 알림 발송 ajax 버젼
	@RequestMapping("/insertNoticeToDPtEvent")
	@ResponseBody
	public String insertNoticeToDPtEvent(HttpServletRequest request, Model model, NoticeToD_2VO noticeToD_2VO) {
		logger.info("Nurse 컨트롤러의 insertNoticeToDPtEvent()메소드 실행");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		mapper.insertNoticeToDFromN(noticeToD_2VO);
		return "insert into DB : success";
	}	
	

	
//	< 퇴원간호 페이지 >
	@RequestMapping("/viewDisNursing")
	public String viewDisNursing(HttpServletRequest request, Model model) {
		logger.info("Nurse 컨트롤러의 viewDisNursing()메소드 실행");
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		
		model.addAttribute("patientVO", patientVO);
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);

//		퇴원약처방 리스트
		PrescriptionMed_4List prescriptionMedList = ctx.getBean("prescriptionMedList", PrescriptionMed_4List.class);
		prescriptionMedList.setPrescriptionMedList(mapper.selectPrescriptionMedList(patientIdx));
		
		model.addAttribute("prescriptionMedList", prescriptionMedList);
		model.addAttribute("patientIdx", request.getParameter("patientIdx"));		
		model.addAttribute("dDay", request.getParameter("dDay"));
		
		return "/nurse/viewDisNursing";
	}

//	퇴원간호 페이지 : 원무과에게 퇴원수속 알림 (구버젼)
	@RequestMapping("/insertNoticeToA")
	public String insertNoticeToA(HttpServletRequest request, Model model, NoticeToA_18VO noticeToA_18VO) {
		logger.info("Nurse 컨트롤러의 insertNoticeToA()메소드 실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		noticeToA_18VO.setAlarmA("퇴원수속");
		noticeToA_18VO.setFromDP("간호사");
		
		mapper.insertNoticeToA(noticeToA_18VO);
		
		model.addAttribute("patientIdx", request.getParameter("patientIdx"));		
		model.addAttribute("dDay", request.getParameter("dDay"));
		
		return "/nurse/alertInsertNursing";
	}
	
//	퇴원간호 페이지 : 원무과에게 퇴원수속 알림 (ajax버젼)
	@RequestMapping("/insertNoticeToAAjax")
	@ResponseBody
	public String insertNoticeToAAjax(HttpServletRequest request, Model model, NoticeToA_18VO noticeToA_18VO) {
		logger.info("Nurse 컨트롤러의 insertNoticeToAAjax()메소드 실행");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		mapper.insertNoticeToA(noticeToA_18VO);
		return "insert into DB : success";
	}

}
