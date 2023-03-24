<%@page import="java.time.DayOfWeek"%>
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
<title>병원달력</title>

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

table.calender {
	/* border: 선두께 선종류 선색상 */
	border: 0px solid;
	
}

tr.calender {
	height: 80px; /* 행 높이 */
	border-width: 0px;
}

th.calender {
	font-size: 20pt;
	width: 100px;
	border-width: 0px;
}

th.title {
	font-size: 30pt; /* 글꼴 크기 */
	font-family: D2Coding; /* 글꼴 이름 */
	font-weight: bold; /* 굵게 */
	color: green; /* 글자 색 */
}

th#sunday {
	color: red;
}

th#saturday {
	color: blue;
}

td.calender {
	width: 100px;
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border: 1px solid black;
	border-radius: 10px;
}

td.sun {
	width: 100px;
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
	color: red;
}

td.day {
	width: 100px;
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
}

td.sat {
	width: 100px;
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
	color: blue;
}

td#beforesun {
	color: #787878;
	width: 100px;
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
	font-size: 10pt;
	background-color: #EBEAEA; /* 배경색 */
}

td.before {
	width: 100px;
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
	color: #787878;
	font-size: 10pt;
	background-color: #EBEAEA;
}

td#aftersat {
	color: #787878;
	width: 100px;
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
	font-size: 10pt;
	background-color: #EBEAEA;
}

td.after {
	width: 100px;
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
	color: #787878;
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
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
}

td.hospital {
	/*  		background-color: aliceblue;  */
	color: #6A5ACD;
	font-weight: bold;
	width: 100px;
	text-align: center; /* 수평 정렬 */
	vertical-align: top; /* 수직 정렬 */
	border-radius: 10px;
}

span.calender {
	font-size: 8pt;
}

span.hospital {
		background-color: #C8FAC8; /* Green */
	
	
}


a {
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

.button1 {
	background-color: white;
	color: black;
	border: 2px solid #4CAF50;
}

.button1:hover {
	background-color: #4CAF50;
	color: white;
}

.select {
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

		ArrayList<LunarDate> lunarDate = SolaToLunar.calendar(year, month);
		%>

	<!-- 달력 -->
	<table class="calender" width="800" border="1" align="center" cellpadding="5" cellspacing="0">
		<tr class="calender" align='center'>
			<th class="calender"><input class="button button1 calendar" type="button" value="이전달"
				onclick="location.href='?year=<%=year%>&month=<%=month - 1%>'">
			</th>
			<th id="month" colspan="5" class="title calendar calendar" align="center"><%=year%>년 <%=month%>월
			</th>
			<th class="calender">
				<button class="button button1" type="button" onclick="location.href='?year=<%=year%>&month=<%=month + 1%>'">
					다음달</button>
			</th>
		</tr>
		<tr class="calender" align='center'>
			<th class="calender" id="sunday">일</th>
			<th class="calender">월</th>
			<th class="calender">화</th>
			<th class="calender">수</th>
			<th class="calender">목</th>
			<th class="calender">금</th>
			<th class="calender" id="saturday">토</th>
		</tr>
		<tr class="calender"  align="center" >

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
						out.println("<td id='beforesun'  align='center' ><br>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
					} else {
						out.println("<td class='before'  align='center' ><br>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
					}
				}

				for (int i = 1; i <= MyCalendar.lastDay(year, month); i++) {

					// 공휴일인가 판단해서 class 속성을 다르게 지정해서 날짜를 출력한다.
					if (lunarDate.get(i - 1).getHoliday().length() == 0 && lunarDate.get(i - 1).getHospital().length() == 0) {
						switch (MyCalendar.weekDay(year, month, i)) {
						case 0:
							out.println("<td class='sun' align='center'>" + i + "</td>");
							break;
						case 6:
							out.println("<td class='sat'  align='center' >" + i + "</td>");
							break;
						default:
							out.println("<td class='day' align='center' >" + i + "</td>");
							break;
						}
					} else if(lunarDate.get(i - 1).getHoliday().length() != 0) {
						out.println("<td class='holiday'  align='center'>" + i + lunarDate.get(i - 1).getHoliday() + "</td>");
					} else {
						out.println("<td class='hospital'  align='center'>" + i + lunarDate.get(i - 1).getHospital() + "</td>");
					}

					if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
						out.println("</tr><tr class='calender'>");
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
							out.println("<td id='aftersat'  align='center'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
						} else {
							out.println("<td class='after'  align='center'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
						}
					}
				}
				
				
				
				 
			%>

		</tr>
	</table>

	<br />
	<br />
	<br />

</body>
</html>