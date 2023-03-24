package com.hospital.hospital;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hospital.mybatis.MyBatisDAO;
import com.hospital.vo.Employee_20VO;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/")
	public String home(HttpServletRequest request, Model model) {
		logger.info("Welcome home! The client locale is {}.");
		return "login";
	}

	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {

		logger.info("login()");

		return "login";
	}



   @RequestMapping("/loginOK")
   public String ioginOK(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
      logger.info("loginOK()");
      String view = "";

      MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
      HttpSession session = request.getSession();

      String employeeIdx = request.getParameter("employeeIdx").trim();
      String password = request.getParameter("password").trim();

//	      사번이나 비번 입력 안되었으면 얼럿창 띄우고 다시 로그인 페이지로 이동
      if (employeeIdx == null || employeeIdx.equals("") || password == null || password.equals("")) {
         // 여기 안먹여서 비밀번호가 일치하지 않습니다와 합침
         view = "redirect:alert";
      }
      // 사번에 문자가 들어오면 생기는 에러 방지
      try {

         Employee_20VO original = mapper.selectByEmployeeIdx(Integer.parseInt(employeeIdx));

         // 입력된 사번이 디비에 존재하면
         if (original != null) {

            // 비번 확인후 부서에 따른 메인페이지로 이동
            request.setAttribute("original", original);
            System.out.println("<script>");

            if (password.equals(original.getPassword())) {
               
// (!주의!) -> 변경 필요시 Notify To 민경
// 실시간 알림기능 추가하면서 세션저장 코드변경함!! 이대로 유지!!---------------------------------------------
               session.setAttribute("employeeIdx", String.valueOf(original.getEmployeeIdx()));
               session.setAttribute("dpart", original.getDpart());
               session.setAttribute("employeeName", original.getName());
               session.setAttribute("admin", original.getAdmin());
               session.setAttribute("sign", original.getSign());
               
               
               if (original.getSign() == null) {
                  Alert.alertAndRedirect(response, "가입 승인 전입니다", "login");
                  view = "login";
               }else {
                  if (original.getEmployeeIdx() / 1000 == 1) {
   
                     session.setAttribute("doctorT", original.getDoctorT());
                     view = "redirect:viewMainDoctor";
   
                  } else if (original.getEmployeeIdx() / 1000 == 2) {
   
                     session.setAttribute("nurseT", original.getNurseT());
                     view = "redirect:viewMainN";
   
                  } else if (original.getEmployeeIdx() / 1000 == 3) {
                     view = "redirect:viewMainP";
   
                  } else {
                     view = "redirect:viewMainA";
                  }
               }

               System.out.println( "JSESSIONID 값 :"+ session.getId());
               System.out.println( "세션의 유효 기간 :"+ session.getMaxInactiveInterval());
               System.out.println( "세션 생성일시 :" + session.getCreationTime());
               System.out.println("세션과 연결된 사용자가 최근에 서버에 접근한 시간 :" + session.getLastAccessedTime());
               System.out.println(session.isNew());
               System.out.println(Arrays.toString(session.getValueNames()));
// -----------------------------------------------------------------------------------------------------------               
               
            } else {
               System.out.println("alert('비밀번호가 일치하지 않습니다.')");
               request.setAttribute("msg", "아이디 비밀번호를 다시 입력해주세요.");
               request.setAttribute("url", "login");
               view = "alert";
            }
            System.out.println("</script>");

         } else if (original == null) {
            request.setAttribute("msg", "존재하지 않는 사번입니다.");
            request.setAttribute("url", "login");
            view = "alert";
         }
      } catch (NumberFormatException e) {
         request.setAttribute("msg", "사번은 숫자를 입력해주세요.");
         request.setAttribute("url", "login");
         view = "alert";
      }

      return view;
   }
	   

	
	
//  회원가입
  @RequestMapping("/insertEmployee")
	public String insertEmployee(HttpServletRequest request, Model model, Employee_20VO employeeVO) {
		logger.info("insertEmployee()");		
		return "insertEmployee";
	}
	
	
	@RequestMapping("/insertEmployeeOK")
	public String insertEmployeeOK(HttpServletRequest request, Model model, Employee_20VO employeeVO, HttpServletResponse response) {
		logger.info("insertEmployeeOK()");
		
		String view = "";
		
		String employeeIdx = request.getParameter("employeeIdx").trim();
		String password1 = request.getParameter("password1").trim();
		String password2 = request.getParameter("password2").trim();
		String name = request.getParameter("name").trim();
		String age = request.getParameter("age").trim();
		String gender = request.getParameter("gender").trim();
		String dpart = request.getParameter("dpart").trim();
		
		String doctorT = null;
		String nurseT = null;
		if(request.getParameter("dpart").equals("의사")){			
			 doctorT = request.getParameter("team");
		} else if (request.getParameter("dpart").equals("간호사")){			
			 nurseT = request.getParameter("team");
		} 
		
		String team = request.getParameter("team");
		String dnumber = request.getParameter("dnumber").trim();
		String enumber = request.getParameter("enumber").trim();
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		
		if (employeeIdx == null || employeeIdx.equals("") || 
				password1 == null || password1.equals("")||
				password2 == null || password2.equals("")||
				name == null || name.equals("")||
				age == null || age.equals("")||
				gender == null || gender.equals("")||
				dpart == null || dpart.equals("")||
				dnumber == null || dnumber.equals("")||
				enumber == null || enumber.equals("")) {
					Alert.alertAndBack(response, "모든 내용을 입력하세요");
					view = "redirect:insertEmployee";
		} else if (!password1.equals(password2)){
			Alert.alertAndBack(response, "비밀번호가 다릅니다.");
			view = "redirect:insertEmployee";
		} else {
			employeeVO.setEmployeeIdx(Integer.parseInt(employeeIdx));
			employeeVO.setPassword(password2);
			employeeVO.setName(name);
			employeeVO.setAge(Integer.parseInt(age));
			employeeVO.setGender(gender);
			employeeVO.setDpart(dpart);
			employeeVO.setDoctorT(doctorT);
			employeeVO.setNurseT(nurseT);
			employeeVO.setDnumber(dnumber);
			employeeVO.setEnumber(enumber);	
			mapper.employeeinsert(employeeVO);
			Alert.alertAndRedirect(response, "회원가입 완료!", "login");
			view = "login";
		}
		
		return view;
	}
	
	

	
//  로그아웃
  @RequestMapping("/logout")
  public String logout(HttpServletRequest request) {
     
     logger.info("logout()");
       
       HttpSession session = request.getSession();
       
       session.invalidate();
     
     return "redirect:login";
  }
  

 
}
