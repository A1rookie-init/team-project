<%@page import="com.hospital.vo.Employee_20VO"%>
<%@page import="com.hospital.calendar.MyCalendar"%>
<%@page import="com.hospital.calendar.SolaToLunar"%>
<%@page import="com.hospital.calendar.LunarDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의사스케줄</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

<style type="text/css">
.highlightN {
	border-color: #66afe9;
	outline: 0;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .495), 0 0 8px
		rgba(110, 180, 405, 0.98);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .495), 0 0 8px
		rgba(110, 180, 405, 0.98);
}

table.calendar {
	/* border: 선두께 선종류 선색상 */
	border: 1px solid;
}

tr.calendar {
	height: 100px; /* 행 높이 */
	border-width: 0px;
	
}


th.calendar {
	font-size: 20pt;
	width: 100px;
	border-width: 0px;
}

th.title {
	font-size: 30pt; /* 글꼴 크기 */
	font-family: D2Coding; /* 글꼴 이름 */
	font-weight: bold; /* 굵게 */
	color: #147814; /* 글자 색 */
}

th#month {
	align:center;
	
}

th#sunday {
	color: red;
	
}

th#saturday {
	color: blue;
}

td.calendar {
	width: 100px;
	text-align: right; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border: 1px solid black;
	border-radius: 10px;
}

td.sun {
	color: red;
}

td.sat {
	color: blue;
}

td#beforesun {
	color: #787878;
	font-size: 10pt;
	border-radius: 10px;
	background-color: #EBEAEA; /* 배경색 */
}

td.before {
	color: #787878;
	border-radius: 10px;
	font-size: 10pt;
	background-color: #EBEAEA;
}

td#aftersat {
	color: #787878;
	border-radius: 10px;
	font-size: 10pt;
	background-color: #EBEAEA;
}

td.after {
	color: #787878;
	border-radius: 10px;
	font-size: 10pt;
	background-color: #EBEAEA;
}

td#choice {
	text-align: left;
	vertical-align: middle;
}

td.holiday {
	/*  		background-color: aliceblue;  */
	color: red;
	font-weight: bold;
	width: 100px;
	text-align: right; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
}

span.calendar {
	font-size: 8pt;
}
a.calendar {
	color: black;
	text-decoration: none; /* 밑줄 */
}

a:hover {
	color: lime;
	text-decoration: overline;
}

a:active {
	color: DodgerBlue;
	text-decoration: underline;
}

.button {
	background-color: #4CAF50; /* Green */
	border: none;
	color: white;
	padding: 5px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 0;
	transition-duration: 0.4s;
	cursor: pointer;
}

.button1.calendar {
	background-color: white;
	color: black;
	border: 2px solid #4CAF50;
}

.button1:hover {
	background-color: #4CAF50;
	color: white;
}

.select.calendar {
	width: 100px;
	height: 30px;
}

fieldset.calendar {
	width: 105px;
	height: 50px;
	display: inline;
	border: none;
}
</style>
</head>
<body>

	<!-- header -->
	<jsp:include page="../header/header.jsp"></jsp:include>
	<jsp:include page="../quickmenu.jsp"></jsp:include>
	
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link" href="viewMainAdmin">관리자 HOME</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="viewAdmin">사원관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="viewTeamCalendarD">팀스케줄 관리</a>
  </li>
</ul>

	<%
		request.setCharacterEncoding("UTF-8");

		// 현재 날짜
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		try {
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
			if (month >= 13) {
				year++;
				month = 1;
			} else if (month <= 0) {
				year--;
				month = 12;
			}
		} catch (NumberFormatException e) {
		}
		ArrayList<LunarDate> lunarDate = SolaToLunar.solaToLunar(year, month);
	%>

	<c:if test="${doctorT=='A' }">
		<!-- 달력 -->
		<table class="calendar" width="900" border="1" align="center" cellpadding="5" cellspacing="0">
			<tr class="calendar" align="center" >		
				<th colspan="7" > <h3 >A팀 스케줄</h3></th>
			</tr>
			<tr class="calendar" align="center">
				<th class="calendar"><input class="button button1 calendar" type="button" value="이전달" onclick="location.href='?year=<%=year%>&month=<%=month - 1%>'"> </th>
				<th class="calendar title" id="month" colspan="5" ><%=year%>년 <%=month%>월 </th>
				<th class="calendar"><button class="button button1 calendar"  type="button" onclick="location.href='?year=<%=year%>&month=<%=month + 1%>'"> 다음달</button>
				</th>
			</tr>
			<tr class="calendar" align="center"  >
				<th id="sunday"  class="calendar">일</th>
				<th class="calendar" ">월</th>
				<th class="calendar">화</th>
				<th class="calendar">수</th>
				<th class="calendar">목</th>
				<th class="calendar">금</th>
				<th class="calendar" id="saturday">토</th>
			</tr>
			<tr class="calendar" align="right" >
				<%
					int week = MyCalendar.weekDay(year, month, 1);
					int start = 0;
					if (month == 1) {
						start = MyCalendar.lastDay(year - 1, 12) - week;
					} else {
						start = MyCalendar.lastDay(year, month - 1) - week;
					}
					for (int i = 0; i < MyCalendar.weekDay(year, month, 1); i++) {
						if (i == 0) {
							out.println("<td id='beforesun'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
						} else {
							out.println("<td class='before'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
						}
					}
	
					for (int i = 1; i <= MyCalendar.lastDay(year, month); i++) {
						if (lunarDate.get(i - 1).getHoliday().length() == 0) {
							switch (MyCalendar.weekDay(year, month, i)) {
								case 0 :
				%>
				<td class='sun' align="right" ><br /> <%=i%><br /> 
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1101">권지용</option>
					<option>day</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
					</c:forEach>
				</select> 
				<select name="shiftE-<%=i%>" id="shiftE-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1102">김석진</option>
					<option>night</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='A'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select></td>
	
				<%
					break;
								case 6 :
				%>
				<td class='sat' align="right" ><br /> <%=i%><br /> 
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1101">권지용</option>
					<option>day</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='A'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select> 
				<select name="shiftE-<%=i%>" id="shiftE-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1103">김태형</option>
					<option>night</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='A'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select></td>
				<%
					break;
								default :
				%>
				<td align="right" ><br /> <%=i%><br />
				 
				<%
				if(lunarDate.get(i - 1).getDay() == 1 || lunarDate.get(i - 1).getDay() == 7 || lunarDate.get(i - 1).getDay() == 13 || lunarDate.get(i - 1).getDay() == 19 || lunarDate.get(i - 1).getDay() == 25 || lunarDate.get(i - 1).getDay() == 31){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1000">이수만</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1101">권지용</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 2 || lunarDate.get(i - 1).getDay() == 8 || lunarDate.get(i - 1).getDay() == 14|| lunarDate.get(i - 1).getDay() == 20|| lunarDate.get(i - 1).getDay() == 26){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1100">이종석</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1102">김태형</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 3 || lunarDate.get(i - 1).getDay() == 9 || lunarDate.get(i - 1).getDay() == 15 || lunarDate.get(i - 1).getDay() == 21 || lunarDate.get(i - 1).getDay() == 27){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1000">이수만</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1103">김석진</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 4 || lunarDate.get(i - 1).getDay() == 10 || lunarDate.get(i - 1).getDay() == 16 || lunarDate.get(i - 1).getDay() == 22 || lunarDate.get(i - 1).getDay() == 28){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1100">이종석</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1101">권지용</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 5 || lunarDate.get(i - 1).getDay() == 11 || lunarDate.get(i - 1).getDay() == 17 || lunarDate.get(i - 1).getDay() == 23 || lunarDate.get(i - 1).getDay() == 29){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1000">이수만</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1102">김태형</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 6 || lunarDate.get(i - 1).getDay() == 12 || lunarDate.get(i - 1).getDay() == 18 || lunarDate.get(i - 1).getDay() == 24 || lunarDate.get(i - 1).getDay() == 30){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1100">이종석</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1103">김석진</option>
				</select>
<%
				}

					break;
							}
						} else {
				%>
				<td class='holiday sun'  align="right" ><%=lunarDate.get(i - 1).getHoliday()%> <%=i%><br />
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1103">김태형</option>
					<option>day</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='A'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select> 
				<select name="shiftE-<%=i%>" id="shiftE-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1102">김석진</option>
					<option>night</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='A'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select>
				</td>
				
				<%
					}
						if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
							out.println("</tr><tr class='calendar'  align='right' >");
						}
					}
	
					if (month == 12) {
						week = MyCalendar.weekDay(year + 1, 1, 1);
					} else {
						week = MyCalendar.weekDay(year, month + 1, 1);
					}
	
					if (week != 0) {
						start = 0;
						for (int i = week; i <= 6; i++) {
							if (i == 6) {
								out.println("<td id='aftersat'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
							} else {
								out.println("<td class='after'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
							}
						}
					}
				%>
			</tr>
		</table>
	</c:if>
	
	
	
	
	
	<c:if test="${doctorT=='B' }">
		<!-- 달력 -->
		<table  class="calendar"  width="900" border="1" align="center" cellpadding="5" cellspacing="0">
			<tr class="calendar" align="center" >		
				<th colspan="7"><h3>B팀 스케줄</h3></th>
			</tr>
			<tr class="calendar" align="center">
				<th class="calendar" > <input class="button button1 calendar" type="button" value="이전달"	onclick="location.href='?year=<%=year%>&month=<%=month - 1%>'"> </th>
				<th id="month" colspan="5" class="calendar title" ><%=year%>년 <%=month%>월</th>
				<th class="calendar" > <button class="button button1 calendar" type="button" onclick="location.href='?year=<%=year%>&month=<%=month + 1%>'"> 다음달</button> </th>
			</tr>
			<tr class="calendar"  align="center" >
				<th class="calendar"  id="sunday">일</th>
				<th class="calendar" >월</th>
				<th class="calendar" >화</th>
				<th class="calendar" >수</th>
				<th class="calendar" >목</th>
				<th class="calendar" >금</th>
				<th class="calendar" id="saturday">토</th>
			</tr>
			<tr class="calendar"  align="right" >
				<%
					int week = MyCalendar.weekDay(year, month, 1);
					int start = 0;
					if (month == 1) {
						start = MyCalendar.lastDay(year - 1, 12) - week;
					} else {
						start = MyCalendar.lastDay(year, month - 1) - week;
					}
					for (int i = 0; i < MyCalendar.weekDay(year, month, 1); i++) {
						if (i == 0) {
							out.println("<td id='beforesun'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
						} else {
							out.println("<td class='before'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
						}
					}
	
					for (int i = 1; i <= MyCalendar.lastDay(year, month); i++) {
						if (lunarDate.get(i - 1).getHoliday().length() == 0) {
							switch (MyCalendar.weekDay(year, month, i)) {
								case 0 :
				%>
				<td class='sun'   align="right"  ><br /> <%=i%><br /> 
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1202">송민호</option>
					<option>day</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='B'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>						
						</c:if>
					</c:forEach>
				</select> 
				<select name="shiftE-<%=i%>" id="shiftE-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1203">김고은</option>
					<option value="1201">조규현</option>
					<option>night</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<<c:if test="${employeeVO.doctorT=='B'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select></td>
	
				<%
					break;
								case 6 :
				%>
				<td class='sat'  align="right"  ><br /> <%=i%><br /> 
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1201">조규현</option>
					<option>day</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='B'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select> 
				<select name="shiftE-<%=i%>" id="shiftE-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1201">송민호</option>
					<option>night</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='B'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select></td>
				<%
					break;
								default :
				%>
				<td align="right" ><br /> <%=i%><br /> 
				
				
				<%
				if(lunarDate.get(i - 1).getDay() == 1 || lunarDate.get(i - 1).getDay() == 7 || lunarDate.get(i - 1).getDay() == 13 || lunarDate.get(i - 1).getDay() == 19 || lunarDate.get(i - 1).getDay() == 25 || lunarDate.get(i - 1).getDay() == 31){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1200">이동욱</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1201">조규현</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 2 || lunarDate.get(i - 1).getDay() == 8 || lunarDate.get(i - 1).getDay() == 14|| lunarDate.get(i - 1).getDay() == 20|| lunarDate.get(i - 1).getDay() == 26){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1200">이동욱</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1202">송민호</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 3 || lunarDate.get(i - 1).getDay() == 9 || lunarDate.get(i - 1).getDay() == 15 || lunarDate.get(i - 1).getDay() == 21 || lunarDate.get(i - 1).getDay() == 27){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1200">이동욱</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1203">김고은</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 4 || lunarDate.get(i - 1).getDay() == 10 || lunarDate.get(i - 1).getDay() == 16 || lunarDate.get(i - 1).getDay() == 22 || lunarDate.get(i - 1).getDay() == 28){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1200">이동욱</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1201">조규현</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 5 || lunarDate.get(i - 1).getDay() == 11 || lunarDate.get(i - 1).getDay() == 17 || lunarDate.get(i - 1).getDay() == 23 || lunarDate.get(i - 1).getDay() == 29){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1200">이동욱</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1202">송민호</option>
				</select>
<%
				}
				if(lunarDate.get(i - 1).getDay() == 6 || lunarDate.get(i - 1).getDay() == 12 || lunarDate.get(i - 1).getDay() == 18 || lunarDate.get(i - 1).getDay() == 24 || lunarDate.get(i - 1).getDay() == 30){
				%>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1200">이동욱</option>
				</select>
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1203">김고은</option>
				</select>
<%
				}

					break;
							}
						} else {
				%>
				<td class='holiday sun' align="right" ><%=lunarDate.get(i - 1).getHoliday()%> <%=i%><br />
				<select name="shiftD-<%=i%>" id="shiftD-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1203">김고은</option>
					<option>day</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='B'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select> 
				<select name="shiftE-<%=i%>" id="shiftE-<%=i%>" class="form-select" aria-label="Default select example">
					<option value="1202">송민호</option>
					<option>night</option>
					<c:forEach var="employeeVO" items="${employeeDoc}">
						<c:if test="${employeeVO.doctorT=='B'}">
							<c:if test="${employeeVO.admin == '팀원'}">
								<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
							</c:if>
						</c:if>
					</c:forEach>
				</select></td>
				<%
					}
						if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
							out.println("</tr><tr class='calendar'  align='right' >");
						}
					}
	
					if (month == 12) {
						week = MyCalendar.weekDay(year + 1, 1, 1);
					} else {
						week = MyCalendar.weekDay(year, month + 1, 1);
					}
	
					if (week != 0) {
						start = 0;
						for (int i = week; i <= 6; i++) {
							if (i == 6) {
								out.println("<td id='aftersat'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
							} else {
								out.println("<td class='after'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
							}
						}
					}
				%>
			</tr>
		</table>
	</c:if>

	<br />
	<br />
	<br />

	<script type="text/javascript">
 

	
</script>




</body>
</html>