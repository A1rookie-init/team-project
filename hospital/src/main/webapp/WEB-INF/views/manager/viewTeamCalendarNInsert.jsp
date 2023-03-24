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
<title>팀스케줄등록</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

<style type="text/css">
  
	.highlightN {
		border-color: #66afe9;
		outline: 0;
		-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .495), 0 0 8px rgba(110, 180, 405, 0.98);
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, .495), 0 0 8px rgba(110, 180, 405, 0.98);

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
		color: #DA70D6; /* 글자 색 */
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
/*  		background-color: aliceblue;  */
		color: red;
 		font-weight: bold; 
 		width: 100px;
		text-align: right; /* 수평 정렬 */
		vertical-align: top; /* 수직 정렬 */
		border-radius: 10px;

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
    <a class="nav-link" href="viewMainAdmin">관리자 HOME</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="viewAdmin">사원관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="viewTeamCalendar">팀스케줄 관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="viewTeamCalendarNInsert">팀스케줄 등록</a>
  </li>
</ul>


<div id="calendarN">
<!-- 팀원 목록, 간호사는 한 팀에 5명 -->
<div>
<br/>
	[근무기준] <br/>
	듀티: 데이 / 이브닝 / 나이트 <br/>
	나이트 근무 시 3일을 연속으로 나이트번으로 근무. <br/>
	3일 나이트근무 후 2일 오프는 의무사항. <br/>
	모든 팀원은 기본적으로 월 6일 나이트 근무. <br/>
	<br/><br/> 
	
<table align="left">
	<c:forEach var="employeeVO" items="${employeeList}"> 
		<tr>
			<td>${employeeVO.employeeIdx}</td>
			<td>${employeeVO.name}</td>
			<td width="120px">
			근무&nbsp;<input type="text" style="width: 40px;" id="work-${employeeVO.employeeIdx}" class="workDay" value=""/> <br/>
			오프&nbsp;<input type="text" style="width: 40px;" id="off-${employeeVO.employeeIdx}"  class="offDay" value=""/>
			</td>
		</tr>
	</c:forEach>
</table>
</div>	


<form action="teamCalendarNInsertOK">
<input type="hidden" value="<%=year%>" name="year"/>
<input type="hidden" value="<%=month%>" name="month"/>
<input type="hidden" value="${nurseT}" name="team"/>
<input type="hidden" value="<%=idxN%>" name="idx"/>
<input type="hidden" value="${employeeIdx}" name="managerIdx">
<!-- 달력 -->
<table width="900" border="1" align="center" cellpadding="5" cellspacing="0">
	<tr>
		<th colspan="2">
			<input type="hidden" value="${lastNigEmpIdx}" id="lastNigEmpIdx">
			<input type="button" value="추천받기" data-startNDay="<%=startNDay%>" data-mTotalDay="<%=mTotalDay%>" id="recommendS"/>
			<input type="button" value="추천제출" id="recommendSubmit"/>
		</th>
		<th id="month" colspan="3" class="title">
			<%=year%>년 <%=month%>월
		</th >
		<th colspan="2">
			<input type="submit" value="스케줄 등록">
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

	for (int i=1; i<=MyCalendar.lastDay(year, month); i++) {
		
		// 공휴일인가 판단해서 class 속성을 다르게 지정해서 날짜를 출력한다.
		if (lunarDate.get(i - 1).getHoliday().length() == 0) {
			switch (MyCalendar.weekDay(year, month, i)) {
				case 0:
%>
						<td class='sun'>
							<br/><%=i%><br/>
							<select name="shiftD_<%=i%>" id="shiftD_<%=i%>" class="form-select" aria-label="Default select example">
								<option>D</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
							<select name="shiftE_<%=i%>" id="shiftE_<%=i%>" class="form-select" aria-label="Default select example">
								<option>E</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
							<select name="shiftN_<%=i%>" id="shiftN_<%=i%>" class="form-select" aria-label="Default select example">
								<option>N</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
						</td>
<%					
					break;
				case 6:
%>
						<td class='sat'>
							<br/><%=i%><br/>
							<select name="shiftD_<%=i%>" id="shiftD_<%=i%>" class="form-select" aria-label="Default select example">
								<option>D</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
							<select name="shiftE_<%=i%>" id="shiftE_<%=i%>" class="form-select" aria-label="Default select example">
								<option>E</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
							<select name="shiftN_<%=i%>" id="shiftN_<%=i%>" class="form-select" aria-label="Default select example">
								<option>N</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
						</td>
<%
					break;
				default:
%>
						<td>
							<br/><%=i%><br/>
							<select name="shiftD_<%=i%>" id="shiftD_<%=i%>" class="form-select" aria-label="Default select example">
								<option>D</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
							<select name="shiftE_<%=i%>" id="shiftE_<%=i%>" class="form-select" aria-label="Default select example">
								<option>E</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
							<select name="shiftN_<%=i%>" id="shiftN_<%=i%>" class="form-select" aria-label="Default select example">
								<option>N</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
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
							<select name="shiftD_<%=i%>" id="shiftD_<%=i%>" class="form-select" aria-label="Default select example">
								<option>D</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
							<select name="shiftE_<%=i%>" id="shiftE_<%=i%>" class="form-select" aria-label="Default select example">
								<option>E</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
								</c:forEach>
							</select>
							<select name="shiftN_<%=i%>" id="shiftN_<%=i%>" class="form-select" aria-label="Default select example">
								<option>N</option>
								<c:forEach var="employeeVO" items="${employeeList}">
									<option value="${employeeVO.employeeIdx}">${employeeVO.name}</option>
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

<!-- js코드 기능테스트 후 수정여부결정으로 주석유지 -->
<script type="text/javascript">

onload = () => {

	// 특정날 나이트 선택영역 표시하기
	let startNDay = $("#recommendS").attr("data-startNDay") // 0 -> 1일에서 시작 , 1-> 2일에서 시작, 2-> 3일에서 시작
	let lastNigEmpIdx = $("#lastNigEmpIdx").val()
	let mTotalDay = $("#recommendS").attr("data-mTotalDay")
	
// 	highlightNf(startNDay, lastNigEmpIdx)
	
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
	
	
	
// 	/*
	$("#recommendS").on("click", function(){
		
		alert("표시된 날짜의 나이트 근무자 선택 후 \n제출버튼을 클릭하세요.")
		
		// 특정날 나이트 선택영역 표시하기
// 		let startNDay = $("#recommendS").attr("data-startNDay") // 0 -> 1일에서 시작 , 1-> 2일에서 시작, 2-> 3일에서 시작
// 		let lastNigEmpIdx = $("#lastNigEmpIdx").val()
		
// 		highlightNf(startNDay, lastNigEmpIdx)
		
					// 0-> 1일이 첫나이트 /1-> 3일이 첫나이트/ 2-> 2일이 첫나이트
			if (startNDay == 0) { 				// 1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31
				for (let i = 1; i <= 15; i+=3) {
					$("#shiftN_" + i).addClass("highlightN")
		// 			$("#shiftN_" + i).toggleClass("highlightN")
					
				}
			} else if (startNDay == 1) {		 // 3, 6, 9, 12, 15, 18, 21, 24, 27, 30
				for (let i = 3; i <= 15; i+=3) {
					$("#shiftN_" + i).addClass("highlightN")
		// 			$("#shiftN_" + i).toggleClass("highlightN")
				}
				$("#shiftN_1").find("option[value='" + lastNigEmpIdx + "']").prop({
			   		selected: true
			   	})
				$("#shiftN_2").find("option[value='" + lastNigEmpIdx + "']").prop({
			   		selected: true
			   	})
			
			} else if (startNDay == 2) {		 // 2, 5, 8, 11, 14, 17, 20, 23, 26, 29
				for (let i = 2; i <= 15; i+=3) {
					$("#shiftN_" + i).addClass("highlightN")
		// 			$("#shiftN_" + i).toggleClass("highlightN")
				}
				$("#shiftN_1").find("option[value='" + lastNigEmpIdx + "']").prop({
			   		selected: true
			   	})
			}
		
		nightSelect()
		
	});
	
	nightSelect()
	
// 추천제출버튼 누르면 스케줄 자동 추천
	$("#recommendSubmit").on("click", function(){
		
		let n1 = $(".form-select.highlightN").first().find("option:selected").val()
		let n2 = $(".form-select.highlightN").eq(1).find("option:selected").val()
		let n3 = $(".form-select.highlightN").eq(2).find("option:selected").val()
		let n4 = $(".form-select.highlightN").eq(3).find("option:selected").val()
		let n5 = $(".form-select.highlightN").eq(4).find("option:selected").val()
		
		let id1 = $(".form-select.highlightN").first().attr("id").substring(7)
		let id2 = $(".form-select.highlightN").eq(1).attr("id").substring(7)
		let id3 = $(".form-select.highlightN").eq(2).attr("id").substring(7)
		let id4 = $(".form-select.highlightN").eq(3).attr("id").substring(7)
		let id5 = $(".form-select.highlightN").eq(4).attr("id").substring(7)
		
		console.log(n1)
		console.log(n2)
		console.log(n3)
		console.log(n4)
		console.log(n5)
		console.log("헤이 ")
		
		console.log(id1)
		console.log(id2)
		
		// 추천스케줄(0부터~ 29까지)
		const schedule = [
			[n3, n2, n1], [n4, n2, n1], [n4, n5, n1], [n4, n5, n2], [n4, n3, n2], [n4, n3, n2], [n1, n5, n3],
			[n1, n5, n3], [n2, n1, n3], [n2, n1, n4], [n2, n5, n4], [n3, n5, n4], [n3, n2, n5], [n3, n2, n5], 
			[n4, n3, n5], [n4, n3, n1], [n4, n2, n1], [n4, n2, n1], [n5, n4, n2], [n5, n3, n2], [n1, n5, n2], 
			[n1, n4, n3], [n1, n4, n3], [n5, n1, n3], [n2, n1, n4], [n2, n5, n4], [n2, n5, n4], [n3, n1, n5], 
			[n3, n1, n5], [n3, n1, n5]
		]
		
	   	$("#shiftD_" + id1).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + id1).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id1) + 1)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id1) + 1)).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id1) + 2)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id1) + 2)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	
	   	$("#shiftD_" + id2).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + id2).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id2) + 1)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id2) + 1)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id2) + 2)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id2) + 2)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	
	   	$("#shiftD_" + id3).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + id3).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id3) + 1)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id3) + 1)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id3) + 2)).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id3) + 2)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	
	   	$("#shiftD_" + id4).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + id4).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id4) + 1)).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id4) + 1)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id4) + 2)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id4) + 2)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	
	   	$("#shiftD_" + id5).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + id5).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id5) + 1)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id5) + 1)).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id5) + 2)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id5) + 2)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
		
	   	
	   	
	   	$("#shiftD_" + (Number(id1) + 15)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id1) + 15)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id1) + 16)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id1) + 16)).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id1) + 17)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id1) + 17)).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	
	   	$("#shiftD_" + (Number(id2) + 15)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id2) + 15)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id2) + 16)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id2) + 16)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id2) + 17)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id2) + 17)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	
	   	$("#shiftD_" + (Number(id3) + 15)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id3) + 15)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id3) + 16)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id3) + 16)).find("option[value='" + n4 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id3) + 17)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id3) + 17)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	
	   	$("#shiftD_" + (Number(id4) + 15)).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id4) + 15)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id4) + 16)).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id4) + 16)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id4) + 17)).find("option[value='" + n2 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id4) + 17)).find("option[value='" + n5 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	
	   	$("#shiftD_" + (Number(id5) + 15)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id5) + 15)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id5) + 16)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id5) + 16)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
	   	
	   	$("#shiftD_" + (Number(id5) + 17)).find("option[value='" + n3 + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftE_" + (Number(id5) + 17)).find("option[value='" + n1 + "']").prop({
	   		selected: true
	   	}) 
		
	   	alert("근무일수를 고려하여 빈칸을 채운 후 스케줄등록버튼을 누르세요.")
	});
	
}


function highlightNf(startNDay, lastNigEmpIdx) {
	
	// 0-> 1일이 첫나이트 /1-> 3일이 첫나이트/ 2-> 2일이 첫나이트
	if (startNDay == 0) { 				// 1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31
		for (let i = 1; i <= 15; i+=3) {
			$("#shiftN_" + i).addClass("highlightN")
// 			$("#shiftN_" + i).toggleClass("highlightN")
			
		}
	} else if (startNDay == 1) {		 // 3, 6, 9, 12, 15, 18, 21, 24, 27, 30
		for (let i = 3; i <= 15; i+=3) {
			$("#shiftN_" + i).addClass("highlightN")
// 			$("#shiftN_" + i).toggleClass("highlightN")
		}
		$("#shiftN_1").find("option[value='" + lastNigEmpIdx + "']").prop({
	   		selected: true
	   	})
		$("#shiftN_2").find("option[value='" + lastNigEmpIdx + "']").prop({
	   		selected: true
	   	})
	
	} else if (startNDay == 2) {		 // 2, 5, 8, 11, 14, 17, 20, 23, 26, 29
		for (let i = 2; i <= 15; i+=3) {
			$("#shiftN_" + i).addClass("highlightN")
// 			$("#shiftN_" + i).toggleClass("highlightN")
		}
		$("#shiftN_1").find("option[value='" + lastNigEmpIdx + "']").prop({
	   		selected: true
	   	})
	}
}

	
function recommendBtnf() {

	alert("표시된 날짜의 나이트 근무자 선택 후 \n추천제출 버튼을 클릭하세요.")
	
	let startNDay = $("#recommendS").attr("data-startNDay") // 0 -> 1일에서 시작 , 1-> 2일에서 시작, 2-> 3일에서 시작
	let mTotalDay = $("#recommendS").attr("data-mTotalDay")
	console.log(startNDay)
	console.log(mTotalDay)
	
	highlightNf(startNDay, mTotalDay)
	
}

function nightSelect() {
	
	$(".form-select.highlightN").on("change", function(){
		
	   	console.log("야호")
	   	console.log($(this).attr("id").substring(7))
	   	
	   	let a = Number($(this).attr("id").substring(7)) + 1
	   	let b = Number($(this).attr("id").substring(7)) + 2
	   	let c = Number($(this).attr("id").substring(7)) + 15
	   	let d = Number($(this).attr("id").substring(7)) + 16
	   	let e = Number($(this).attr("id").substring(7)) + 17
	   	
	   	$("#shiftN_" + a).find("option[value='" + $(this).val() + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftN_" + b).find("option[value='" + $(this).val() + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftN_" + c).find("option[value='" + $(this).val() + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftN_" + d).find("option[value='" + $(this).val() + "']").prop({
	   		selected: true
	   	}) 
	   	$("#shiftN_" + e).find("option[value='" + $(this).val() + "']").prop({
	   		selected: true
	   	}) 
	});
}



</script>	
	
	
	
	
</body>
</html>