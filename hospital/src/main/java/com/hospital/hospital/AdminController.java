package com.hospital.hospital;


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

import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.Employee_20List;
import com.hospital.vo.Employee_20VO;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/viewMainAdmin")
	public String viewMainAdmin(HttpServletRequest request, Model model) {
		logger.info("viewMainAdmin()");
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();

		Employee_20List employeeList = ctx.getBean("employeeList", Employee_20List.class);
		String dPart = (String) session.getAttribute("dPart");
 
		employeeList.setEmployeeList(mapper.selectSign());
		model.addAttribute("employeeList", employeeList);

		return "manager/viewMainAdmin";
	}
	

	@RequestMapping("/viewAdmin")
	public String viewAdmin(HttpServletRequest request, Model model) {
		logger.info("viewMainAdmin()");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
			int currentPage = 1;
			try {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException e) {
			}

			int pageSize = 10;
			int totalCount = mapper.selectCountSign();
			AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			Employee_20List employeeList = ctx.getBean("employeeList", Employee_20List.class);

			
			employeeList.setCurrentPage(currentPage);
	        employeeList.setPageSize(pageSize);
	        employeeList.setTotalCount(totalCount);
	        employeeList.calculator();
			
			employeeList.setEmployeeList(mapper.selectSignForPaging(employeeList));

			model.addAttribute("employeeList", employeeList);
		
		return "manager/viewAdmin";
		
	}
	@RequestMapping("/viewDpartEmployee")
	   public String viewDpartEmployee(HttpServletRequest request, Model model, HttpServletResponse response) {
	      logger.info("viewDpartEmployee()");

	      MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

	      String set = request.getParameter("set");
	      logger.info(set);
	      if (set == null || set.equals("")) {
	    	  Alert.alertAndBack(response, "검색할 부서를 선택하세요");
	      }
	      else if (set.equals("의사")) {
	         int currentPage = 1;
	         try {
	            currentPage = Integer.parseInt(request.getParameter("currentPage"));
	         } catch (NumberFormatException e) {
	         }

	         int pageSize = 10;
	         int totalCount = mapper.selectCountEmployeeDpart(set);

	         AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	         Employee_20List employeeList = ctx.getBean("employeeList", Employee_20List.class);
	         employeeList.setCurrentPage(currentPage);
	         employeeList.setPageSize(pageSize);
	         employeeList.setTotalCount(totalCount);
	         employeeList.calculator();
	         employeeList.setSet(set);
	         employeeList.setEmployeeList(mapper.selectSignDpartForPaging(employeeList));

	         model.addAttribute("employeeList", employeeList);
	         model.addAttribute("set", set);

	      } else if (set.equals("간호사")) {
	         int currentPage = 1;
	         try {
	            currentPage = Integer.parseInt(request.getParameter("currentPage"));
	         } catch (NumberFormatException e) {
	         }

	         int pageSize = 10;
	         int totalCount = mapper.selectCountEmployeeDpart(set);

	         AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	         Employee_20List employeeList = ctx.getBean("employeeList", Employee_20List.class);
	         employeeList.setCurrentPage(currentPage);
	         employeeList.setPageSize(pageSize);
	         employeeList.setTotalCount(totalCount);
	         employeeList.calculator();

	         employeeList.setSet(set);
	         employeeList.setEmployeeList(mapper.selectSignDpartForPaging(employeeList));

	         model.addAttribute("employeeList", employeeList);
	         model.addAttribute("set", set);

	      } else if (set.equals("병리사")) {

	    	 int currentPage = 1;
		     try {
		    	 currentPage = Integer.parseInt(request.getParameter("currentPage"));
		     } catch (NumberFormatException e) {}

		     int pageSize = 10;
	         int totalCount = mapper.selectCountEmployeeDpart(set);
	         
	         AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	         Employee_20List employeeList = ctx.getBean("employeeList", Employee_20List.class);

	         employeeList.setCurrentPage(currentPage);
	         employeeList.setPageSize(pageSize);
	         employeeList.setTotalCount(totalCount);
	         employeeList.calculator();
	         
	         employeeList.setSet(set);
	         employeeList.setEmployeeList(mapper.selectSignDpartForPaging(employeeList));

	         model.addAttribute("employeeList", employeeList);
	         model.addAttribute("set", set);

	      } else if (set.equals("원무과")) {	    	  
	    	  
	    	 int currentPage = 1;
			 try {
				 currentPage = Integer.parseInt(request.getParameter("currentPage"));
			 } catch (NumberFormatException e) {}

			 int pageSize = 10;
			 int totalCount = mapper.selectCountEmployeeDpart(set);
	         AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	         Employee_20List employeeList = ctx.getBean("employeeList", Employee_20List.class);

	         employeeList.setCurrentPage(currentPage);
	         employeeList.setPageSize(pageSize);
	         employeeList.setTotalCount(totalCount);
	         employeeList.calculator();
	         
	         employeeList.setSet(set);
	         employeeList.setEmployeeList(mapper.selectSignDpartForPaging(employeeList));

	         model.addAttribute("employeeList", employeeList);
	         model.addAttribute("set", set);

	      }
	      
	      mapper.selectCountSign();

	      return "manager/viewAdmin";
	   }
	@RequestMapping("/updateSign")
	public String updateSign(HttpServletRequest request, Model model, HttpServletResponse response) {
		logger.info("updateSign()");

		int employeeIdx = Integer.parseInt(request.getParameter("employeeIdx"));

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.updateSign(employeeIdx);

		Alert.alertAndGo(response, "승인 완료","viewMainAdmin" );
		
		return "manager/viewMainAdmin";
	}

	@RequestMapping("/viewAdminUpdate")
	public String viewAdminUpdate(HttpServletRequest request, Model model) {
		logger.info("viewAdminUpdate()");

		int employeeIdx = Integer.parseInt(request.getParameter("employeeIdx"));
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		Employee_20VO employeeVO = mapper.selectEmployee(employeeIdx);
		

		model.addAttribute("employeeVO", employeeVO);

		return "manager/viewAdminUpdate";
	}

	@RequestMapping("/moveTeam")
	public String moveTeam(HttpServletRequest request, Model model, HttpSession session, HttpServletResponse response, Employee_20VO employee_20vo) {
		logger.info("moveTeam()");

		int employeeIdx = Integer.parseInt(request.getParameter("employeeIdx"));
		String doctorT =request.getParameter("doctorT");
		String nurseT =request.getParameter("nurseT");

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		if (doctorT != null) {
			mapper.moveTeamD(employee_20vo);
			request.setAttribute("doctorT",doctorT);
			request.setAttribute("employeeIdx", employeeIdx);
			
		} else if (nurseT != null) {
			mapper.moveTeamN(employee_20vo);
			request.setAttribute("nurseT", nurseT);
			request.setAttribute("employeeIdx", employeeIdx);
		}
		
		Alert.alertAndGo(response, "팀이동 완료","viewAdminUpdate?employeeIdx="+ employeeIdx);


		return "manager/viewAdminUpdate";
	}
	
	@RequestMapping("/updateAdmin")
	public String updateAdmin(HttpServletRequest request, Model model, HttpSession session, HttpServletResponse response, Employee_20VO employee_20vo) {
		logger.info("updateAdmin()");
		
		int employeeIdx = Integer.parseInt(request.getParameter("employeeIdx"));
		String admin = request.getParameter("admin");
		String doctorT =request.getParameter("doctorT");
		String nurseT =request.getParameter("nurseT");
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
			if (doctorT != null || doctorT != "" && admin.equals("과장")) {
				employee_20vo.setDoctorT("D");
				mapper.updateAdminDoc(employee_20vo);
				request.setAttribute("admin", admin);
				request.setAttribute("doctorT", "D");
				request.setAttribute("employeeIdx", employeeIdx);
				model.addAttribute("employeeVO",employee_20vo );
			} else if (nurseT != null|| nurseT != "" && admin.equals("과장")) {
				mapper.updateAdminNur(employee_20vo);
				request.setAttribute("admin", admin);
				request.setAttribute("nurseT", nurseT);
				request.setAttribute("employeeIdx", employeeIdx);
				model.addAttribute("employeeVO",employee_20vo );
			}else {
				mapper.updateAdmin(employee_20vo);
				request.setAttribute("admin", admin);
				request.setAttribute("employeeIdx", employeeIdx);
			}		
			Alert.alertAndGo(response, "직급 변경 완료","viewAdminUpdate?employeeIdx="+ employeeIdx );
		 
		return "manager/viewAdminUpdate";
	}

	@RequestMapping("/deleteEmployee")
	public String deleteEmployee(HttpServletRequest request, Model model, HttpServletResponse response) {
		int employeeIdx = Integer.parseInt(request.getParameter("employeeIdx"));
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.deleteEmployee(employeeIdx);
		
		request.setAttribute("employeeIdx", employeeIdx);
		Alert.alertAndGo(response, "퇴사 처리 완료","viewAdmin" );

		return "manager/viewAdmin";
	}
	

}
