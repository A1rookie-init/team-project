package com.hospital.hospital;

import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hospital.calendar.MyCalendar;
import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.Employee_20VO;
import com.hospital.vo.ScheduleN_d_24VO;
import com.hospital.vo.ScheduleN_e_25VO;
import com.hospital.vo.ScheduleN_n_26VO;

@Controller
public class ManagerController {

	private static final Logger logger = LoggerFactory.getLogger(ManagerController.class);
	
	@Autowired
	private SqlSession sqlSession;

// < 팀 스케줄 > 
	
//	팀 월별 스케줄 조회
	@RequestMapping("/viewTeamCalendar")
	public String viewTeamCalendar(HttpServletRequest request, Model model) {
		logger.info("매니저 컨트롤러의 viewTeamCalendar()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
		String dpart = (String)session.getAttribute("dpart");
		
		// 의사
		if (dpart.equals("의사")) {
			
			String set = dpart;
			String team = (String)session.getAttribute("doctorT");
			String doctorT = team;
			
			ArrayList<Employee_20VO> employeeList = null;
			// 과장급(team = D)은 admin, adminMain에서 스케줄관련인덱스페이지 안보이게 if문걸어둠.
			if (team.equals("D")) {
				team = "A";
			}
		
			ArrayList<Employee_20VO> employeeDoc = null;
			request.setAttribute("doctorT",doctorT);
			employeeList = mapper.selectEmpListByDTeam(team);
			employeeDoc = mapper.selectEmployeeDpart(set);
			model.addAttribute("employeeList", employeeList);
			model.addAttribute("employeeDoc", employeeDoc);
			
			return "manager/viewTeamCalendarD"; 	
			
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
			
			return "manager/viewTeamCalendarN";
			
		// 병리사, 원무과 (미구현상태)
		} else {
			ArrayList<Employee_20VO> employeeList = null;
			employeeList = mapper.selectEmpListBydpart(dpart);
			model.addAttribute("employeeList", employeeList);
			return "manager/viewMainAdmin";	// 미구현 상태 
		}
		
	}

	
// 간호사 월스케줄 수정처리
	@RequestMapping("/teamCalendarNUpdateOK")
	public String teamCalendarNUpdateOK(HttpServletRequest request, Model model, ScheduleN_d_24VO scheduleN_d_24VO, 
			ScheduleN_e_25VO scheduleN_e_25VO, ScheduleN_n_26VO scheduleN_n_26VO) {
		
		logger.info("매니저 컨트롤러의 teamCalendarNUpdateOK()");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		mapper.updateTeamCalendarNDay(scheduleN_d_24VO);
		mapper.updateTeamCalendarNEven(scheduleN_e_25VO);
		mapper.updateTeamCalendarNNig(scheduleN_n_26VO);
		
		return "redirect:viewTeamCalendar";
		
	}	
	
	
//	간호사 월스케줄 등록화면  
	@RequestMapping("/viewTeamCalendarNInsert")
	public String viewTeamCalendarNInsert(HttpServletRequest request, Model model) {
		logger.info("매니저 컨트롤러의 viewTeamCalendarNInsert()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
		ArrayList<Employee_20VO> employeeList = new ArrayList<Employee_20VO>();
		
		// 한팀에 간호사는 팀원 5명으로 고정 
		String team = (String)session.getAttribute("nurseT");
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

		// 이번달 마지막 나이트 근무자 employeeIdx 구하기
		// 스케줄IDX: YYMMT
		String idx = String.valueOf(year).substring(2) + String.format("%02d", month) + team;
		ScheduleN_n_26VO scheduleN_nVO = mapper.selectScheduleNNig(idx);
		int lastDay = MyCalendar.lastDay(year, month);
		int lastNigEmpIdx = scheduleN_nVO.getNigWho(lastDay);
		model.addAttribute("lastNigEmpIdx", lastNigEmpIdx);
		
		// 다음달 스케줄을 입력하므로 이번달 +1
		if (month + 1 >= 13) {
			year++;
			month = 1;
		} else {
			month++;
		}
		
		request.setAttribute("yearA", year);
		request.setAttribute("monthA", month);
		
		return "manager/viewTeamCalendarNInsert";

	}	
	
//	간호사 월스케줄 등록처리  
	@RequestMapping("/teamCalendarNInsertOK")
	public String teamCalendarNInsertOK(HttpServletRequest request, Model model, ScheduleN_d_24VO scheduleN_d_24VO, 
			ScheduleN_e_25VO scheduleN_e_25VO, ScheduleN_n_26VO scheduleN_n_26VO) {
		
		logger.info("매니저 컨트롤러의 teamCalendarNInsertOK()");
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		mapper.insertTeamCalendarNDay(scheduleN_d_24VO);
		mapper.insertTeamCalendarNEven(scheduleN_e_25VO);
		mapper.insertTeamCalendarNNig(scheduleN_n_26VO);
		
		return "redirect:viewTeamCalendarNInsert";
		
	}
	
	
	
	


	
	
	

	


	
	
}
