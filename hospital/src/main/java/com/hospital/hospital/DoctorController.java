package com.hospital.hospital;

import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.HandoverD_3List;
import com.hospital.vo.HandoverD_3VO;
import com.hospital.vo.MedicalComment_7List;
import com.hospital.vo.MedicalComment_7VO;
import com.hospital.vo.Medicine_22List;
import com.hospital.vo.Medicine_22VO;
import com.hospital.vo.NoticeToD_2List;
import com.hospital.vo.NoticeToN_8VO;
import com.hospital.vo.Patient_1List_All;
import com.hospital.vo.Patient_1List_My;
import com.hospital.vo.Patient_1VO;
import com.hospital.vo.PrescriptionMed_4List;
import com.hospital.vo.PrescriptionMed_4VO;
import com.hospital.vo.PrescriptionTest_5List;
import com.hospital.vo.PrescriptionTest_5VO;

@Controller
public class DoctorController {

	private static final Logger logger = LoggerFactory.getLogger(DoctorController.class);

	@Autowired
	private SqlSession sqlSession;
	
	// 의사 메인페이지		
	@RequestMapping("/viewMainDoctor")
	public String viewMainDoctor(HttpServletRequest request, Model model) {
		logger.info("viewMainDoctor()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();

		// 의사 업무 알림 리스트
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		String doctorT = (String) session.getAttribute("doctorT");
		NoticeToD_2List noticeToDList = ctx.getBean("noticeToDList", NoticeToD_2List.class);
		noticeToDList.setNoticeToDList(mapper.selectNoticeToDList(doctorT));
		model.addAttribute("noticeToDList", noticeToDList);
		
		// 의사 업무인계 리스트
		HandoverD_3List handoverDList = ctx.getBean("handoverDList", HandoverD_3List.class);
		handoverDList.setHandoverDList(mapper.selectHandoverDList(doctorT));
		model.addAttribute("handoverDList", handoverDList);
		
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
		ArrayList<Patient_1VO> patientDList = mapper.selectPatientList_Doctor(doctorT);
		
//				디데이 넣는 코드
		for (int i = 0; i < patientDList.size(); i++) {
			patientDList.get(i).dayCount();
			patientDList.get(i).setdDay(patientDList.get(i).getdDay());
		}
		
		patient_1List_My.setPatient_1List_My(patientDList);
		//logger.info(patient_1List_Doctor + " - patient_1List_Doctor");
		model.addAttribute("patient_1List_My", patient_1List_My);
			
		return "viewMainDoctor";
		
	}
	
	// 업무 인계 삽입
	@RequestMapping("/insertHandoverD")
	public String insertHandoverD(HttpServletRequest request, Model model, HandoverD_3VO handoverDVO, HttpServletResponse response) {
		logger.info("insertHandoverD()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int employeeIdx = Integer.parseInt(request.getParameter("employeeIdx"));
		String fromName = request.getParameter("fromName");
		String commentD = request.getParameter("commentD");
		String fromDT = request.getParameter("fromDT");
		int lev = Integer.parseInt(request.getParameter("lev"));
		int gup = Integer.parseInt(request.getParameter("gup"));
		
		handoverDVO.setCommentD(commentD);
		handoverDVO.setEmployeeIdx(employeeIdx);
		handoverDVO.setFromDT(fromDT);
		handoverDVO.setFromName(fromName);
		handoverDVO.setGup(gup);
		handoverDVO.setLev(lev);
		
		if (commentD == null || commentD.equals("")) {
			Alert.alertAndRedirect(response, "내용을 입력하세요", "viewMainDoctor");
		}
		
		if (lev == 0) {
			mapper.insertHandoverD_new(handoverDVO);
				
			} else {
				
			mapper.insertHandoverD_reply(handoverDVO);
			}
		
		
		return "redirect:viewMainDoctor";
		
	}
	
	
	// 업무 인계 삭제
	@RequestMapping("/handoverDdeleteOK")
	public String handoverDdeleteOK(HttpServletRequest request, Model model, HandoverD_3VO handoverDVO, HttpServletResponse response) {
		logger.info("handoverDdeleteOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		mapper.deletehandover(idx);			
		
		
		Alert.alertAndRedirect(response, "업무 인계 삭제 완료!", "viewMainDoctor");
		
		return "redirect:viewMainDoctor";
	}
	
	
	// 업무 인계 수정
	@RequestMapping("/handoverDupdateOK")
	public String handoverDupdateOK(HttpServletRequest request, Model model, HandoverD_3VO handoverDVO, HttpServletResponse response) {
		logger.info("handoverDupdateOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		String commentD = request.getParameter("commentD");
		
		if (commentD == null || commentD.equals("")) {
			Alert.alertAndRedirect(response, "수정할 내용을 입력하세요", "viewMainDoctor");
		}
		mapper.updatehandover(handoverDVO);
		
		Alert.alertAndRedirect(response, "업무 인계 수정 완료!", "viewMainDoctor");
		
		return "redirect:viewMainDoctor";
	}

	
	@RequestMapping("/viewMedical")
	public String viewMedical(HttpServletRequest request, Model model) {
		logger.info("컨트롤러의 viewMedical()메소드 실행");

		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		request.setAttribute("patientVO", patientVO);

		// 약 처방내역
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		PrescriptionMed_4List prescriptionMedList = ctx.getBean("prescriptionMedList", PrescriptionMed_4List.class);
		prescriptionMedList.setPrescriptionMedList(mapper.selectPrescriptionMedList(patientIdx));
		model.addAttribute("prescriptionMedList", prescriptionMedList);

		// 검사 처방내역
		PrescriptionTest_5List prescriptionTestList = ctx.getBean("prescriptionTestList", PrescriptionTest_5List.class);
		prescriptionTestList.setPrescriptionTestList(mapper.selectPrescriptionTestList(patientIdx));
		model.addAttribute("prescriptionTestList", prescriptionTestList);

		// 진료기록
		MedicalComment_7List medicalCommentList = ctx.getBean("medicalCommentList", MedicalComment_7List.class);
		medicalCommentList.setMedicalCommentList(mapper.selectMediCommentList(patientIdx));
		model.addAttribute("medicalCommentList", medicalCommentList);

		// 약검색
		if (request.getParameter("mediName") != null) {

			String mediName = request.getParameter("mediName");
			Medicine_22List medicineList = ctx.getBean("medicineList", Medicine_22List.class);
			medicineList.setMedicineList(mapper.selectMedicineListByName(mediName.trim()));
			model.addAttribute("medicineList", medicineList);
			model.addAttribute("mediSearch", "t");
		} else {
			model.addAttribute("mediSearch", "f");
		}

		// 약검색 후 약 선택
		if (request.getParameter("code") != null) {
			String code = request.getParameter("code");
			Medicine_22VO medicineVO = mapper.selectMedicineByCode(code);
			logger.info("{}", medicineVO);
			model.addAttribute("medicineVO", medicineVO);
			model.addAttribute("mediCode", "t");
		} else {
			model.addAttribute("mediCode", "f");
		}
		return "viewMedical";
	}


	//	약검색 하고 다시쓰기 클릭했을때 
	@RequestMapping("/resetMediSearch")
	public String resetMediSearch(HttpServletRequest request, Model model) {
		
		logger.info("resetMediSearch()");
		
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);

		return "redirect:viewMedical";
	}
	
	//	초진
	@RequestMapping("/updatePatient")
	public String updatePatient(HttpServletRequest request, Model model) {
		logger.info("updatePatient()");
		
//		정보를 꺼내올 환자의 번호 받기
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		request.setAttribute("patient_1vo", patientVO);
		request.setAttribute("dDay", dDay);
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);
		
		return "updatePatient";
	}
	
	//초진 입력 작업
		@RequestMapping("/updatePatientOK")
		public String updatePatientOK(HttpServletRequest request, Model model, NoticeToN_8VO noticeToNVO, HttpServletResponse response) throws IOException {
			logger.info("viewMedical()");
			
			HttpSession session = request.getSession();
			
//			정보를 꺼내올 환자의 번호 받기
			int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
			int dDay = Integer.parseInt(request.getParameter("dDay"));
			model.addAttribute("patientIdx", patientIdx);
			model.addAttribute("dDay", dDay);

			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
			Patient_1VO patientVO =  mapper.selectPatient(patientIdx);
			
			String allergy = "N";
			if (request.getParameter("allergy-detail") == null) {
				patientVO.setAllergy(allergy);
			} else {
				patientVO.setAllergy(request.getParameter("allergy-detail"));
			}
			patientVO.setCc(request.getParameter("cc"));
			patientVO.setPi(request.getParameter("pi"));
			patientVO.setHistroy(request.getParameter("histroy"));
			patientVO.setAlcohol(request.getParameter("alcohol"));
			patientVO.setSmoking(request.getParameter("smoking"));
			patientVO.setDiagnosis(request.getParameter("diagnosis"));
			patientVO.setCarePlan(request.getParameter("carePlan"));
			patientVO.setExDisDate(request.getParameter("exDisDate"));
			logger.info("{}", patientVO);
			
			mapper.updatePatient(patientVO);
			
/*	초진 후 간호사에게 알람(구버젼)		
			// 초진 후 간호사에게 알람 보내기\
			noticeToNVO.setAlarmN("초진완료");
			noticeToNVO.setFromDP((String)session.getAttribute("dpart"));
			noticeToNVO.setFromName((String)session.getAttribute("employeeName"));
			logger.info("{}", noticeToNVO);
			mapper.insertNoticeToN(noticeToNVO);
			
			// 알림창 띄우기
			Alert.alertAndGo(response, "To.간호사 " + patientVO.getName() + "님의 초진 등록 알림이 발송되었습니다.", "viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay);
	*/		
			return "redirect:viewMedical";
		}

		
// 초진환자 알림 (ajax버젼)
	@RequestMapping("/insertNoticeToNForNewAjax")
	@ResponseBody
	public String insertNoticeToNForNewAjax(NoticeToN_8VO noticeToN_8VO) {
		logger.info("컨트롤러의 insertNoticeToNForNewAjax()메소드 실행");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.insertNoticeToNFromD(noticeToN_8VO);
		return "insert into DB : success";
	}	
		
// 약물처방 등록 알림 (ajax버젼)
	@RequestMapping("/insertNoticeToNForMedAjax")
	@ResponseBody
	public String insertNoticeToNForMedAjax(NoticeToN_8VO noticeToN_8VO) {
		logger.info("컨트롤러의 insertNoticeToNForMedAjax()메소드 실행");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.insertNoticeToNFromD(noticeToN_8VO);
		return "insert into DB : success";
	}	
// 검사처방 등록 알림 (ajax버젼)
	@RequestMapping("/insertNoticeToNForTestAjax")
	@ResponseBody
	public String insertNoticeToNForTestAjax(NoticeToN_8VO noticeToN_8VO) {
		logger.info("컨트롤러의 insertNoticeToNForTestAjax()메소드 실행");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.insertNoticeToNFromD(noticeToN_8VO);
		return "insert into DB : success";
	}	
	
// 퇴원수속 알림 (ajax버젼)
	@RequestMapping("/insertNoticeToNForDisAjax")
	@ResponseBody
	public String insertNoticeToNForDisAjax(NoticeToN_8VO noticeToN_8VO) {
		logger.info("컨트롤러의 insertNoticeToNForDisAjax()메소드 실행");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.insertNoticeToNFromD(noticeToN_8VO);
		return "insert into DB : success";
	}	

	@RequestMapping("/insertMedical")
	public String insertMedical(HttpServletRequest request, HttpServletResponse response, Model model,
		   PrescriptionMed_4VO prescriptionMed_4VO, Patient_1VO patientVO, NoticeToN_8VO noticeToN_8VO,
		   MedicalComment_7VO medicalComment_7VO, PrescriptionTest_5VO prescriptionTest_5VO) throws IOException {
		
		HttpSession session = request.getSession();
		String employeeName = (String) session.getAttribute("employeeName");
		int employeeIdx = Integer.parseInt((String)session.getAttribute("employeeIdx")); // 이유불명의 에러로 string거쳐서 int로변환함.
		String dpart = (String) session.getAttribute("dpart");
		int patientIdx =  Integer.parseInt(request.getParameter("patientIdx"));
		request.setAttribute("patientIdx", patientIdx);
		
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		request.setAttribute("dDay", dDay);

		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);


		if (request.getParameter("mediName") != null) {

			String mediName = request.getParameter("mediName");
			if (mediName.trim().equals("")) {

				Alert.alertAndBack(response, "검색어를 입력해주세요.");
			}

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>location.href='viewMedical?patientIdx=" + patientIdx + "&mediName=" + mediName
					+ "&dDay=" + dDay + "'</script>");
			out.flush();

		} else if (request.getParameter("mediInsert") != null) {
			mapper.insertMediPreMed(prescriptionMed_4VO);
			mapper.insertInjection(prescriptionMed_4VO);
// 약물처방알림 (구버젼)------------------------------------------
/*
			noticeToN_8VO.setPatientIdx(patientIdx);
			noticeToN_8VO.setName(patientVO.getName());
			noticeToN_8VO.setEmployeeIdx(employeeIdx);
			noticeToN_8VO.setFromName(employeeName);
			noticeToN_8VO.setAlarmN("약물처방");
			
			mapper.insertNoticeToNFromD(noticeToN_8VO);
			Alert.alertAndAlertAndGo(response, prescriptionMed_4VO.getMedicine() + " 약물 처방이 등록되었습니다.", "To.간호사 " + patientVO.getName() + " 환자의 " + prescriptionMed_4VO.getMedicine() + "약물 처방 알림이 전송되었습니다.", "viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay);
*/
		} else if (request.getParameter("test") != null) {
			if (request.getParameter("test").equals("blood")) {
				prescriptionTest_5VO.setTest("혈액검사");
			} else {
				prescriptionTest_5VO.setTest("소변검사");
			}
			mapper.insertMediPreTest(prescriptionTest_5VO);

//			검사처방알림 (구버젼)
/*
			noticeToN_8VO.setPatientIdx(patientIdx);
			noticeToN_8VO.setName(patientVO.getName());
			noticeToN_8VO.setEmployeeIdx(employeeIdx);
			noticeToN_8VO.setFromName(employeeName);
			noticeToN_8VO.setAlarmN(prescriptionTest_5VO.getTest());
			mapper.insertNoticeToNFromD(noticeToN_8VO);
			
			Alert.alertAndAlertAndGo(response, prescriptionTest_5VO.getTest() + " 처방이 등록되었습니다.", "To.간호사 " + patientVO.getName() + " 환자의 " + prescriptionTest_5VO.getTest() + " 처방 알림이 전송되었습니다.", "viewMedical?patientIdx=" + prescriptionTest_5VO.getPatientIdx()+ "&dDay=" + dDay);
*/
		} else if (request.getParameter("recordD") != null) {

			mapper.insertMediComment(medicalComment_7VO);
			if (medicalComment_7VO.getDischargeC().equals("Y")) {
				
				// ajax 버젼 코드로 진행된다고해서 if문은 없애면 안되고 비워둬야함. 

// 퇴원수속알림 (구버젼) --------------------------------------------------------------------------------------------------------			
				/*
				noticeToN_8VO.setPatientIdx(patientIdx);
				noticeToN_8VO.setName(patientVO.getName());
				noticeToN_8VO.setEmployeeIdx(employeeIdx);
				noticeToN_8VO.setFromName(employeeName);
				noticeToN_8VO.setAlarmN("퇴원수속");

				mapper.insertNoticeToNFromD(noticeToN_8VO);

				Alert.alertAndClose(response, "퇴원 진료기록이 등록되었습니다.");
				Alert.alertAndGo(response, "To.간호사" + medicalComment_7VO.getName() + " 님의 퇴원수속 알림이 전송되었습니다.", "viewMedical?patientIdx=" + medicalComment_7VO.getPatientIdx() + "&dDay=" + dDay);
				 */				
//---------------------------------------------------------------------------------------------------------------------------------

			} else {
				Alert.alertAndGo(response, "진료기록이 등록되었습니다.", "viewMedical?patientIdx=" + medicalComment_7VO.getPatientIdx() + "&dDay="+ dDay);

			}
		} else	{
			// 진료 기록이 비었을때 에러남 작성화면에서 
			Alert.alertAndGo(response, "내용을 입력해주세요.", "viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay);
			Alert.alertAndBack(response, "내용을 입력해주세요.");
//			out.println("<script>alert('내용을 입력해주세요.')</script>");
//			out.println("<script>location.href='viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay + "'</script>");
		}
		return "redirect:viewMedical";

	}

	@RequestMapping("/updateMediComment")
	public String updateMediComment(HttpServletRequest request, HttpServletResponse response, Model model,
			MedicalComment_7VO medicalComment_7VO) throws IOException {
		logger.info("컨트롤러의 updateMediComment()메소드 실행");
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		mapper.updateMediComment(medicalComment_7VO);

		model.addAttribute("dDay", request.getParameter("dDay"));
//		response.setContentType("text/html; charset=UTF-8");
//		PrintWriter out = response.getWriter();
		Alert.alertAndGo(response, "진료기록 수정 완료", "viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay);
//		out.println("<script>alert('진료기록 수정 완료')</script>");
//		out.println("<script>location.href='viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay + "'</script>");
		
		
//		out.flush();
		return "/doctor/viewMedical";

	}

	@RequestMapping("/deleteMediComment")
	public String deleteMediComment(HttpServletResponse response, HttpServletRequest request, Model model,
			MedicalComment_7VO medicalComment_7VO) throws IOException {
		logger.info("컨트롤러의 deleteMediComment()메소드 실행");
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		request.setAttribute("patientIdx", patientIdx);
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		request.setAttribute("dDay", dDay);
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.deleteMediComment(medicalComment_7VO.getIdx());

		model.addAttribute("patientIdx", request.getParameter("patientIdx"));
		model.addAttribute("dDay", request.getParameter("dDay"));

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.println("<script>alert('진료기록 삭제 완료')</script>");
		out.println("<script>location.href='viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay + "'</script>");
		out.flush();

		return "/doctor/viewMedical";
	}

//	처방내역-약물 삭제 구버젼
	/*
	@RequestMapping("/deleteMediPreMed")
	public String deleteMediPreMed(HttpServletResponse response, HttpServletRequest request, Model model)
			throws IOException {
		logger.info("컨트롤러의 deleteMediPreMed()메소드 실행");

		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		request.setAttribute("patientIdx", patientIdx);
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		request.setAttribute("dDay", dDay);
		int idx = Integer.parseInt(request.getParameter("idx"));

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.deleteMediPreMed(idx);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.println("<script>alert('약물 처방내역 1개를 삭제하였습니다.')</script>");
		out.println("<script>location.href='viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay + "'</script>");
		out.flush();

		return "/doctor/viewMedical";

	}
*/	

//	처방내역-약물 삭제 ajax 버젼
	@RequestMapping("/deleteMediPreMed/{idx}")
	public String deleteMediPreMed(@PathVariable("idx") int idx, HttpServletRequest request, Model model) {
		logger.info("컨트롤러의 deleteMediPreMed()메소드 실행");

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		PrescriptionMed_4VO prescriptionMedVO = mapper.selectPrescriptionMedOne(idx);
		
		HttpSession session = request.getSession();
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		
		int patientIdx = prescriptionMedVO.getPatientIdx();
		String name = prescriptionMedVO.getName();
		String medicine = prescriptionMedVO.getMedicine().split(" ")[0];
		
		String alarmN = "약처방(" + medicine + ")취소"; 
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		NoticeToN_8VO noticeToNVO = ctx.getBean("noticeToNVO", NoticeToN_8VO.class);
		noticeToNVO.setAlarmN(alarmN);
		noticeToNVO.setEmployeeIdx(employeeIdx);
		noticeToNVO.setFromName(fromName);
		noticeToNVO.setName(name);
		noticeToNVO.setPatientIdx(patientIdx);
		
		mapper.deleteMediPreMed(idx);
		mapper.insertNoticeToNFromD(noticeToNVO);

		return "viewMedical";
	}

// 처방내역-검사 삭제 ajax 버젼
	@RequestMapping("/deleteMediPreTest/{idx}")
	public String deleteMediPreTest(@PathVariable("idx") int idx, HttpServletRequest request, Model model) {
		logger.info("컨트롤러의 deleteMediPreTest()메소드 실행");

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		PrescriptionTest_5VO prescriptionTestVO = mapper.selectPrescriptionTestOne(idx);

		HttpSession session = request.getSession();
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		String fromName = (String) session.getAttribute("employeeName");
		
		int patientIdx = prescriptionTestVO.getPatientIdx();
		String name = prescriptionTestVO.getName();
		String testName = prescriptionTestVO.getTest();
		
		String alarmN = testName + "처방 취소"; 
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		NoticeToN_8VO noticeToNVO = ctx.getBean("noticeToNVO", NoticeToN_8VO.class);
		noticeToNVO.setAlarmN(alarmN);
		noticeToNVO.setEmployeeIdx(employeeIdx);
		noticeToNVO.setFromName(fromName);
		noticeToNVO.setName(name);
		noticeToNVO.setPatientIdx(patientIdx);
		
		mapper.deleteMediPreTest(idx);
		mapper.insertNoticeToNFromD(noticeToNVO);
		
		return "viewMedical";
	}
	
// 처방내역-검사 삭제 구버젼	
/*
	if (request.getParameter("test").equals("blood")) {
		prescriptionTest_5VO.setTest("혈액검사");
	} else {
		prescriptionTest_5VO.setTest("소변검사");
	}
	mapper.insertMediPreTest(prescriptionTest_5VO);
	out.println("<script>alert('" + prescriptionTest_5VO.getTest() + " 처방이 등록되었습니다.')</script>");
	out.println("<script> alert('To.간호사 " + patientVO.getName() + " 환자의 " + prescriptionTest_5VO.getTest() + " 처방 알림이 전송되었습니다.')</script>");
	out.println("<script>location.href='viewMedical?patientIdx=" + prescriptionTest_5VO.getPatientIdx()
			+ "&dDay=" + dDay + "'</script>");
	
	noticeToN_8VO.setPatientIdx(patientIdx);
	noticeToN_8VO.setName(patientVO.getName());
	noticeToN_8VO.setEmployeeIdx(employeeIdx);
	noticeToN_8VO.setFromName(employeeName);
	noticeToN_8VO.setAlarmN("검사처방 취소");
	
	mapper.insertNoticeToNFromD(noticeToN_8VO);

	out.println("<script> alert('" + prescriptionMed_4VO.getMedicine() + " 약물 처방이 등록되었습니다.')</script>");
	out.println("<script> alert('To.간호사 " + patientVO.getName() + " 환자의 " + prescriptionMed_4VO.getMedicine() + "약물 처방 알림이 전송되었습니다.')</script>");
	out.println("<script>location.href='viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay + "'</script>");
*/	
	
	/*
	@RequestMapping("/deleteMediPreTest")
	public String deleteMediPreTest(HttpServletResponse response, HttpServletRequest request, Model model)
			throws IOException {
		logger.info("컨트롤러의 deleteMediPreTest()메소드 실행");
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		request.setAttribute("patientIdx", patientIdx);
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		request.setAttribute("dDay", dDay);
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.deleteMediPreTest(idx);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		out.println("<script>alert('검사 처방내역 1개를 삭제하였습니다.')</script>");
		out.println("<script>location.href='viewMedical?patientIdx=" + patientIdx + "&dDay=" + dDay + "'</script>");
		out.flush();
		
		return "/doctor/viewMedical";
		
	}
	*/

	@RequestMapping("/viewMedicalBack")
	public String viewMedicalBack(HttpServletResponse response, HttpServletRequest request, Model model)
			throws IOException {
		logger.info("컨트롤러의 viewMedicalBack()메소드 실행");

		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		String code = request.getParameter("code");
		request.setAttribute("dDay", dDay);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.println("<script>location.href='viewMedical?patientIdx=" + patientIdx + "&code=" + code + "&dDay=" + dDay + "'</script>");
		out.flush();

		return "/doctor/viewMedical";

	}

	

}
