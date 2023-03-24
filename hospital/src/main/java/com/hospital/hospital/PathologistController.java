package com.hospital.hospital;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.NoticeToP_14List;
import com.hospital.vo.Patient_1List_All;
import com.hospital.vo.Patient_1VO;
import com.hospital.vo.WorkMemoP_15List;
import com.hospital.vo.WorkMemoP_15VO;

@Controller
public class PathologistController {

	private static final Logger logger = LoggerFactory.getLogger(PathologistController.class);

	@Autowired
	private SqlSession sqlSession;
	

	
//==================================================================================
// 병리사 메인페이지
	@RequestMapping("/viewMainP")
	public String viewMainP(HttpServletRequest request, Model model) {
		logger.info("viewMainP()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		// 병리사 업무 알림 리스트
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		NoticeToP_14List noticeToPList = ctx.getBean("noticeToPList", NoticeToP_14List.class);
		noticeToPList.setNoticeToPList(mapper.selectNoticeToPList());
		model.addAttribute("noticeToPlist", noticeToPList);
		
		
		// 병리사 메모 리스트
		WorkMemoP_15List workmemoList = ctx.getBean("workmemoPlist", WorkMemoP_15List.class);
		workmemoList.setWorkmemoPList(mapper.selectmemoPList());
		model.addAttribute("workmemoPlist", workmemoList);
		
		
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
		
		return "viewMainP";
		
	}
	
	// 업무 메모 삽입
	@RequestMapping("/workmemoPOK")
	public String workmemoPOK(HttpServletRequest request, Model model, WorkMemoP_15VO workmemopvo, HttpServletResponse response) {
		logger.info("workmemoPOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		String commentP = request.getParameter("commentP");
		
		if (commentP == null || commentP.equals("")) {
			Alert.alertAndRedirect(response, "내용을 입력하세요", "viewMainP");
		}
		
		mapper.workmemoPinsert(workmemopvo);
		
		return "redirect:viewMainP";
	}
	
	
	// 업무 메모 삭제
	@RequestMapping("/workmemoPdeleteOK")
	public String workmemoPdeleteOK(HttpServletRequest request, Model model, HttpServletResponse response) {
		logger.info("workmemoPdeleteOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		mapper.deletePmemo(idx);
		Alert.alertAndRedirect(response, "메모 삭제 완료!", "viewMainP");
		
		return "redirect:viewMainP";
	}
	
	
	// 업무 메모 수정
	@RequestMapping("/workmemoPupdateOK")
	public String workmemoPupdateOK(HttpServletRequest request, Model model, WorkMemoP_15VO workmemopvo, HttpServletResponse response) {
		logger.info("workmemoPupdateOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		int idx = Integer.parseInt(request.getParameter("idx"));
		String commentP = request.getParameter("commentP");
		
		if (commentP == null || commentP.equals("")) {
			Alert.alertAndRedirect(response, "수정할 내용을 입력하세요", "viewMainP");
		}
		mapper.updatePmemo(workmemopvo);
		
		Alert.alertAndRedirect(response, "메모 수정 완료!", "viewMainP");
		
		
		return "redirect:viewMainP";
	}
	
	
	@RequestMapping ("/viewTest")
	public String viewTest(HttpServletRequest request, Model model) {
		logger.info("viewTest()");
		
		HttpSession session = request.getSession();
		
		
		//	환자 정보 받기
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		//	환자 정보 태그 
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		
		model.addAttribute("patientVO", patientVO);
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);
		
		return "viewTest";
	}

// ******* 혈액검사결과 저장과 소변검사결과 저장 메소드는 DownExcelController에 있음.
	
/* 
 * DownExcelController에 아래 내용 포함하는 메소드 있음. 
//	혈액 검사 결과 저장
	@RequestMapping ("/testbloodresult")
	public String testbloodresult(HttpServletRequest request, Model model, HttpServletResponse response, TestBlood_17VO testBloodVO, NoticeToD_2VO noticeToDVO, NoticeToN_8VO noticeToNVO) throws IOException {
		logger.info("testbloodresult()");
		//	직원 정보 받기
		HttpSession session = request.getSession();
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		//	환자 정보 받기
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		Patient_1VO patient_1vo = mapper.selectPatient(patientIdx);
		
		//logger.info("{}", testBloodVO);

		
		// 혈액 검사 결과를 저장
		mapper.insertTestBlood(testBloodVO);
		
		//	의사에게 검사 결과 알람
		noticeToDVO.setAlarmD("혈액검사결과");
		noticeToDVO.setFromDP((String)session.getAttribute("dpart"));
		noticeToDVO.setFromName((String)session.getAttribute("employeeName"));
		logger.info("{}", noticeToDVO);
		mapper.insertNoticeToD(noticeToDVO);
		
//		간호사에게 검사 결과 알람
		noticeToNVO.setAlarmN("혈액검사결과");
		noticeToNVO.setFromDP((String)session.getAttribute("dpart"));
		noticeToNVO.setFromName((String)session.getAttribute("employeeName"));
		logger.info("{}", noticeToNVO);
		mapper.insertNoticeToN(noticeToNVO);

		// 알림창 띄우기
		Alert.alertAndGo(response, "To. 의사, 간호사  " + patient_1vo.getName() +"님의 검사 결과 등록 알림이 발송되었습니다.", "viewPatientDetail?patientIdx=" + patientIdx + "&dDay=" + dDay);
		
		
		return "redirectalert:viewPatientDetail";
	}
*/
	
/*	
 *  DownExcelController에 아래 내용 포함하는 메소드 있음. 
//	소변 검사 결과 저장
	@RequestMapping ("/testUrineresult")
	public String testUrineresult(HttpServletRequest request, Model model, HttpServletResponse response, TestUrine_21VO testUrineVO, NoticeToD_2VO noticeToDVO, NoticeToN_8VO noticeToNVO) throws IOException {
		logger.info("testUrineresult()");
		//	직원 정보 받기
		HttpSession session = request.getSession();
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		//	환자 정보 받기
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);
		
		Patient_1VO patient_1vo = mapper.selectPatient(patientIdx);
		
		// 소변 검사 결과를 저장
		mapper.insertTestUrine(testUrineVO);
		
		//	의사에게 검사 결과 알람
		noticeToDVO.setAlarmD("소변검사결과");
		noticeToDVO.setFromDP((String)session.getAttribute("dpart"));
		noticeToDVO.setFromName((String)session.getAttribute("employeeName"));
		logger.info("{}", noticeToDVO);
		mapper.insertNoticeToD(noticeToDVO);
		
//		간호사에게 검사 결과 알람
		noticeToNVO.setAlarmN("소변검사결과");
		noticeToNVO.setFromDP((String)session.getAttribute("dpart"));
		noticeToNVO.setFromName((String)session.getAttribute("employeeName"));
		logger.info("{}", noticeToNVO);
		mapper.insertNoticeToN(noticeToNVO);

		// 알림창 띄우기
		Alert.alertAndGo(response, "To. 의사, 간호사  " + patient_1vo.getName() +"님의 검사 결과 등록 알림이 발송되었습니다.", "viewPatientDetail?patientIdx=" + patientIdx + "&dDay=" + dDay);
		
		return "viewPatientDetail";

	}
*/	

	
//	=======================================================================================================================
	 // 업로드 저장위치C:/Upload
		@RequestMapping("/fileUploadResult")
		public String fileUploadResult(HttpServletResponse response, MultipartHttpServletRequest request, Model model)
				throws IOException {
			System.out.println("컨트롤러의 fileUploadResult() 메소드 실행");

			String rootUploadDir = "C:" + File.separator + "Upload"; // C:/Upload
			File dir = new File(rootUploadDir + File.separator + "testfile"); // C:/Upload/testfile

			if (!dir.exists()) {
				dir.mkdirs();
			}

			Iterator<String> iterator = request.getFileNames();
			String uploadFileName = "";
			MultipartFile multipartFile = null;
			String orgFileName = ""; // 원래 파일명
			ArrayList<String> list = new ArrayList<String>();

			while (iterator.hasNext()) {
				uploadFileName = iterator.next();
				multipartFile = request.getFile(uploadFileName);
				orgFileName = multipartFile.getOriginalFilename();
				System.out.println(orgFileName);

				if (orgFileName != null && orgFileName.length() != 0) {
					try {
						multipartFile.transferTo(new File(dir + File.separator + orgFileName)); // C:/Upload/testfile/orgFileName
						System.out.println("파일명 : " + orgFileName);
						list.add("파일명 : " + orgFileName);
						
						response.setContentType("text/html; charset=UTF-8");
						int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
						int dDay = Integer.parseInt(request.getParameter("dDay"));
						System.out.println(patientIdx);
						System.out.println(dDay);
						Alert.alertAndGo(response, "업로드 완료", "viewTest?patientIdx=" + patientIdx + "&dDay=" + dDay);
					} catch (Exception e) {
						e.printStackTrace();
						list.add("파일 업로드 중 에러 발생!!!");
					}
				}

			}

			model.addAttribute("list", list);
			return "viewTest";
		}


}
