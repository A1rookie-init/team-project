package com.hospital.hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.Injection_11List;
import com.hospital.vo.MedicalComment_7List;
import com.hospital.vo.NursingComment_13_List;
import com.hospital.vo.Patient_1List_Item;
import com.hospital.vo.Patient_1VO;
import com.hospital.vo.PrescriptionMed_4List;
import com.hospital.vo.PrescriptionTest_5List;
import com.hospital.vo.TestBlood_17VO;
import com.hospital.vo.TestUrine_21VO;
import com.hospital.vo.ViewMedicalList;
import com.hospital.vo.ViewMedicalVO;
import com.hospital.vo.ViewNursingList;
import com.hospital.vo.ViewNursingVO;
import com.hospital.vo.ViewTestList;
import com.hospital.vo.VitalSign_10List;

@Controller
public class PatientController {

	private static final Logger logger = LoggerFactory.getLogger(PatientController.class);

	@Autowired
	private SqlSession sqlSession;
	

//	환자 상세 페이지

// 환자상세- 메뉴바 : 재원환자 정보조회 
	@RequestMapping ("/viewPatientDetail")
	public String viewPatientDetail(HttpServletRequest request, Model model) {
		logger.info("viewPatientDetail()");
		//	환자 정보 받기
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		
		model.addAttribute("patientVO", patientVO);
		model.addAttribute("dDay", dDay);

		return "viewPatientDetail";
	}
	
	@RequestMapping ("/viewPatientDetailUpdate")
	public String viewPatientDetailUpdate(HttpServletRequest request, Model model) {
		logger.info("viewPatientDetailUpdate()");
		
		//	정보를 꺼내올 환자의 번호 받기
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		request.setAttribute("dDay", dDay);
		request.setAttribute("patientIdx", patientIdx);

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		Patient_1VO patientVo = mapper.selectPatient(patientIdx);
		
		request.setAttribute("patientVo", patientVo);
		
		return "viewPatientDetailUpdate";
	}
	
//	환자 상세페이지에서 정보 수정
	@RequestMapping ("/viewPatientDetailUpdateOK")
	public String viewPatientDetailUpdateOK(HttpServletRequest request, Model model, Patient_1VO patientVO) {
		logger.info("viewPatientDetailUpdate()");
		logger.info("{}", patientVO);
//		정보를 꺼내올 환자의 번호 받기
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);
		
		String allergy = "N";
		logger.info(request.getParameter("allergy-detail"));
		if (request.getParameter("allergy-detail") == null) {
			patientVO.setAllergy(allergy);
		} else {
			patientVO.setAllergy(request.getParameter("allergy-detail"));
		}
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.updatePatientDetail(patientVO);
		
		return "redirect:viewPatientDetail";
	}

	
	
// 환자상세- 메뉴바 : 재원환자 의무기록조회 
		@RequestMapping("/viewListMedical")
		public String viewListMedical(HttpServletRequest request, Model model, HttpServletResponse response) {
			logger.info("컨트롤러의 viewListMedical()메소드 실행");
			
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
			
			int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
			int dDay = Integer.parseInt(request.getParameter("dDay"));
			
			Patient_1VO patientVO = mapper.selectPatient(patientIdx);
			
			AbstractApplicationContext ctx1 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			model.addAttribute("patientIdx", patientIdx);		
			model.addAttribute("dDay", dDay);
			
			if (dDay <= 1) {
				
				return "patient/viewListNone";
				
			} else {
				int diffDay = dDay - 1;		// 재원환자용 
				
	//			페이징 작업				
				int currentPage = 1;
				try {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				} catch (NumberFormatException e) { }
				
				int pageSize = 3;
				int totalCount = diffDay;
				
				ViewMedicalList viewMedicalList = ctx1.getBean("viewMedicalList", ViewMedicalList.class);
				viewMedicalList.setCurrentPage(currentPage);
				viewMedicalList.setTotalCount(totalCount);
				viewMedicalList.setPageSize(pageSize);
				
				viewMedicalList.calculator();
				
				int startNo = viewMedicalList.getStartNo();
				int endNo = viewMedicalList.getEndNo();
				
				System.out.println( "curnpage" + currentPage);
				System.out.println( "total" + totalCount);
				System.out.println( "pagwSixe" + pageSize);
				System.out.println( "시작번호" + startNo);
				System.out.println( "끝번호" + endNo);
				
				ArrayList<ViewMedicalVO> viewMedicalVOList1 = new ArrayList<ViewMedicalVO>();
				
				for (int subDay=1; subDay<=diffDay+1; subDay++) {
					
					AbstractApplicationContext ctx2 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
					HashMap<String, Integer> hmap = new HashMap<String, Integer>();
					hmap.put("patientIdx", patientIdx);
					hmap.put("subDay", subDay);
					
					ViewMedicalVO viewMedicalVO = ctx2.getBean("viewMedicalVO", ViewMedicalVO.class); 
					
					PrescriptionMed_4List prescriptionMedList = ctx2.getBean("prescriptionMedList", PrescriptionMed_4List.class);
					prescriptionMedList.setPrescriptionMedList(mapper.selectPrescriptionMedList_Menu(hmap));
					
					PrescriptionTest_5List prescriptionTestList = ctx2.getBean("prescriptionTestList", PrescriptionTest_5List.class);
					prescriptionTestList.setPrescriptionTestList(mapper.selectPrescriptionTestList_Menu(hmap));
					
					MedicalComment_7List medicalCommentList = ctx2.getBean("medicalCommentList", MedicalComment_7List.class);
					medicalCommentList.setMedicalCommentList(mapper.selectMediCommentList_Menu(hmap));
					
					viewMedicalVO.setPrescriptionMedList(prescriptionMedList);
					viewMedicalVO.setPrescriptionTestList(prescriptionTestList);
					viewMedicalVO.setMedicalCommentList(medicalCommentList);
					
					viewMedicalVOList1.add(viewMedicalVO);
				}
				
				ArrayList<ViewMedicalVO> viewMedicalVOList2 = new ArrayList<ViewMedicalVO>();
				for (int i=startNo; i<=endNo; i++) {
					viewMedicalVOList2.add(viewMedicalVOList1.get(i));
				}
				viewMedicalList.setViewMedicalVOList(viewMedicalVOList2);	
				
				model.addAttribute("patientVO", patientVO);				
				model.addAttribute("viewMedicalList", viewMedicalList);
				model.addAttribute("enter", "\r\n");
				
				return "patient/viewListMedical";
				
			}
			
		}

// 환자상세- 메뉴바 : 재원환자 간호기록조회	
		@RequestMapping("/viewListNursing")
		public String viewListNursing(HttpServletRequest request, Model model) {
			logger.info("컨트롤러의 viewListNursing()메소드 실행");
			
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
			
			int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
			int dDay = Integer.parseInt(request.getParameter("dDay"));
			
			Patient_1VO patientVO = mapper.selectPatient(patientIdx);
			
			AbstractApplicationContext ctx1 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			model.addAttribute("patientIdx", patientIdx);		
			model.addAttribute("dDay", dDay);	
			
			if (dDay <= 1) {
				return "patient/viewListNone";
			} else {
				int diffDay = dDay - 1;		// 재원환자용 
	
	//			페이징 작업
				int currentPage = 1;
				try {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				} catch (NumberFormatException e) { }
				
				int pageSize = 3;
				int totalCount = diffDay;
				
				ViewNursingList viewNursingList = ctx1.getBean("viewNursingList", ViewNursingList.class);
				viewNursingList.setCurrentPage(currentPage);
				viewNursingList.setTotalCount(totalCount);
				viewNursingList.setPageSize(pageSize);
			
				viewNursingList.calculator();
				
				int startNo = viewNursingList.getStartNo();
				int endNo = viewNursingList.getEndNo();
			
				VitalSign_10List vitalSignList = null;
				Injection_11List injectionList = null;
				NursingComment_13_List nursingCommentList = null;
				
				ArrayList<ViewNursingVO> viewNursingVOList1 = new ArrayList<ViewNursingVO>();
				
				for (int subDay=1; subDay<=diffDay+1; subDay++) {
				
					AbstractApplicationContext ctx2 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");	
					ViewNursingVO viewNursingVO = ctx2.getBean("viewNursingVO", ViewNursingVO.class); 
					
					HashMap<String, Integer> hmap = new HashMap<String, Integer>();
					hmap.put("patientIdx", patientIdx);
					hmap.put("subDay", subDay);
					
					vitalSignList = ctx2.getBean("vitalSignList", VitalSign_10List.class);
					vitalSignList.setVitalSignList(mapper.selectVitalSignList_Menu(hmap));
					
					injectionList = ctx2.getBean("injectionList", Injection_11List.class);
					injectionList.setInjectionList(mapper.selectInjectionList_Menu(hmap));
					
					nursingCommentList = ctx2.getBean("nursingCommentList", NursingComment_13_List.class);
					nursingCommentList.setNursingCommentList(mapper.selectNursingCommentList_Menu(hmap));
					
					viewNursingVO.setVitalSignList(vitalSignList);
					viewNursingVO.setInjectionList(injectionList);
					viewNursingVO.setNursingCommentList(nursingCommentList);
					
					viewNursingVOList1.add(viewNursingVO);	
				}
				ArrayList<ViewNursingVO> viewNursingVOList2 = new ArrayList<ViewNursingVO>();
				
				for (int i=startNo; i<=endNo; i++) {
					viewNursingVOList2.add(viewNursingVOList1.get(i));
				}
				viewNursingList.setViewNursingVOList(viewNursingVOList2);
			
				model.addAttribute("patientVO", patientVO);		
				model.addAttribute("viewNursingList", viewNursingList);
				model.addAttribute("enter", "\r\n");
				
				return "patient/viewListNursing";
			}
		}	
	
//		환자상세-메뉴바 : 재원환자 검사 결과 조회
		@RequestMapping ("/viewListTest")
		public String viewListTest(HttpServletRequest request, Model model) {
			logger.info("viewListTest()");
			
//			환자 정보 받기
			int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
			int dDay = Integer.parseInt(request.getParameter("dDay"));
			logger.info(dDay + "");
			request.setAttribute("dDay", dDay);
			request.setAttribute("patientIdx", patientIdx);
			
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
			AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			
			Patient_1VO patientVO = mapper.selectPatient(patientIdx);
			model.addAttribute("patientVO", patientVO);

			
			return "patient/viewListTest";
		}	
		

//		환자상세-메뉴바 : 검사 결과 조회
		@RequestMapping ("/viewListTestMiddle")
		public String viewListTestMiddle(HttpServletRequest request, Model model) {

			logger.info("viewListTestMiddle()");
//			환자 정보 받기
			int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
			int dDay = Integer.parseInt(request.getParameter("dDay"));
			model.addAttribute("patientIdx", patientIdx);
			model.addAttribute("dDay", dDay);
			
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
			AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			
			Patient_1VO patientVO = mapper.selectPatient(patientIdx);
			request.setAttribute("patientVO", patientVO);
			
			
//			리턴할 테스트 리스트 생성
			ViewTestList viewTestList = ctx.getBean("viewTestList", ViewTestList.class);
//			검사 결과 조회 선택 
			String test = request.getParameter("test");
			//	logger.info(test);
				
			int currentPage = 1;
			int pageSize = 3;
			if (test.equals("blood")) {
				int totalCount = mapper.countTestBloodList(patientIdx);
				logger.info(totalCount + "");
				logger.info(request.getParameter("currentPage") + "-currentPage");
				
				if (request.getParameter("currentPage") != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				} 
				
				viewTestList.setCurrentPage(currentPage);
				viewTestList.setTotalCount(totalCount);
				viewTestList.setPageSize(pageSize);
				
				viewTestList.calculator();
				
				if (request.getParameter("currentPage") == null) {
					viewTestList.setStartNo(0);
				}
				
				ArrayList<TestBlood_17VO> testBloodListPage = mapper.selectBloodTest(patientIdx);
				ArrayList<TestBlood_17VO> testBloodListP = new ArrayList<TestBlood_17VO>();
				
				int startNo = viewTestList.getStartNo();
				int endNo = viewTestList.getEndNo();

				for (int i = startNo; i <= endNo; i++) {
					testBloodListP.add(testBloodListPage.get(i));
				}
				viewTestList.setTestBloodList(testBloodListP);
				viewTestList.setTest(test);
				logger.info(viewTestList + "");
				model.addAttribute("viewTestList", viewTestList);
				request.setAttribute("blood", test);
				
			}  else { 
				//	logger.info("소변검사 결과 조회");
				
					int totalCount = mapper.countTestUrineList(patientIdx);
					logger.info(totalCount + "");
					logger.info(request.getParameter("currentPage") + "-currentPage");
					
					if (request.getParameter("currentPage") != null) {
						currentPage = Integer.parseInt(request.getParameter("currentPage"));
					} 
					
					viewTestList.setCurrentPage(currentPage);
					viewTestList.setTotalCount(totalCount);
					viewTestList.setPageSize(pageSize);
					
					viewTestList.calculator();
					logger.info(viewTestList + "");
					
					if (request.getParameter("currentPage") == null) {
						viewTestList.setStartNo(0);
					}
					
					ArrayList<TestUrine_21VO> testUrineListPage = mapper.selectUrineTest(patientIdx);
					ArrayList<TestUrine_21VO> testUrineListP = new ArrayList<TestUrine_21VO>();
					
					int startNo = viewTestList.getStartNo();
					int endNo = viewTestList.getEndNo();

					for (int i = startNo; i <= endNo; i++) {
						testUrineListP.add(testUrineListPage.get(i));
					}
					viewTestList.setTestUrineList(testUrineListP);
					viewTestList.setTest(test);
					logger.info(viewTestList + "");
					model.addAttribute("viewTestList", viewTestList);
					request.setAttribute("urine", test);
					
			}
			
			return "patient/viewListTest";
		}
	
	
	
// < 퇴원환자 조회 >	
	
	
//	퇴원환자 검색
  @RequestMapping("/viewDisPatient")
  public String viewDisPatient(HttpServletRequest request) {
	  return "disPatient/viewDisPatient";
  }
//	퇴원환자 중간과정
  @RequestMapping("/viewDisPatientMiddle")
  public String viewDisPatientMiddle(HttpServletRequest request, HttpServletResponse response, Model model) {

	logger.info("컨트롤러의 viewDisPatientMiddle()메소드 실행");
	MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);	
	String item = request.getParameter("item").trim();
	String category = request.getParameter("category");
	String set = request.getParameter("set");
	int currentPage = 1;
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	} catch (NumberFormatException e) {
	}
	int pageSize = 10;
	AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	Patient_1List_Item patient_1List_Item = ctx.getBean("patient_1List_Item", Patient_1List_Item.class);
	patient_1List_Item.setCurrentPage(currentPage);
	patient_1List_Item.setPageSize(pageSize);
	
	try {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
	
		if (item == null || item.equals("")) {
			out.println("<script>");
			out.println("alert('검색어를 입력해주세요.')");
			out.println("location.href='viewDisPatient'");
			out.println("</script>"); 
			
		} else if (set == null) {
			out.println("<script>");
			out.println("alert('검색조건을 선택해주세요.')");
			out.println("location.href='viewDisPatient'");
			out.println("</script>"); 
			
		} else if (set.equals("pIdx")) {
			
			int pIdx = 0;
			try {
				pIdx = Integer.parseInt(item);
				int totalCount = mapper.selectCountPatientList_pIdx(pIdx);	
				patient_1List_Item.setItem(item);
				patient_1List_Item.setTotalCount(totalCount);
				patient_1List_Item.calculator();
				
				patient_1List_Item.setPatient_1List_Item(mapper.selectPatientList_pIdxForPaging(patient_1List_Item));
				
				request.setAttribute("patient_1List_Item", patient_1List_Item);
				request.setAttribute("category", category);
				request.setAttribute("set", set);
				
				return "disPatient/viewDisPatient";
				
			} catch (NumberFormatException e) {
				out.println("<script>");
				out.println("alert('잘못된 검색어 입니다.')");
				out.println("location.href='viewDisPatient'");
				out.println("</script>");
			}
			
		} else if (set.equals("pName")) {
			String pName = item;
			int totalCount = mapper.selectCountPatientList_pName(pName);
			patient_1List_Item.setItem(item);
			patient_1List_Item.setTotalCount(totalCount);
			patient_1List_Item.calculator();
			patient_1List_Item.setPatient_1List_Item(mapper.selectPatientList_pNameForPaging(patient_1List_Item));
			request.setAttribute("patient_1List_Item", patient_1List_Item);
			request.setAttribute("category", category);
			request.setAttribute("set", set);
			return "disPatient/viewDisPatient";
	
		} else if (set.equals("pDisDate")) {
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date date = null;
			try {
				date = format.parse(item);
			} catch (ParseException e) {
				e.printStackTrace();

			}
			String dateToStr = format.format(date);
			int totalCount = mapper.selectCountPatientList_pDisDate(date);
			patient_1List_Item.setDate(date);
			patient_1List_Item.setItem(dateToStr);
			patient_1List_Item.setTotalCount(totalCount);
			patient_1List_Item.calculator();
			patient_1List_Item.setPatient_1List_Item(mapper.selectPatientList_pDisDateForPaging(patient_1List_Item));
			request.setAttribute("patient_1List_Item", patient_1List_Item);
			request.setAttribute("category", category);
			request.setAttribute("set", set);
			
			return "disPatient/viewDisPatient";
			
		} else {
			out.println("<script>");
			out.println("alert('잘못된 검색입니다.')");
			out.println("location.href='viewDisPatient'");
			out.println("</script>"); 
		}
		out.flush();
		out.close();
	} catch(IOException e) {
		e.printStackTrace();
	}
	return "";

  }

//	퇴원환자 조회 - 의무기록조회
	
	@RequestMapping("/viewDisPatientMedical")
	public String viewDisPatientMedical(HttpServletRequest request, Model model) {
		logger.info("컨트롤러의 viewDisPatientMedical()메소드 실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		
		AbstractApplicationContext ctx1 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");

		Date adDay = patientVO.getAdDate();
		Date disDay = patientVO.getDisDate();
		
		Date today = new Date();
		Date todayForm = new Date(today.getYear(), today.getMonth(), today.getDate());
		
		
		Date adDayForm = new Date(adDay.getYear(), adDay.getMonth(), adDay.getDate());	
		Date disDayForm = new Date(disDay.getYear(), disDay.getMonth(), disDay.getDate()); 
		
// ============================
		long sec = (disDayForm.getTime() - adDayForm.getTime()) / 1000;
		int dDay = ((int) sec / (24 * 60 * 60));
		long sec2 = (todayForm.getTime() - disDayForm.getTime()) / 1000;
		// 여기 -1 해야 정상작동 나중에 다시 확인해보기
		int dToDay = ((int) sec2 / (24 * 60 * 60) );
// ============================
		
		int diffDay = dDay;		// 퇴원환자용 

//		페이징 작업
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) { }
		

		int pageSize = 3;
		int totalCount = diffDay + 1;

		ViewMedicalList viewMedicalList = ctx1.getBean("viewMedicalList", ViewMedicalList.class);
		viewMedicalList.setCurrentPage(currentPage);
		viewMedicalList.setTotalCount(totalCount);
		viewMedicalList.setPageSize(pageSize);
		
		viewMedicalList.calculator();
		
		int startNo = viewMedicalList.getStartNo();
		int endNo = viewMedicalList.getEndNo();
	
		System.out.println( "curnpage" + currentPage);
		System.out.println( "total" + totalCount);
		System.out.println( "pagwSixe" + pageSize);
		System.out.println( "시작번호" + startNo);
		System.out.println( "끝번호" + endNo);
		
		ArrayList<Integer> arrayList = new ArrayList<Integer>();
		
		ArrayList<ViewMedicalVO> viewMedicalVOList1 = new ArrayList<ViewMedicalVO>();
		
		for (int subDay=0; subDay<=diffDay; subDay++) {
						
			AbstractApplicationContext ctx2 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("patientIdx", patientIdx);
			hmap.put("subDay", subDay + dToDay);
			
			ViewMedicalVO viewMedicalVO = ctx2.getBean("viewMedicalVO", ViewMedicalVO.class); 
			
			PrescriptionMed_4List prescriptionMedList = ctx2.getBean("prescriptionMedList", PrescriptionMed_4List.class);
			prescriptionMedList.setPrescriptionMedList(mapper.selectPrescriptionMedList_Menu(hmap));
			
			PrescriptionTest_5List prescriptionTestList = ctx2.getBean("prescriptionTestList", PrescriptionTest_5List.class);
			prescriptionTestList.setPrescriptionTestList(mapper.selectPrescriptionTestList_Menu(hmap));
			
			MedicalComment_7List medicalCommentList = ctx2.getBean("medicalCommentList", MedicalComment_7List.class);
			medicalCommentList.setMedicalCommentList(mapper.selectMediCommentList_Menu(hmap));
			
			viewMedicalVO.setPrescriptionMedList(prescriptionMedList);
			viewMedicalVO.setPrescriptionTestList(prescriptionTestList);
			viewMedicalVO.setMedicalCommentList(medicalCommentList);
			
			System.out.println(subDay + " :  " + viewMedicalVO);
			
			viewMedicalVOList1.add(viewMedicalVO);
			arrayList.add(subDay);
			
			System.out.println(subDay + " :  " + viewMedicalVOList1);
			System.out.println(subDay + " :  " + arrayList);
			System.out.println("-----------");
		}

		System.out.println("================");
		System.out.println(viewMedicalVOList1);
		System.out.println("================");
		
		ArrayList<ViewMedicalVO> viewMedicalVOList2 = new ArrayList<ViewMedicalVO>();
		
		for (int i=startNo; i<=endNo; i++) {
		
			viewMedicalVOList2.add(viewMedicalVOList1.get(i));
		}
		
		viewMedicalList.setViewMedicalVOList(viewMedicalVOList2);	

		System.out.println(viewMedicalVOList2);
		System.out.println(viewMedicalList);
		
		model.addAttribute("patientIdx", patientIdx);		
		model.addAttribute("patientVO", patientVO);		
		model.addAttribute("dDay", dDay);		
		
		model.addAttribute("viewMedicalList", viewMedicalList);
		model.addAttribute("enter", "\r\n");

		
		return "/disPatient/viewDisPatientMedical";
	}  
  
	
// 퇴원환자조회 - 간호기록조회	
	@RequestMapping("/viewDisPatientNursing")
	public String viewDisPatientNursing(HttpServletRequest request, Model model) {
		logger.info("컨트롤러의 viewDisPatientNursing()메소드 실행");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		
		AbstractApplicationContext ctx1 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");	
	
		Date adDay = patientVO.getAdDate();
		Date disDay = patientVO.getDisDate();
		
		Date today = new Date();
		Date todayForm = new Date(today.getYear(), today.getMonth() , today.getDate());
		
		
		Date adDayForm = new Date(adDay.getYear() , adDay.getMonth() , adDay.getDate());	
		Date disDayForm = new Date(disDay.getYear(), disDay.getMonth(), disDay.getDate()); 
		// ============================
		long sec = (disDayForm.getTime() - adDayForm.getTime()) / 1000;
		int dDay = ((int) sec / (24 * 60 * 60));
	
		long sec2 = (todayForm.getTime() - disDayForm.getTime()) / 1000;
		int dToDay = ((int) sec2 / (24 * 60 * 60));
		// ============================
				
		int diffDay = dDay;		// 퇴원환자용 
	
	//		페이징 작업
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) { }
	
		int pageSize = 3;
		int totalCount = diffDay + 1;
		
		ViewNursingList viewNursingList = ctx1.getBean("viewNursingList", ViewNursingList.class);
		viewNursingList.setCurrentPage(currentPage);
		viewNursingList.setTotalCount(totalCount);
		viewNursingList.setPageSize(pageSize);
	
		viewNursingList.calculator();
		
		int startNo = viewNursingList.getStartNo();
		int endNo = viewNursingList.getEndNo();
	
		VitalSign_10List vitalSignList = null;
		Injection_11List injectionList = null;
		NursingComment_13_List nursingCommentList = null;
		
		
		ArrayList<ViewNursingVO> viewNursingVOList1 = new ArrayList<ViewNursingVO>();
		
		for (int subDay=0; subDay<=diffDay; subDay++) {
		
			AbstractApplicationContext ctx2 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");	
			ViewNursingVO viewNursingVO = ctx2.getBean("viewNursingVO", ViewNursingVO.class); 
			
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("patientIdx", patientIdx);
			hmap.put("subDay", subDay + dToDay);
			
			vitalSignList = ctx2.getBean("vitalSignList", VitalSign_10List.class);
			vitalSignList.setVitalSignList(mapper.selectVitalSignList_Menu(hmap));
			
			injectionList = ctx2.getBean("injectionList", Injection_11List.class);
			injectionList.setInjectionList(mapper.selectInjectionList_Menu(hmap));
			
			nursingCommentList = ctx2.getBean("nursingCommentList", NursingComment_13_List.class);
			nursingCommentList.setNursingCommentList(mapper.selectNursingCommentList_Menu(hmap));
			
			
			viewNursingVO.setVitalSignList(vitalSignList);
			viewNursingVO.setInjectionList(injectionList);
			viewNursingVO.setNursingCommentList(nursingCommentList);
			
			viewNursingVOList1.add(viewNursingVO);	
			
		}
		
		ArrayList<ViewNursingVO> viewNursingVOList2 = new ArrayList<ViewNursingVO>();
		
		for (int i=startNo; i<=endNo; i++) {
		
			viewNursingVOList2.add(viewNursingVOList1.get(i));
			
		}
		
		viewNursingList.setViewNursingVOList(viewNursingVOList2);
	
		model.addAttribute("patientIdx", patientIdx);		
		model.addAttribute("patientVO", patientVO);		
		model.addAttribute("dDay", dDay);		
		
		model.addAttribute("viewNursingList", viewNursingList);
		model.addAttribute("enter", "\r\n");
		
		return "/disPatient/viewDisPatientNursing";
		
	} 
  
  
//	퇴원환자 검사 결과 조회
	@RequestMapping("/viewDisPatientTest")
	public String viewDisPatientTest(HttpServletRequest request, Model model) {
		logger.info("viewDisPatientTest()");
		//	퇴원 환자 정보 
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		request.setAttribute("patientVO", patientVO);
		

		
		return "disPatient/viewDisPatientTest";
	}
	
//	퇴원환자 검사 결과 조회 
	@RequestMapping("/viewDisPatientTestMiddle")
	public String viewDisPatientTestMiddle(HttpServletRequest request, Model model) {
		logger.info("viewDisPatientTestMiddle()");
		//	퇴원 환자 정보 
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		//	logger.info(patientIdx + "");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		request.setAttribute("patientVO", patientVO);
		
		Date adDay = patientVO.getAdDate();
		Date disDay = patientVO.getDisDate();
		
		Date today = new Date();
		Date todayForm = new Date(today.getYear() , today.getMonth(), today.getDate());
		
		
		Date adDayForm = new Date(adDay.getYear() , adDay.getMonth(), adDay.getDate());	
		Date disDayForm = new Date(disDay.getYear() , disDay.getMonth(), disDay.getDate()); 
		
		long sec = (disDayForm.getTime() - adDayForm.getTime()) / 1000;
		int dDay = ((int) sec / (24 * 60 * 60));
	
		long sec2 = (todayForm.getTime() - disDayForm.getTime()) / 1000;
		int dToDay = ((int) sec2 / (24 * 60 * 60));
				
		int diffDay = dDay;		// 퇴원환자용 
		
//		리턴할 테스트 리스트 생성
		ViewTestList viewTestList = ctx.getBean("viewTestList", ViewTestList.class);
//		검사 결과 조회 선택 
		String test = request.getParameter("test");
		//	logger.info(test);
			
		int currentPage = 1;
		int pageSize = 3;
		// 페이지 넘길떄 여기 안넘어감 
		if (test.equals("blood")) {
			//	logger.info("혈액검사 결과 조회");
			int totalCount = mapper.countTestBloodList(patientIdx);
			logger.info(totalCount + "");
			logger.info(request.getParameter("currentPage") + "-currentPage");
			
			if (request.getParameter("currentPage") != null) {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}

			
			viewTestList.setCurrentPage(currentPage);
			viewTestList.setTotalCount(totalCount);
			viewTestList.setPageSize(pageSize);
			
			viewTestList.calculator();
			//	logger.info(testBloodList + "");
			
			if (request.getParameter("currentPage") == null) {
				viewTestList.setStartNo(0);
			}
			
			ArrayList<TestBlood_17VO> testBloodListPage = mapper.selectBloodTest(patientIdx);
			//	logger.info(testBloodListPage + "");
			//	logger.info(testBloodListPage.get(0) + "");
			ArrayList<TestBlood_17VO> testBloodListP = new ArrayList<TestBlood_17VO>();
			
			int startNo = viewTestList.getStartNo();
			int endNo = viewTestList.getEndNo();

			for (int i = startNo; i <= endNo; i++) {
				testBloodListP.add(testBloodListPage.get(i));
			}
			viewTestList.setTestBloodList(testBloodListP);
			viewTestList.setTest(test);
			logger.info(viewTestList + "");
			model.addAttribute("viewTestList", viewTestList);
			request.setAttribute("blood", test);
			
		}  else { 
			//	logger.info("소변검사 결과 조회");
			
				int totalCount = mapper.countTestUrineList(patientIdx);
				logger.info(totalCount + "");
				logger.info(request.getParameter("currentPage") + "-currentPage");
				
				if (request.getParameter("currentPage") != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}

				
				viewTestList.setCurrentPage(currentPage);
				viewTestList.setTotalCount(totalCount);
				viewTestList.setPageSize(pageSize);
				
				viewTestList.calculator();
				//	logger.info(testBloodList + "");
				if (request.getParameter("currentPage") == null) {
					viewTestList.setStartNo(0);
				}
				ArrayList<TestUrine_21VO> testUrineListPage = mapper.selectUrineTest(patientIdx);
				//	logger.info(testUrineListPage + "");
				//	logger.info(testUrineListPage.get(0) + "");
				ArrayList<TestUrine_21VO> testUrineListP = new ArrayList<TestUrine_21VO>();
				
				int startNo = viewTestList.getStartNo();
				int endNo = viewTestList.getEndNo();

				for (int i = startNo; i <= endNo; i++) {
					testUrineListP.add(testUrineListPage.get(i));
				}
				viewTestList.setTestUrineList(testUrineListP);
				viewTestList.setTest(test);
				logger.info(viewTestList + "");
				model.addAttribute("viewTestList", viewTestList);
				request.setAttribute("urine", test);
				
		}
		
		model.addAttribute("patientIdx", patientIdx);	
		model.addAttribute("dDay", dDay);	
		
		return "disPatient/viewDisPatientTest";
	}
	
//	퇴원환자 환자 정보 조회
	@RequestMapping("/viewDisPatientData")
	public String viewDisPatientData(HttpServletRequest request, Model model) {
		
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		Patient_1VO patientVo = mapper.selectPatient(patientIdx);
		model.addAttribute("patientVo", patientVo);
		
		return "disPatient/viewDisPatientData";
	}
	
	
	

}
