package com.hospital.hospital;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.NoticeToD_2VO;
import com.hospital.vo.NoticeToN_8VO;
import com.hospital.vo.Patient_1VO;
import com.hospital.vo.TestBlood_17VO;
import com.hospital.vo.TestUrine_21VO;

// 파일다운로드 컨트롤러

@Controller
public class DownExcelController {
	
	private static final Logger logger = LoggerFactory.getLogger(DownExcelController.class);

	@Autowired
	private SqlSession sqlSession;

	
// 검사결과보고알림발송 의사 (ajax버젼)
	@ResponseBody
	@RequestMapping (value = "/insertNoticeToDFromPAjax", method = RequestMethod.POST)
	public String insertNoticeToDFromPAjax(HttpServletRequest request, @RequestBody NoticeToD_2VO noticeToD_2VO) {
		logger.info("insertNoticeToDFromPAjax()");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.insertNoticeToD(noticeToD_2VO);
		return "success";
	}
//	검사결과보고알림발송 간호사 (ajax버젼)
	@ResponseBody
	@RequestMapping (value = "/insertNoticeToNFromPAjax", method = RequestMethod.POST)
	public String insertNoticeToNFromPAjax(HttpServletRequest request, @RequestBody NoticeToN_8VO noticeToN_8VO) {
		logger.info("insertNoticeToNFromPAjax()");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.insertNoticeToN(noticeToN_8VO);
		return "success";
	}

//	혈액검사결과 db에 저장 & 결과보고알림발송 & 혈액검사 엑셀파일 저장 
	@RequestMapping ("/testbloodresult")
	public String testbloodresult(HttpServletRequest request, Model model, HttpServletResponse response, TestBlood_17VO testBloodVO, NoticeToD_2VO noticeToDVO, NoticeToN_8VO noticeToNVO) throws IOException {
		logger.info("testbloodresult()");
		//	직원 정보 받기
		HttpSession session = request.getSession();
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		//	환자 정보 받기
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		
		// 혈액 검사 결과를 저장
		mapper.insertTestBlood(testBloodVO);
		
/* 검사결과보고 구버젼---------------------------------------------------------		
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
		Alert.alertAndGo(response, "To. 의사, 간호사  " + patientVO.getName() +"님의 검사 결과 등록 알림이 발송되었습니다.", "viewPatientDetail?patientIdx=" + patientIdx + "&dDay=" + dDay);
//-----------------------------------------------------------------------------------------	
*/	
		
// < 엑셀파일 저장 >		
    // 파일경로: C:/Upload/testfile/excelfile/ 
    	logger.info("download컨트롤러의 downTestReport");
		
		String name = patientVO.getName();
		int age = patientVO.getAge();
		String gender = patientVO.getGender();
		String diagnosis = patientVO.getDiagnosis();
		
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);
		
    	// .xls 확장자 지원

		// HSSFWorkbook hssWb = null;
		// HSSFSheet hssSheet = null;
		// Row hssRow = null;
		// Cell hssCell = null;
		
		//.xlsx 확장자 지원
		
		XSSFWorkbook xssfWb = null; 
		XSSFSheet xssfSheet = null; 
		XSSFRow xssfRow = null; 
		XSSFCell xssfCell = null;
			
		try {
			int rowNo = 0; 	// 행의 갯수 
	
			xssfWb = new XSSFWorkbook(); //XSSFWorkbook 객체 생성
			xssfSheet = xssfWb.createSheet("혈액검사결과"); // 워크시트 이름 설정
			
			// 폰트 스타일
			XSSFFont font = xssfWb.createFont();
			font.setFontName(HSSFFont.FONT_ARIAL); // 폰트 스타일
			font.setFontHeightInPoints((short)20); // 폰트 크기
			font.setBold(true); // Bold 설정
			font.setColor(new XSSFColor(Color.decode("#323C73"))); // 폰트 색 지정
			
			// 셀 스타일
			CellStyle cellStyle = xssfWb.createCellStyle();
			xssfSheet.setColumnWidth(0, (xssfSheet.getColumnWidth(0))+(short)2048); // 0번째 컬럼 넓이 조절
			
			cellStyle.setFont(font); // cellStyle에 font를 적용
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 정렬

			//셀병합
			xssfSheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 2)); //첫행, 마지막행, 첫열, 마지막열 병합
			xssfSheet.addMergedRegion(new CellRangeAddress(13, 13, 0, 2)); 
			xssfSheet.addMergedRegion(new CellRangeAddress(14, 14, 0, 2)); 
			
			// 타이틀 행 생성
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle); // 셀에 스타일 지정
			xssfCell.setCellValue(" " + name + " (" + age + "/" + gender + ") " + diagnosis); // 첫행 데이터 입력
			
			xssfSheet.createRow(rowNo++);
			xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가
			
			// 폰트 스타일2
			XSSFFont font2 = xssfWb.createFont();
			font2.setFontName(HSSFFont.FONT_ARIAL); // 폰트 스타일
			font2.setFontHeightInPoints((short)12); // 폰트 크기
			font2.setBold(true); // Bold 설정
			font2.setColor(new XSSFColor(Color.decode("#000000"))); // 폰트 색 지정
			
			// 셀 스타일2
			CellStyle cellStyle2 = xssfWb.createCellStyle();
			cellStyle2.setFont(font2); // cellStyle에 font를 적용
			cellStyle2.setAlignment(HSSFCellStyle.ALIGN_RIGHT); // 정렬
			
			// 폰트 스타일3
			XSSFFont font3 = xssfWb.createFont();
			font3.setFontName(HSSFFont.FONT_ARIAL); // 폰트 스타일
			font3.setFontHeightInPoints((short)12); // 폰트 크기
			font3.setBold(true); // Bold 설정
			font3.setColor(new XSSFColor(Color.decode("#000000"))); // 폰트 색 지정
			
			// 셀 스타일3
			CellStyle cellStyle3 = xssfWb.createCellStyle();
			cellStyle3.setFont(font3); // cellStyle에 font를 적용
			cellStyle3.setAlignment(HSSFCellStyle.ALIGN_LEFT); // 정렬
			
			// 부제목 행 생성
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle3); // 셀에 스타일 지정
			xssfCell.setCellValue("혈액검사 결과"); // 첫행 데이터 입력
			
		
			//테이블 스타일 설정
			CellStyle tableCellStyle = xssfWb.createCellStyle();
			tableCellStyle.setBorderTop((short) 5);    // 테두리 위쪽
			tableCellStyle.setBorderBottom((short) 5); // 테두리 아래쪽
			tableCellStyle.setBorderLeft((short) 5);   // 테두리 왼쪽
			tableCellStyle.setBorderRight((short) 5);  // 테두리 오른쪽
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("WBC");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testBloodVO.getWBC());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("mm3");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("Hb");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testBloodVO.getHb());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("g/dl");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("Hct");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testBloodVO.getHct());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("%");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("RBC");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testBloodVO.getRBC());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("mm3");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("MCV");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testBloodVO.getMCV());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("fl");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("MCH");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testBloodVO.getMCH());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("pg");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("MCHC");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testBloodVO.getMCHC());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("g/dl");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("Platelet");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testBloodVO.getPlatelet());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("mm3");
			
			xssfSheet.createRow(rowNo++);  //빈행추가
			
			TestBlood_17VO recentBloodVO = mapper.selectBloodTestIdx(patientIdx);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  hh:mm");
			
			String reportDate = sdf.format(recentBloodVO.getWriteDate());

			// 마지막 행 2개
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle2); // 셀에 스타일 지정
			xssfCell.setCellValue(" 검사일 : " + reportDate ); // 첫행 데이터 입력
			
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle2); // 셀에 스타일 지정
			xssfCell.setCellValue(" 검사자 : " + recentBloodVO.getEmployeeName()); // 첫행 데이터 입력
			
	    	String uploadPath = "C:" + File.separator + "Upload" + File.separator + "testfile";
	    	
			File dir = new File(uploadPath + File.separator + "excelfile"); 

			if (!dir.exists()) {
				dir.mkdirs();
			}
	    	
	    	String saveFileName = patientIdx + "_blood_" + recentBloodVO.getIdx()  + ".xlsx"; // 엑셀파일명
	    	File downloadFile = new File(dir + File.separator + saveFileName);
			
			FileOutputStream fos = null;
			fos = new FileOutputStream(downloadFile);
			xssfWb.write(fos);
	
			if (fos != null) fos.close();
		}catch(Exception e){
	        	
		}
 	
    	return "redirect:viewTest";
    }    

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
		
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		
		// 소변 검사 결과를 저장
		mapper.insertTestUrine(testUrineVO);
		
		/* 검사 결과 보고 구버전 ===================================================
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
		Alert.alertAndGo(response, "To. 의사, 간호사  " + patientVO.getName() +"님의 검사 결과 등록 알림이 발송되었습니다.", "viewPatientDetail?patientIdx=" + patientIdx + "&dDay=" + dDay);
		 ============================================================================= */
		
// 엑셀파일저장		
	    // 파일경로: C:/Upload/testfile/excelfile/ 
    	logger.info("download컨트롤러의 downTestReport");
    	
		String name = patientVO.getName();
		int age = patientVO.getAge();
		String gender = patientVO.getGender();
		String diagnosis = patientVO.getDiagnosis();
		
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);
		
		// .xls 확장자 지원

		// HSSFWorkbook hssWb = null;
		// HSSFSheet hssSheet = null;
		// Row hssRow = null;
		// Cell hssCell = null;
		
		//.xlsx 확장자 지원
		
		XSSFWorkbook xssfWb = null; 
		XSSFSheet xssfSheet = null; 
		XSSFRow xssfRow = null; 
		XSSFCell xssfCell = null;
			
		try {
			int rowNo = 0; // 행의 갯수 
	
			xssfWb = new XSSFWorkbook(); //XSSFWorkbook 객체 생성
			xssfSheet = xssfWb.createSheet("소변검사결과"); // 워크시트 이름 설정
			
			// 폰트 스타일
			XSSFFont font = xssfWb.createFont();
			font.setFontName(HSSFFont.FONT_ARIAL); // 폰트 스타일
			font.setFontHeightInPoints((short)20); // 폰트 크기
			font.setBold(true); // Bold 설정
			font.setColor(new XSSFColor(Color.decode("#323C73"))); // 폰트 색 지정
			
			// 셀 스타일
			CellStyle cellStyle = xssfWb.createCellStyle();
			xssfSheet.setColumnWidth(0, (xssfSheet.getColumnWidth(0))+(short)2048); // 0번째 컬럼 넓이 조절
			
			cellStyle.setFont(font); // cellStyle에 font를 적용
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 정렬

			//셀병합
			xssfSheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 2)); //첫행, 마지막행, 첫열, 마지막열 병합
			xssfSheet.addMergedRegion(new CellRangeAddress(17, 17, 0, 2)); 
			xssfSheet.addMergedRegion(new CellRangeAddress(18, 18, 0, 2)); 
			
			// 타이틀 행 생성
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle); // 셀에 스타일 지정
			xssfCell.setCellValue(" " + name + " (" + age + "/" + gender + ") " + diagnosis); // 첫행 데이터 입력
			
			xssfSheet.createRow(rowNo++);
			xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가
			
			// 폰트 스타일2
			XSSFFont font2 = xssfWb.createFont();
			font2.setFontName(HSSFFont.FONT_ARIAL); // 폰트 스타일
			font2.setFontHeightInPoints((short)12); // 폰트 크기
			font2.setBold(true); // Bold 설정
			font2.setColor(new XSSFColor(Color.decode("#000000"))); // 폰트 색 지정
			
			// 셀 스타일2
			CellStyle cellStyle2 = xssfWb.createCellStyle();
			cellStyle2.setFont(font2); // cellStyle에 font를 적용
			cellStyle2.setAlignment(HSSFCellStyle.ALIGN_RIGHT); // 정렬
			
			// 폰트 스타일3
			XSSFFont font3 = xssfWb.createFont();
			font3.setFontName(HSSFFont.FONT_ARIAL); // 폰트 스타일
			font3.setFontHeightInPoints((short)12); // 폰트 크기
			font3.setBold(true); // Bold 설정
			font3.setColor(new XSSFColor(Color.decode("#000000"))); // 폰트 색 지정
			
			// 셀 스타일3
			CellStyle cellStyle3 = xssfWb.createCellStyle();
			cellStyle3.setFont(font3); // cellStyle에 font를 적용
			cellStyle3.setAlignment(HSSFCellStyle.ALIGN_LEFT); // 정렬
			
			// 부제목 행 생성
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle3); // 셀에 스타일 지정
			xssfCell.setCellValue("소변검사 결과"); // 첫행 데이터 입력
			
		
			//테이블 스타일 설정
			CellStyle tableCellStyle = xssfWb.createCellStyle();
			tableCellStyle.setBorderTop((short) 5);    // 테두리 위쪽
			tableCellStyle.setBorderBottom((short) 5); // 테두리 아래쪽
			tableCellStyle.setBorderLeft((short) 5);   // 테두리 왼쪽
			tableCellStyle.setBorderRight((short) 5);  // 테두리 오른쪽
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("색깔");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getColor());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("혼탁도");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getTurbidity());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("비중");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getGravity());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("산도");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getAcidity());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("알부민");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getAlbumin());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("mg/dl");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("포도당");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getGlucose());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("mg/dl");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("케톤");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getKetones());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("mg/dl");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("빌리루빈");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getBilirubin());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("mg/dl");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("잠혈");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getBlood());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("㎕");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("유로빌리로겐");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getBilinogen());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("mg/dl");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("나이트리트");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getNitrite());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("mm3");
			
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("백혈구");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("" + testUrineVO.getLeukocyte());
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("㎕");
			
			xssfSheet.createRow(rowNo++);	//빈행추가
			
			TestUrine_21VO recentUrineVO = mapper.selectUrineTestIdx(patientIdx);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  hh:mm");
			
			String reportDate = sdf.format(recentUrineVO.getWriteDate());
			
			// 마지막 행 2개 
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle2); // 셀에 스타일 지정
			xssfCell.setCellValue(" 검사일 : " + reportDate ); // 첫행 데이터 입력
			
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle2); // 셀에 스타일 지정
			xssfCell.setCellValue(" 검사자 : " + recentUrineVO.getEmployeeName()); // 첫행 데이터 입력
			
	    	String uploadPath = "C:" + File.separator + "Upload" + File.separator + "testfile" + File.separator + "excelfile" + File.separator;
	    	String saveFileName = patientIdx + "_urine_" + recentUrineVO.getIdx()  + ".xlsx"; // 엑셀파일명
	    	File downloadFile = new File(uploadPath + saveFileName);
						
			FileOutputStream fos = null;
			fos = new FileOutputStream(downloadFile);
			xssfWb.write(fos);
	
			if (fos != null) fos.close();
		}catch(Exception e){
	        	
		}
		
		return "redirect:viewTest";

	}	
	
    
    // 파일경로: C:/Upload/testfile/excelfile/ 
    @RequestMapping("/downTestReport")
    public String downTestReport(HttpServletRequest request, HttpServletResponse response, Model model) {
    	logger.info("download컨트롤러의 downTestReport");
    	
    	
		int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
		int dDay = Integer.parseInt(request.getParameter("dDay"));
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		Patient_1VO patientVO = mapper.selectPatient(patientIdx);
		
		String name = patientVO.getName();
		int age = patientVO.getAge();
		String gender = patientVO.getGender();
		String diagnosis = patientVO.getDiagnosis();
		
		model.addAttribute("patientIdx", patientIdx);
		model.addAttribute("dDay", dDay);
		
				// .xls 확장자 지원
				
				// HSSFWorkbook hssWb = null;
				// HSSFSheet hssSheet = null;
				// Row hssRow = null;
				// Cell hssCell = null;
				
				//.xlsx 확장자 지원
    			
    			XSSFWorkbook xssfWb = null; 
    			XSSFSheet xssfSheet = null; 
    			XSSFRow xssfRow = null; 
    			XSSFCell xssfCell = null;
    				
    			try {
    				int rowNo = 0; // 행의 갯수 
    		
    				xssfWb = new XSSFWorkbook(); //XSSFWorkbook 객체 생성
    				xssfSheet = xssfWb.createSheet("워크 시트1"); // 워크시트 이름 설정
    				
    				// 폰트 스타일
    				XSSFFont font = xssfWb.createFont();
    				font.setFontName(HSSFFont.FONT_ARIAL); // 폰트 스타일
    				font.setFontHeightInPoints((short)20); // 폰트 크기
    				font.setBold(true); // Bold 설정
    				font.setColor(new XSSFColor(Color.decode("#457ba2"))); // 폰트 색 지정
    				
    				//테이블 셀 스타일
    				CellStyle cellStyle = xssfWb.createCellStyle();
    				xssfSheet.setColumnWidth(0, (xssfSheet.getColumnWidth(0))+(short)2048); // 0번째 컬럼 넓이 조절
    				
    				cellStyle.setFont(font); // cellStyle에 font를 적용
    				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 정렬

    				//셀병합
    				xssfSheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 4)); //첫행, 마지막행, 첫열, 마지막열 병합
    				
    				// 타이틀 생성
    				xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
    				xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
    				xssfCell.setCellStyle(cellStyle); // 셀에 스타일 지정
    				xssfCell.setCellValue(" " + name + " (" + age + "/" + gender + ") " + diagnosis); // 첫행 데이터 입력
    				
    				
    				
    				xssfSheet.createRow(rowNo++);
    				xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가
    				
    				//테이블 스타일 설정
    				CellStyle tableCellStyle = xssfWb.createCellStyle();
    				tableCellStyle.setBorderTop((short) 5);    // 테두리 위쪽
    				tableCellStyle.setBorderBottom((short) 5); // 테두리 아래쪽
    				tableCellStyle.setBorderLeft((short) 5);   // 테두리 왼쪽
    				tableCellStyle.setBorderRight((short) 5);  // 테두리 오른쪽
    				
    				xssfRow = xssfSheet.createRow(rowNo++);
    				xssfCell = xssfRow.createCell((short) 0);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀1");
    				xssfCell = xssfRow.createCell((short) 1);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀2");
    				xssfCell = xssfRow.createCell((short) 2);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("mm3");
    				xssfCell = xssfRow.createCell((short) 3);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀4");
    				xssfCell = xssfRow.createCell((short) 4);
    				xssfCell.setCellStyle(tableCellStyle);
    				
    				xssfRow = xssfSheet.createRow(rowNo++);
    				xssfCell = xssfRow.createCell((short) 0);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀1");
    				xssfCell = xssfRow.createCell((short) 1);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀2");
    				xssfCell = xssfRow.createCell((short) 2);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("g/dl");
    				xssfCell = xssfRow.createCell((short) 3);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀4");
    				xssfCell = xssfRow.createCell((short) 4);
    				xssfCell.setCellStyle(tableCellStyle);
    				
    				xssfRow = xssfSheet.createRow(rowNo++);
    				xssfCell = xssfRow.createCell((short) 0);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀1");
    				xssfCell = xssfRow.createCell((short) 1);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀2");
    				xssfCell = xssfRow.createCell((short) 2);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("%");
    				xssfCell = xssfRow.createCell((short) 3);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀4");
    				xssfCell = xssfRow.createCell((short) 4);
    				xssfCell.setCellStyle(tableCellStyle);
    				
    				
    				xssfRow = xssfSheet.createRow(rowNo++);
    				xssfCell = xssfRow.createCell((short) 0);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀1");
    				xssfCell = xssfRow.createCell((short) 1);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀2");
    				xssfCell = xssfRow.createCell((short) 2);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("mm3");
    				xssfCell = xssfRow.createCell((short) 3);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀4");
    				xssfCell = xssfRow.createCell((short) 4);
    				xssfCell.setCellStyle(tableCellStyle);
    				
    				xssfRow = xssfSheet.createRow(rowNo++);
    				xssfCell = xssfRow.createCell((short) 0);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀1");
    				xssfCell = xssfRow.createCell((short) 1);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀2");
    				xssfCell = xssfRow.createCell((short) 2);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("fl");
    				xssfCell = xssfRow.createCell((short) 3);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀4");
    				xssfCell = xssfRow.createCell((short) 4);
    				xssfCell.setCellStyle(tableCellStyle);
    				
    				xssfRow = xssfSheet.createRow(rowNo++);
    				xssfCell = xssfRow.createCell((short) 0);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀1");
    				xssfCell = xssfRow.createCell((short) 1);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀2");
    				xssfCell = xssfRow.createCell((short) 2);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("pg");
    				xssfCell = xssfRow.createCell((short) 3);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀4");
    				xssfCell = xssfRow.createCell((short) 4);
    				xssfCell.setCellStyle(tableCellStyle);
    				
    				xssfRow = xssfSheet.createRow(rowNo++);
    				xssfCell = xssfRow.createCell((short) 0);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀1");
    				xssfCell = xssfRow.createCell((short) 1);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀2");
    				xssfCell = xssfRow.createCell((short) 2);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("g/dl");
    				xssfCell = xssfRow.createCell((short) 3);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀4");
    				xssfCell = xssfRow.createCell((short) 4);
    				xssfCell.setCellStyle(tableCellStyle);
    				
    				xssfRow = xssfSheet.createRow(rowNo++);
    				xssfCell = xssfRow.createCell((short) 0);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀1");
    				xssfCell = xssfRow.createCell((short) 1);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀2");
    				xssfCell = xssfRow.createCell((short) 2);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("mm3");
    				xssfCell = xssfRow.createCell((short) 3);
    				xssfCell.setCellStyle(tableCellStyle);
    				xssfCell.setCellValue("셀4");
    				xssfCell = xssfRow.createCell((short) 4);
    				xssfCell.setCellStyle(tableCellStyle);
    				
        	    	String uploadPath = "C:" + File.separator + "Upload" + File.separator + "testfile" + File.separator + "excelfile" + File.separator;
        	    	String saveFileName = patientIdx + ".xlsx"; // 엑셀파일명
        	    	File downloadFile = new File(uploadPath + saveFileName);
    				
    				FileOutputStream fos = null;
    				fos = new FileOutputStream(downloadFile);
    				xssfWb.write(fos);
    		
    				if (fos != null) fos.close();
    			}catch(Exception e){
    		        	
    			}
    	
    	return "redirect:viewTest";
    }    
    
    
    
    
}
