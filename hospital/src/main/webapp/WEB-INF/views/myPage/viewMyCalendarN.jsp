<%@page import="com.hospital.vo.ScheduleN_n_26VO"%>
<%@page import="com.hospital.vo.ScheduleN_e_25VO"%>
<%@page import="com.hospital.vo.ScheduleN_d_24VO"%>
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
<title>My 팀 스케줄</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

<style type="text/css">
  
	.highlightN {
		border-color: #ffa500;
		outline: 0;
		-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .495), 0 0 8px rgba(510, 120, 105, 0.98);
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, .495), 0 0 8px rgba(510, 120, 105, 0.98);

	}

	table {
		/* border: 선두께 선종류 선색상 */
		border: 0px solid;
	}

	tr {
		height: 100px; /* 행 높이 */
		border-width: 0px;
	}

	th {
		font-size: 20pt;
		width: 100px;
		border-width: 0px;
	}

	th.title {
		font-size: 30pt; /* 글꼴 크기 */
		font-family: D2Coding; /* 글꼴 이름 */
		font-weight: bold; /* 굵게 */
		color: 	#f08080; /* 글자 색 */
	}
	
	th#sunday {
		color: red;
	}
	
	th#saturday {
		color: blue;
	}
	
	td {
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
		background-color: #EBEAEA; /* 배경색 */
	}
	
	td.before {
		color: #787878;
		font-size: 10pt;
		background-color: #EBEAEA;
	}
	
	td#aftersat {
		color: #787878;
		font-size: 10pt;
		background-color: #EBEAEA;
	}
	
	td.after {
		color: #787878;
		font-size: 10pt;
		background-color: #EBEAEA;
	}
	
	td#choice {
		
		text-align: left;
		vertical-align: middle;
	}
	
	td.holiday {
		color: red;
 		font-weight: bold; 
 		width: 100px;
		text-align: right; /* 수평 정렬 */
		vertical-align: top; /* 수직 정렬 */
		border-radius: 10px;

	}
	
	span {
		font-size: 8pt;
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
	  background-color: pink; 
	  border: none;
	  color: white;
	  padding: 5px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 20px;
	  margin: 0;
	  transition-duration: 0.4s;
	  cursor: pointer;
	}
	
	.button1 {
	  background-color: white; 
	  color: black; 
	  border: 2px solid #f08080;
	}
	
	.button1:hover {
	  background-color: pink;
	  color: white;
	}
	
	.select {
		width: 100px;
		height: 30px;
	}
	
	fieldset {
		width: 105px;
		height: 50px;
		display: inline;
		border: none;
	}
</style>
</head>
<body>

<%    
	String teamN = (String) session.getAttribute("nurseT");
	int year = (int) request.getAttribute("yearA");
	int month = (int) request.getAttribute("monthA");
	String idxN = String.valueOf(year).substring(2) + String.format("%02d", month) + teamN;
	
	ScheduleN_d_24VO dayVO = (ScheduleN_d_24VO) request.getAttribute("dayVO");
	ScheduleN_e_25VO evenVO = (ScheduleN_e_25VO) request.getAttribute("evenVO");
	ScheduleN_n_26VO nigVO = (ScheduleN_n_26VO) request.getAttribute("nigVO");
	
// 월의 나이트번 시작일  & 월의 총날짜
	int startNDay = MyCalendar.startNDay(year, month, 1) % 3; // 0-> 1일이 첫나이트 /1-> 3일이 첫나이트/ 2-> 2일이 첫나이트
	int mTotalDay = MyCalendar.lastDay(year, month);
			
//	달력을 출력할 달의 양력/음력 대응 결과를 얻어온다.
	ArrayList<LunarDate> lunarDate = SolaToLunar.solaToLunar(year, month);

%>

<!-- header -->
<jsp:include page="../header/header.jsp"></jsp:include>
<jsp:include page="../quickmenu.jsp"></jsp:include>

<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link" href="viewMyInfo">My 정보</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="viewMyCalendar">My 스케줄</a>
  </li>
</ul>

<div id="calendarN">  
<br/>
<br/>
<div>
<!-- 팀원 목록, 간호사는 한 팀에 5명 -->
<table align="left">
	<c:forEach var="employeeVO" items="${employeeList}"> 
		<tr>
			<c:if test="${employeeVO.employeeIdx == employeeIdx}">
				<td>${employeeVO.employeeIdx}</td>
				<td>${employeeVO.name}</td>
				<td width="120px">
				근무&nbsp;<input type="text" style="width: 40px;" id="work-${employeeVO.employeeIdx}" class="workDay" value="" disabled="disabled"/> <br/>
				오프&nbsp;<input type="text" style="width: 40px;" id="off-${employeeVO.employeeIdx}"  class="offDay" value="" disabled="disabled"/>
				</td>
			</c:if>
			<c:if test="${employeeVO.employeeIdx != employeeIdx}">
				<td></td>
				<td></td>
				<td width="120px">
				<input type="hidden" style="width: 40px;" id="work-${employeeVO.employeeIdx}" class="workDay" value=""/> <br/>
				<input type="hidden" style="width: 40px;" id="off-${employeeVO.employeeIdx}"  class="offDay" value=""/>
				</td>
			</c:if>
		</tr>
	</c:forEach>

</table>
<input type="hidden" value="" data-startNDay="<%=startNDay%>" data-mTotalDay="<%=mTotalDay%>" id="recommendS" />
</div>

<form action="#">

<input type="hidden" value="<%=year%>" name="year"/>
<input type="hidden" value="<%=month%>" name="month"/>
<input type="hidden" value="${nurseT}" name="team"/>
<input type="hidden" value="<%=idxN%>" name="idx"/>
<input type="hidden" value="${employeeIdx}" id="myIdx">
<!-- 달력 -->
<table width="900" border="1" align="center" cellpadding="5" cellspacing="0">
	<tr>
		<th>
			<c:if test="${year <= 2022}">
				<c:if test="${month <= 11}">
					<button class="button button1" type="button" title="개원 첫 달입니다." onclick="location.href='#'" disabled="disabled">이전달</button>
				</c:if>
				<c:if test="${month > 11}">
					<input class="button button1" type="button" value="이전달"
				onclick="location.href='viewMyCalendar?yearBA=<%=year%>&monthBA=<%=month - 1%>'">
				</c:if>
			</c:if>
			<c:if test="${year >= 2023}">
				<input class="button button1" type="button" value="이전달"
				onclick="location.href='viewMyCalendar?yearBA=<%=year%>&monthBA=<%=month - 1%>'">
			</c:if>
		</th>
		<th id="month" colspan="5" class="title">
			<%=year%>년 <%=month%>월
		</th>
		<th>
			<c:if test="${year < yearC}">
				<button class="button button1" type="button" 
					onclick="location.href='viewMyCalendar?yearBA=<%=year%>&monthBA=<%=month + 1%>'">
					다음달
				</button>
			</c:if>
			<c:if test="${year == yearC}">
				<c:if test="${month < monthC}">
					<button class="button button1" type="button" 
						onclick="location.href='viewMyCalendar?yearBA=<%=year%>&monthBA=<%=month + 1%>'">
						다음달
					</button>
				</c:if>
				<c:if test="${month == monthC}">
					<button class="button button1" type="button" 
						onclick="location.href='#'" title="마지막 달입니다." disabled="disabled">
						다음달
					</button>
				</c:if>
			</c:if>
		</th>
	</tr>
	<tr>
		<th id="sunday">일</th>
		<th>월</th>
		<th>화</th>
		<th>수</th>
		<th>목</th>
		<th>금</th>
		<th id="saturday">토</th>
	</tr>
	<tr>
<%
	int week = MyCalendar.weekDay(year, month, 1);
	int start = 0;
	if (month == 1) {
		start = MyCalendar.lastDay(year - 1, 12) - week;
	} else {
		start = MyCalendar.lastDay(year, month - 1) - week;
	}
	for (int i=0; i<MyCalendar.weekDay(year, month, 1); i++) {
		if (i == 0) {
			out.println("<td id='beforesun'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
		} else {
			out.println("<td class='before'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
		}
	}
	
	int dayWho = 0;
	for (int i=1; i<=MyCalendar.lastDay(year, month); i++) {
		
		// 공휴일인가 판단해서 class 속성을 다르게 지정해서 날짜를 출력한다.
		if (lunarDate.get(i - 1).getHoliday().length() == 0) {
			switch (MyCalendar.weekDay(year, month, i)) {
				case 0:
%>
						<td class='sun'>
							<%=i%><br/>
							<c:set var="dayWho" value="<%=dayVO.getDayWho(i)%>"/>
							<c:set var="evenWho" value="<%=evenVO.getEvenWho(i)%>"/>
							<c:set var="nigWho" value="<%=nigVO.getNigWho(i)%>"/>
								
							<select name="shiftD_<%=i%>" id="shiftD_<%=i%>" class="form-select" aria-label="Default select example">
								<option>D</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == dayWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != dayWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>
								</c:forEach>
							</select>
							<select name="shiftE_<%=i%>" id="shiftE_<%=i%>" class="form-select" aria-label="Default select example">
								<option>E</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == evenWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != evenWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>
								</c:forEach>
							</select>
							<select name="shiftN_<%=i%>" id="shiftN_<%=i%>" class="form-select" aria-label="Default select example">
								<option>N</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == nigWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != nigWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>								
								</c:forEach>
							</select>
						</td>
						
<%					
					break;
				case 6:
%>
						<td class='sat'>
							<%=i%><br/>
							<c:set var="dayWho" value="<%=dayVO.getDayWho(i)%>"/>
							<c:set var="evenWho" value="<%=evenVO.getEvenWho(i)%>"/>
							<c:set var="nigWho" value="<%=nigVO.getNigWho(i)%>"/>
								
							<select name="shiftD_<%=i%>" id="shiftD_<%=i%>" class="form-select" aria-label="Default select example">
								<option>D</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == dayWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != dayWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>
								</c:forEach>
							</select>
							<select name="shiftE_<%=i%>" id="shiftE_<%=i%>" class="form-select" aria-label="Default select example">
								<option>E</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == evenWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != evenWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>
								</c:forEach>
							</select>
							<select name="shiftN_<%=i%>" id="shiftN_<%=i%>" class="form-select" aria-label="Default select example">
								<option>N</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == nigWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != nigWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>								
								</c:forEach>
							</select>
						</td>
<%
					break;
				default:
%>
						<td>
							<%=i%><br/>
							<c:set var="dayWho" value="<%=dayVO.getDayWho(i)%>"/>
							<c:set var="evenWho" value="<%=evenVO.getEvenWho(i)%>"/>
							<c:set var="nigWho" value="<%=nigVO.getNigWho(i)%>"/>
								
							<select name="shiftD_<%=i%>" id="shiftD_<%=i%>" class="form-select" aria-label="Default select example">
								<option>D</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == dayWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != dayWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>
								</c:forEach>
							</select>
							<select name="shiftE_<%=i%>" id="shiftE_<%=i%>" class="form-select" aria-label="Default select example">
								<option>E</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == evenWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != evenWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>
								</c:forEach>
							</select>
							<select name="shiftN_<%=i%>" id="shiftN_<%=i%>" class="form-select" aria-label="Default select example">
								<option>N</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == nigWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != nigWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>								
								</c:forEach>
							</select>
						</td>
<%     
					break;
			}
		} else {
%>						
						<td class='holiday'>
							<%=lunarDate.get(i - 1).getHoliday()%> <%=i%><br/>
							<c:set var="dayWho" value="<%=dayVO.getDayWho(i)%>"/>
							<c:set var="evenWho" value="<%=evenVO.getEvenWho(i)%>"/>
							<c:set var="nigWho" value="<%=nigVO.getNigWho(i)%>"/>
								
							<select name="shiftD_<%=i%>" id="shiftD_<%=i%>" class="form-select" aria-label="Default select example">
								<option>D</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == dayWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != dayWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>
								</c:forEach>
							</select>
							<select name="shiftE_<%=i%>" id="shiftE_<%=i%>" class="form-select" aria-label="Default select example">
								<option>E</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == evenWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != evenWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>
								</c:forEach>
							</select>
							<select name="shiftN_<%=i%>" id="shiftN_<%=i%>" class="form-select" aria-label="Default select example">
								<option>N</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<c:if test="${employeeVO.employeeIdx == nigWho}">
										<option value="${employeeVO.employeeIdx}" selected="selected">${employeeVO.name}</option>
									</c:if>
									<c:if test="${employeeVO.employeeIdx != nigWho}">
										<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
									</c:if>								
								</c:forEach>
							</select>
						</td>
<%			
		}
		if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
			out.println("</tr><tr>");
		}
	}

	if (month == 12) {
		week = MyCalendar.weekDay(year + 1, 1, 1);
	} else {
		week = MyCalendar.weekDay(year, month + 1, 1);
	}

	if (week != 0) {
		start = 0;
		for (int i=week; i<=6; i++) {
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
</form>
<br/>
<br/>
<br/>
</div>	
<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>
<script type="text/javascript">

onload = () => {
	
	$("select").attr({
		disabled: "disabled"
	})

	let myIdx = $("#myIdx").val()
	console.log(myIdx)
	$("option[value='" + myIdx + "']:selected").parent().addClass("highlightN")
	
	let startNDay = $("#recommendS").attr("data-startNDay") // 0 -> 1일에서 시작 , 1-> 2일에서 시작, 2-> 3일에서 시작
	let mTotalDay = $("#recommendS").attr("data-mTotalDay")
	
	calculateDay(mTotalDay)
	
	// 근무일, 오프일 계산하기 select태그기준 적용
	$(".form-select").on("change", function(){
		
		// 사원목록 각 input태그의 employeeIdx 얻어옴.
		let w1 = $(".workDay").eq(0).attr("id").substring(5)
		let w2 = $(".workDay").eq(1).attr("id").substring(5)
		let w3 = $(".workDay").eq(2).attr("id").substring(5)
		let w4 = $(".workDay").eq(3).attr("id").substring(5)
		let w5 = $(".workDay").eq(4).attr("id").substring(5)
		
		let wList1 = $("option[value='" + w1 + "']:selected")
		let wList2 = $("option[value='" + w2 + "']:selected")
		let wList3 = $("option[value='" + w3 + "']:selected")
		let wList4 = $("option[value='" + w4 + "']:selected")
		let wList5 = $("option[value='" + w5 + "']:selected")
		
		$(".workDay").eq(0).val(wList1.length);
		$(".workDay").eq(1).val(wList2.length);
		$(".workDay").eq(2).val(wList3.length);
		$(".workDay").eq(3).val(wList4.length);
		$(".workDay").eq(4).val(wList5.length);
		
		$(".offDay").eq(0).val(Number(mTotalDay) - wList1.length);
		$(".offDay").eq(1).val(Number(mTotalDay) - wList2.length);
		$(".offDay").eq(2).val(Number(mTotalDay) - wList3.length);
		$(".offDay").eq(3).val(Number(mTotalDay) - wList4.length);
		$(".offDay").eq(4).val(Number(mTotalDay) - wList5.length);
	});
	
	// 근무일, 오프일 계산해서 div태그 기준 적용
	$("#calendarN").on("click", function(){
		
		// 사원목록 각 input태그의 employeeIdx 얻어옴.
		let w1 = $(".workDay").eq(0).attr("id").substring(5)
		let w2 = $(".workDay").eq(1).attr("id").substring(5)
		let w3 = $(".workDay").eq(2).attr("id").substring(5)
		let w4 = $(".workDay").eq(3).attr("id").substring(5)
		let w5 = $(".workDay").eq(4).attr("id").substring(5)
		
		let wList1 = $("option[value='" + w1 + "']:selected")
		let wList2 = $("option[value='" + w2 + "']:selected")
		let wList3 = $("option[value='" + w3 + "']:selected")
		let wList4 = $("option[value='" + w4 + "']:selected")
		let wList5 = $("option[value='" + w5 + "']:selected")
		
		$(".workDay").eq(0).val(wList1.length);
		$(".workDay").eq(1).val(wList2.length);
		$(".workDay").eq(2).val(wList3.length);
		$(".workDay").eq(3).val(wList4.length);
		$(".workDay").eq(4).val(wList5.length);
		
		$(".offDay").eq(0).val(Number(mTotalDay) - wList1.length);
		$(".offDay").eq(1).val(Number(mTotalDay) - wList2.length);
		$(".offDay").eq(2).val(Number(mTotalDay) - wList3.length);
		$(".offDay").eq(3).val(Number(mTotalDay) - wList4.length);
		$(".offDay").eq(4).val(Number(mTotalDay) - wList5.length);
	});
	
}


// 근무일, 오프일 계산 메소드
function calculateDay(mTotalDay) {
	
	// 사원목록 각 input태그의 employeeIdx 얻어옴.
	let w1 = $(".workDay").eq(0).attr("id").substring(5)
	let w2 = $(".workDay").eq(1).attr("id").substring(5)
	let w3 = $(".workDay").eq(2).attr("id").substring(5)
	let w4 = $(".workDay").eq(3).attr("id").substring(5)
	let w5 = $(".workDay").eq(4).attr("id").substring(5)
	
	let wList1 = $("option[value='" + w1 + "']:selected")
	let wList2 = $("option[value='" + w2 + "']:selected")
	let wList3 = $("option[value='" + w3 + "']:selected")
	let wList4 = $("option[value='" + w4 + "']:selected")
	let wList5 = $("option[value='" + w5 + "']:selected")
	
	$(".workDay").eq(0).val(wList1.length);
	$(".workDay").eq(1).val(wList2.length);
	$(".workDay").eq(2).val(wList3.length);
	$(".workDay").eq(3).val(wList4.length);
	$(".workDay").eq(4).val(wList5.length);
	
	$(".offDay").eq(0).val(Number(mTotalDay) - wList1.length);
	$(".offDay").eq(1).val(Number(mTotalDay) - wList2.length);
	$(".offDay").eq(2).val(Number(mTotalDay) - wList3.length);
	$(".offDay").eq(3).val(Number(mTotalDay) - wList4.length);
	$(".offDay").eq(4).val(Number(mTotalDay) - wList5.length);
	
}

function highlightMine() {
	
	let myIdx = $("#myIdx").val()
	console.log(myIdx)
	$("option[value='" + myIdx + "']:selected").addClass("highlightN")
	
}
</script>	
	
	
	
	
</body>
</html>