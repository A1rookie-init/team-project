package com.hospital.hospital;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.TypeMismatchException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.NoticeToA_18List;
import com.hospital.vo.NoticeToD_2VO;
import com.hospital.vo.NoticeToN_8VO;
import com.hospital.vo.Patient_1List_All;
import com.hospital.vo.Patient_1VO;
import com.hospital.vo.PrescriptionTest_5VO;
import com.hospital.vo.TeamCount;
import com.hospital.vo.WorkMemoA_19List;
import com.hospital.vo.WorkMemoA_19VO;

@Controller
public class AcceptanceController {

	private static final Logger logger = LoggerFactory.getLogger(AcceptanceController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@ RequestMapping("/viewMainA")
	public String viewMainA(HttpServletRequest request, Model model) {
		logger.info("viewMainA()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		// 원무과 업무 알림 리스트
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		NoticeToA_18List noticeToAlist = ctx.getBean("noticeToAlist", NoticeToA_18List.class);
		noticeToAlist.setNoticeToAList(mapper.selectNoticeToAList());
		//logger.info("noticeToAlist: " + noticeToAlist);
		model.addAttribute("noticeToAlist", noticeToAlist);
		
		
		// 원무과 메모 리스트
		WorkMemoA_19List workmemoList = ctx.getBean("workmemoList", WorkMemoA_19List.class);
		workmemoList.setMemoAlist(mapper.selectmemoList());
		//logger.info("workmemoList: " + workmemoList);
		model.addAttribute("workmemoList", workmemoList);
		
		
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
			
		return "viewMainA";
		
	}
	
	
	// 업무 메모 삽입
	@RequestMapping("/workmemoOK")
	public String workmemoOK(HttpServletRequest request, Model model, WorkMemoA_19VO workmemoavo, HttpServletResponse response) {
		logger.info("workmemoOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		String commentA = request.getParameter("commentA");
		
		if (commentA == null || commentA.equals("")) {
			Alert.alertAndRedirect(response, "내용을 입력하세요", "viewMainA");
		}
		
		mapper.workmemoinsert(workmemoavo);
		
		return "redirect:viewMainA";
	}
	
	
	// 업무 메모 삭제
	@RequestMapping("/workmemoAdeleteOK")
	public String workmemoAdeleteOK(HttpServletRequest request, Model model, WorkMemoA_19VO workmemoavo, HttpServletResponse response) {
		logger.info("workmemoAdeleteOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		logger.info("idx: " +idx);
		
		mapper.deletememo(idx);
		
		Alert.alertAndRedirect(response, "메모 삭제 완료!", "viewMainA");
		
		return "redirect:viewMainA";
	}
	
	// 업무 메모 수정
	@RequestMapping("/workmemoAupdateOK")
	public String workmemoAupdateOK(HttpServletRequest request, Model model, WorkMemoA_19VO workmemoavo, HttpServletResponse response) {
		logger.info("workmemoAupdateOK()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		String commentA = request.getParameter("commentA");
		
		if (commentA == null || commentA.equals("")) {
			Alert.alertAndRedirect(response, "수정할 내용을 입력하세요", "viewMainA");
		}
		
		mapper.updatememo(workmemoavo);
		
		Alert.alertAndRedirect(response, "메모 수정 완료!", "viewMainA");
		
		return "redirect:viewMainA";
	}
	
//	환자등록 화면
	@RequestMapping("/insertPatient")
	public String insertPatient(HttpServletRequest request, Model model) {
		logger.info("insertPatient()");
//		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
// 신환등록 임시번호 코드 여기로 이동함		
		//	신환 등록을 위한 임시 환자번호
		int newPatientIdx = 100001;
 		ArrayList<Patient_1VO> patient_1List_All = mapper.selectPatientList_All();
 		// 신환등록 알람 보내기
		if(patient_1List_All != null) {
	 		//	환자 번호 제일 끝 번호를 가져와서 +1 
			newPatientIdx = mapper.selectnewPatientIdx() + 1;
		} 
//		여기에서 팀별 카운트 보내기
			AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			
//			String doctorT = (String) session.getAttribute("doctorT");
//			String nurseT = (String) session.getAttribute("nurseT");
			
			TeamCount teamCount = ctx.getBean("teamCount", TeamCount.class);
			teamCount.setCountDTeamA(mapper.countDT("A"));
			teamCount.setCountDTeamB(mapper.countDT("B"));
			teamCount.setCountNTeamA(mapper.countNT("A"));
			teamCount.setCountNTeamB(mapper.countNT("B"));
			teamCount.setCountNTeamC(mapper.countNT("C"));
			
			model.addAttribute("teamCount", teamCount);
		
		model.addAttribute("newPatientIdx", newPatientIdx);
		return "insertPatient";
	}

	
//	환자등록 입력
	@RequestMapping("/insertPatientOK")
	public String insertPatientOK(HttpServletRequest request, Model model, HttpServletResponse response, Patient_1VO patientVO) throws IOException {
		logger.info("insertPatientOK()");
		
		HttpSession session = request.getSession();

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		//	신환 등록을 위한 임시 환자번호
		int newPatientIdx = 100001;
		
		String name = request.getParameter("name").trim();
		String age = request.getParameter("age").trim();
		String registNum1 = request.getParameter("registNum1").trim();
		String registNum2 = request.getParameter("registNum2").trim();
		String gender = request.getParameter("gender").trim();
		String address = request.getParameter("address").trim();
		String insurance = request.getParameter("insurance").trim();
		String room = request.getParameter("room").trim();
		String meal = request.getParameter("meal").trim();
		String doctorT = request.getParameter("doctorT").trim();
		String nurseT = request.getParameter("nurseT").trim();

		if(name == null|| name.equals("")||
			age == null || age.equals("")||
			registNum1 == null || registNum1.equals("")||
			registNum2 == null || registNum2.equals("")||
			gender == null || gender.equals("")||
			address == null || address.equals("")||
			insurance == null || insurance.equals("")||
			room == null || room.equals("")||
			meal == null || meal.equals("")||
			doctorT == null || doctorT.equals("")||
			nurseT == null || nurseT.equals("")){
			
			Alert.alertAndBack(response, "입력사항을 모두 입력해주세요.");
			
		} else {
			try {
				int registNum1_int = Integer.parseInt(registNum1);
				int registNum2_int = Integer.parseInt(registNum2);
				int age_int = Integer.parseInt(age);
				
				if(meal.equals("true")) {
					patientVO.setMeal("Y");
				} else {
					patientVO.setMeal("N");
				}
				
				patientVO.setRoom(room);
				//신환등록하면 초진전에 진단명 null로 떠서 "진료전"쑤셔넣기
				patientVO.setDiagnosis("진료 전");
		 		mapper.insertPatient(patientVO);

// 신환등록알림 (구버젼) ---------------------------------------------------------------------------------------------
/*		 		
		 		//	업무 알람 보낼떄 들어갈 발신자 정보 
			 		int employeeIdx = Integer.parseInt((String)session.getAttribute("employeeIdx"));	// 정체모를 에러떠서 변환 수정함.
			 		String employeeName = (String)session.getAttribute("employeeName");
			 		String dpart = (String)session.getAttribute("dpart");

			 		ArrayList<Patient_1VO> patient_1List_All = mapper.selectPatientList_All();
			 		
			 		// 신환등록 알람 보내기
			 		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			 		NoticeToD_2VO noticeToDVO = ctx.getBean("noticeToDVO", NoticeToD_2VO.class);
			 	
		 		if(patient_1List_All != null) {
			 		//	환자 번호 제일 끝 번호를 가져와서  +1 해서 patientIdx 삽입해주기(서비스 클래스에서  +1 해옴)
		 			newPatientIdx = mapper.selectnewPatientIdx();
		 			noticeToDVO.setPatientIdx(newPatientIdx);
		 			noticeToDVO.setName(patientVO.getName());
					noticeToDVO.setAlarmD("신환등록");
					noticeToDVO.setFromDP((String)session.getAttribute("dpart"));
					noticeToDVO.setEmployeeIdx(Integer.parseInt((String)session.getAttribute("employeeIdx")));
					noticeToDVO.setFromName((String)session.getAttribute("employeeName"));
					//logger.info("{}", noticeToDVO);
					
					mapper.insertNoticeToD(noticeToDVO);
		 		} else {
		 			noticeToDVO.setPatientIdx(newPatientIdx);
		 			noticeToDVO.setName(patientVO.getName());
					noticeToDVO.setAlarmD("신환등록");
					noticeToDVO.setFromDP((String)session.getAttribute("dpart"));
					noticeToDVO.setEmployeeIdx((Integer)session.getAttribute("employeeIdx"));
					noticeToDVO.setFromName((String)session.getAttribute("employeeName"));
					//logger.info("{}", noticeToDVO);
					
					mapper.insertNoticeToD(noticeToDVO);
		 		}
*/
//---------------------------------------------------------------------------------------------------------------------------------					

		 		//	주민 등록번호에 문자 들어가면 에러나는거 잡아야함!
			} catch (TypeMismatchException e) {
				Alert.alertAndBack(response, "잘못된 입력값입니다.");
			}
		}
		return "redirect:viewMainA";
	}
	
// 환자등록 알림 (ajax버젼)
	@RequestMapping("/insertNoticeToDForNewAjax")
	@ResponseBody
	public String insertNoticeToDForNewAjax(NoticeToD_2VO noticeToD_2VO) {
		logger.info("컨트롤러의 insertNoticeToDForNewAjax()메소드 실행");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.insertNoticeToD(noticeToD_2VO);
		return "insert into DB : success";
	}		

		
 @RequestMapping("/viewAccept")
   public String insertAccept(HttpServletRequest request, Model model) {
      logger.info("컨트롤러의 viewAccept() 메소드 실행");

      HttpSession session = request.getSession();
      int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
      int dDay = Integer.parseInt(request.getParameter("dDay"));
      model.addAttribute("patientIdx", patientIdx);
      model.addAttribute("dDay", dDay);

      String employeeName = (String) session.getAttribute("employeeName");
      int employeeIdx = Integer.parseInt((String)session.getAttribute("employeeIdx"));


      MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

// 환자 정보
      Patient_1VO patientVO = mapper.selectPatient(patientIdx);
      request.setAttribute("patientVO", patientVO);

      AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
// 혈액 소변검사 리스트
      ArrayList<PrescriptionTest_5VO> prescriptionTestList = mapper.selectPrescriptionTest(patientIdx);
      model.addAttribute("prescriptionTestList", prescriptionTestList);

// 혈액 검사 개수
     int pretestBcount = mapper.selectPreTestBCount(patientIdx);
      request.setAttribute("pretestBcount", pretestBcount);

// 소변 검사 개수
     int pretestPcount = mapper.selectPreTestPCount(patientIdx);
      request.setAttribute("pretestPcount", pretestPcount);

// 약품비
      int premedcount = mapper.selectPrescriptionMed(patientIdx);
      request.setAttribute("premedcount", premedcount);

// 진찰료
      int medicomcount =  mapper.selectMedicalComment(patientIdx);
      request.setAttribute("medicomcount", medicomcount);
      
      
      
// 검사지 파일      
  //	C:\Upload\testfile\excelfile 폴더 없으면 에러남 폴더 만들면 각자 삭제해주세요
	String uploadDirectory = "C:" + File.separator + "Upload" + File.separator + "testfile" 
			+ File.separator + "excelfile" + File.separator;
	String[] files = new File(uploadDirectory).list();
	ArrayList<String> fileList = new ArrayList<String>();
	String fileName = null;
	for (String file : files) {
		try {
			fileName = URLEncoder.encode(file, "UTF-8");
			fileList.add(fileName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
  
    model.addAttribute("fileList", fileList); 
      
      
      
      
      return "viewAccept";
   }

   @RequestMapping("/insertAcceptOK")
   public String insertAcceptOK(HttpServletRequest request, Model model) {
      logger.info("insertAcceptOK()");
      
      int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
      MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
      mapper.updatePatientDischarge(patientIdx);
      
      request.setAttribute("msg", "수납 완료");
      request.setAttribute("url", "viewMainA");
		return "alert";

   }

   @RequestMapping("/fileDownload")
   public String fileDownload(HttpServletRequest request) {
      
      logger.info("fileDownload()");
      
      
      
      return "fileDownload";
   }
   

 @RequestMapping("/downloadTest")
 public class downloadTest extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public downloadTest() {
       super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       actionDo(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       actionDo(request, response);

    }

    protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       request.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지
       response.setContentType("text/html; charset=UTF-8"); // 보낼 때 한글깨짐 방지



       String filename = request.getParameter("file");

       

       String uploadDirectory = getServletContext().getRealPath("C:\\Upload") + filename; // realpath와 파일이름을 연결
       System.out.println(uploadDirectory);

       File file = new File(uploadDirectory);

       String mimeType = getServletContext().getMimeType(file.toString());
       System.out.println(mimeType);

       if (mimeType == null) {
          response.setContentType("application/octet-stream");
       }

       String downloadName = null;
       if (request.getHeader("user-agent").indexOf("MSIE") == -1) {
          downloadName = new String(filename.getBytes("UTF-8"), "8859_1");
       } else {
          downloadName = new String(filename.getBytes("EUC-KR"), "8859_1");

       }
       response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + "\";");

       FileInputStream fileInputStream = new FileInputStream(file);
       ServletOutputStream outputStream = response.getOutputStream();
       byte[] b = new byte[1024];
       int date = 0;

       while ((date = fileInputStream.read(b, 0, b.length)) != -1) {   // 전송할 파일에서 읽어들인 데이터가 있는가?
          outputStream.write(b,0,date);

       }
       
       outputStream.flush();
       outputStream.close();
       fileInputStream.close();

    }
    
 }

}
