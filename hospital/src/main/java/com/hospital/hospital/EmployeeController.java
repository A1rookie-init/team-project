package com.hospital.hospital;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.hospital.vo.Dpart_23List;
import com.hospital.vo.Employee_20List;
import com.hospital.vo.Employee_20VO;
import com.hospital.vo.ScheduleN_d_24VO;
import com.hospital.vo.ScheduleN_e_25VO;
import com.hospital.vo.ScheduleN_n_26VO;

@Controller
public class EmployeeController {

	private static final Logger logger = LoggerFactory.getLogger(EmployeeController.class);
	
	@Autowired
	private SqlSession sqlSession;


// < 사내검색 > 
	
	@RequestMapping("/viewSearchEmployee")
	public String viewSearchEmployee(HttpServletRequest request, Model model) {
		logger.info("viewSearchEmployee()");
		return "viewSearchEmployee";
	}

	@RequestMapping("/viewSearchEmployeeAfter")
	public String viewSearchEmployeeAfter(HttpServletRequest request, Model model, HttpServletResponse response) {
		logger.info("viewSearchEmployeeAfter()");

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		String item = request.getParameter("item").trim();
		String set = request.getParameter("set");
		int currentPage = 1;

		if (item == null || item.equals("")) {
			Alert.alertAndBack(response, "검색어를 입력하세요");
		} else if (set == null || set.equals("")) {
			Alert.alertAndBack(response, "검색할 항목을 선택하세요");
		} else {
			
			if (set.equals("eName")) {
				
				try {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				} catch (NumberFormatException e) {
				}
				
				int pageSize = 10;
				int totalCount = mapper.selectCountEmpListByName(item);	
				
				AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
				Employee_20List employeeList = ctx.getBean("employeeList", Employee_20List.class);
				employeeList.setItem(item);
				employeeList.setCurrentPage(currentPage);
				employeeList.setPageSize(pageSize);
				employeeList.setTotalCount(totalCount);
				employeeList.calculator();
				
				employeeList.setEmployeeList(mapper.selectEmpListByNameForPaging(employeeList));
				
				model.addAttribute("employeeList", employeeList);
				model.addAttribute("set", set);
	
			} else if (set.equals("pName")) {
	
				currentPage = 1;
				try {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				} catch (NumberFormatException e) {
				}
				
				int pageSize = 10;
				int totalCount = mapper.selectCountDpartListByName(item);	
				
				AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
				
				Dpart_23List dpartList = ctx.getBean("dpartList", Dpart_23List.class);
				dpartList.setItem(item);
				dpartList.setCurrentPage(currentPage);
				dpartList.setPageSize(pageSize);
				dpartList.setTotalCount(totalCount);
				dpartList.calculator();
				
				dpartList.setDpartList(mapper.selectDpartListByNameForPaging(dpartList));
				
				model.addAttribute("dpartList", dpartList);
				model.addAttribute("set", set);
			}
		}
		return "viewSearchEmployee";
	}
	
	
	
//	< 마이페이지 >	
	@RequestMapping("/viewMyInfo")
	public String viewMyInfo(HttpServletRequest request, Model model, HttpSession session) {
		logger.info("employee컨트롤러의 viewMyInfo() 실행");
		
		int employeeIdx = Integer.parseInt((String) session.getAttribute("employeeIdx"));
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		Employee_20VO employeeVO = mapper.selectEmployee(employeeIdx);
//		VO를 넘기게 되면서 img파일명 따로 빼내올 필요 없어짐
		model.addAttribute("employeeVO", employeeVO);
		return "myPage/viewMyInfo";
	
	}

	
//	마이페이지: 프로필 사진 업로드 ( 저장위치 C:/Upload/profile )
	@RequestMapping("/profileUpload")
	public String profileUpload(HttpServletResponse response, MultipartHttpServletRequest request, Employee_20VO employee_20VO) throws IOException {
		logger.info("employee컨트롤러의 profileUpload() 메소드 실행");

		String rootUploadDir = "C:" + File.separator + "Upload"; 
		File dir = new File(rootUploadDir + File.separator + "profile"); 

		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		Iterator<String> iterator = request.getFileNames();
		String profileImg = "";  // type = file 파라미터명
		String orgFileName = ""; // 원래 파일명 & 저장 파일명
		MultipartFile multipartFile = null;
		
		// 파일업로드시 해당 파일명이 이미 있을경우 (1) 붙는 기능없음. 덮어씌워짐. 필요하면 제어문or구글에나온방식으로 별도 구현할것. 불필요해보임.

		if (iterator.hasNext()) {   // 파일1개라서 while안쓰고 if문 썼음.
			profileImg = iterator.next();  
			multipartFile = request.getFile(profileImg);
			orgFileName = multipartFile.getOriginalFilename();  
			System.out.println(orgFileName);
		}

		
		if (orgFileName != null && orgFileName.length() != 0) {
		
			
			String orgFileName2 = orgFileName;
			int i = 1;
			while (new File("C:" + File.separator + "Upload" + File.separator + "profile" + File.separator + orgFileName2).exists()) {
				int index = orgFileName2.lastIndexOf(".");
				String prefix = orgFileName2.substring(0, index);
				String suffix = orgFileName2.substring(index);
				orgFileName2 = prefix + "(" + i + ")" + suffix;
				
			}
	       
			String savedFileName = orgFileName2;
			
			
			try {
				multipartFile.transferTo(new File(dir + File.separator + savedFileName)); 
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				// savedFileName 은 실제저장파일명
				// 추후 코드 변경 들어가다보니 뷰페이지 변경할게 많아서 그냥 orgFileName 컬럼에도 실제저장파일명을 담아버림.
				// 결국 employee테이블에서 savedFileName 컬럼은 사용안함. 
				employee_20VO.setOrgFileName(savedFileName);
				out.println("<script>alert('업로드 완료')</script>");
				out.println("<script>location.href='viewMyInfo'</script>");
				out.flush();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		System.out.println(employee_20VO.getPassword());
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		mapper.updateEmployee(employee_20VO);
		
		return "redirect:viewMyInfo";
	}

	
// 마이페이지: My 팀스케줄

//	My 팀 월별 스케줄 조회
	@RequestMapping("/viewMyCalendar")
	public String viewTeamCalendar(HttpServletRequest request, Model model) {
		logger.info("employee 컨트롤러의 viewMyCalendar()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
		String dpart = (String)session.getAttribute("dpart");
		
		// 의사
		if (dpart.equals("의사")) {
			ArrayList<Employee_20VO> employeeList = null;
			String team = (String)session.getAttribute("doctorT");
			employeeList = mapper.selectEmpListByDTeam(team);
			model.addAttribute("employeeList", employeeList);
			return "myPage/viewMyCalendarD"; 	// 미구현 상태 
		
		// 간호사
		} else if(dpart.equals("간호사")) {
			
			// 한팀에 간호사는 팀원 5명으로 고정
			String team = (String)session.getAttribute("nurseT");
			ArrayList<Employee_20VO> employeeList = new ArrayList<Employee_20VO>();
			// 과장급(team = D)은 admin, adminMain에서 스케줄관련인덱스페이지 안보이게 if문걸어둠.
			if (team.equals("D")) {
				team = "A";
			}
			ArrayList<Employee_20VO> empList = mapper.selectEmpListByNTeamNotAdmin(team);
			for (int i = 0; i< 5; i++) {
				employeeList.add(empList.get(i));
			}
			
			model.addAttribute("employeeList", employeeList);
			
			// 현재 날짜
			Calendar calendar = Calendar.getInstance();
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH) + 1;

			try {
				year = Integer.parseInt(request.getParameter("yearBA"));
				month = Integer.parseInt(request.getParameter("monthBA"));
				if (month >= 13) {
					year++;
					month = 1;
				} else if (month <= 0) {
					year--;
					month = 12;
				}
			} catch (NumberFormatException e) { }	
			
			// 현재 날짜2 
			int yearC = calendar.get(Calendar.YEAR);
			int monthC = calendar.get(Calendar.MONTH) + 1;
			
			request.setAttribute("yearA", year);
			request.setAttribute("monthA", month);
			model.addAttribute("year", year);
			model.addAttribute("month", month);
			model.addAttribute("yearC", yearC);
			model.addAttribute("monthC", monthC);

			// 스케줄 조회하기 (db에 저장된 해당 팀의 월스케줄을 불러온다)
			// 스케줄IDX: YYMMT
			String idx = String.valueOf(year).substring(2) + String.format("%02d", month) + team;
			
			ScheduleN_d_24VO scheduleN_dVO = mapper.selectScheduleNDay(idx);
			ScheduleN_e_25VO scheduleN_eVO = mapper.selectScheduleNEven(idx);
			ScheduleN_n_26VO scheduleN_nVO = mapper.selectScheduleNNig(idx);
			
			request.setAttribute("dayVO", scheduleN_dVO);
			request.setAttribute("evenVO", scheduleN_eVO);
			request.setAttribute("nigVO", scheduleN_nVO);
			
			return "myPage/viewMyCalendarN";
			
		// 병리사, 원무과 : 미구현
		} else {
			ArrayList<Employee_20VO> employeeList = null;
			employeeList = mapper.selectEmpListBydpart(dpart);
			model.addAttribute("employeeList", employeeList);
			return "myPage/viewMyCalendarAP";	// 미구현 상태 
		}
		
	}
	
	
}
