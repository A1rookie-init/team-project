<%@page import="com.hospital.vo.Dpart_23List"%>
<%@page import="com.hospital.vo.Employee_20List"%>
<%-- <%@page import="com.hospital.service.PatientService"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />



</head>
<body>

	<%
		
	%>
	<jsp:include page="../header/header.jsp"></jsp:include>
	
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link" href="viewMainAdmin">관리자 HOME</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="viewAdmin">사원관리</a>
  </li>
  <c:if test="${admin == '팀장'}">
	  <c:if test="${dpart == '간호사' or dpart == '의사'}">
			  <li class="nav-item">
			    <a class="nav-link" href="viewTeamCalendar">팀스케줄 관리</a>
			  </li>
		</c:if>
		<c:if test="${dpart == '간호사'}">
			  <li class="nav-item">
			    <a class="nav-link" href="viewTeamCalendarNInsert">팀스케줄 등록</a>
			  </li>
		</c:if>
  </c:if>
</ul>


<div style="width: 900px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">
		<form action="viewDpartEmployee">
		<div style=" margin-top: 20px; margin-left: 50px;">
			<label><input type="radio" name="set" value="의사" />의사</label>
			<label><input type="radio" name="set" value="간호사" />간호사</label>
			<label><input type="radio" name="set" value="원무과" />원무과</label>
			<label><input type="radio" name="set" value="병리사" />병리사</label>
			<label><input type="submit" value="검색"></label>
			</div>
		</form>
		<br>
		
		<c:if test="${employeeList != null}">
			<c:set var="currentPage" value="${employeeList.currentPage}"/>
			<c:set var="startPage" value="${employeeList.startPage}"/>
			<c:set var="endPage" value="${employeeList.endPage}"/>
			<c:set var="totalPage" value="${employeeList.totalPage}"/>
			
			<c:if test="${employeeList.employeeList.size() != 0}">
		
				<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
					<tr>
						<th style="width: 125px; text-align: center;">사번</th>
						<th style="width: 125px; text-align: center;">성명</th>
						<th style="width: 125px; text-align: center;">부서</th>
						<th style="width: 125px; text-align: center;">팀</th>
						<th style="width: 150px; text-align: center;">내선번호</th>
						<th style="width: 150px; text-align: center;">개인연락처</th>
						<th style="width: 100px; text-align: center;">사원수:${employeeList.totalCount}</th>
					</tr>						 	
				</table>		
				<c:forEach var="employeeVO" items="${employeeList.employeeList}">
						
						<c:if test="${employeeVO.sign =='Y'}">
							<button onclick="location.href='viewAdminUpdate?employeeIdx=${employeeVO.employeeIdx}'" class="btn btn-outline-success btn-sm" style="border-color: black;"
									data-bs-eidx="${employeeVO.employeeIdx}"
									data-bs-name="${employeeVO.name}"
									data-bs-dnum="${employeeVO.dnumber}"
									data-bs-enum="${employeeVO.enumber}">
							
							<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
								<tr>
									<td style="width: 125px; text-align: center;">${employeeVO.employeeIdx}</td>
									<td style="width: 125px; text-align: center;">${employeeVO.name}</td>
									<c:if test="${employeeVO.dpart == '의사'}">
										<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">의무과</td>
										<c:if test="${employeeVO.doctorT!='D'}">
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">${employeeVO.doctorT}팀</td>
										</c:if>
										<c:if test="${employeeVO.doctorT=='D'}">
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">과장</td>
										</c:if>
									</c:if>
									<c:if test="${employeeVO.dpart == '간호사'}">
										<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">간호과</td>
										<c:if test="${employeeVO.nurseT!='D'}">
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">${employeeVO.nurseT}팀</td>
										</c:if>
										<c:if test="${employeeVO.nurseT=='D'}">
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">과장</td>
										</c:if>
									</c:if>
									<c:if test="${employeeVO.dpart == '병리사'}">
										<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">병리과</td>
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">병리팀</td>
									</c:if>
									<c:if test="${employeeVO.dpart == '원무과'}">
										<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">원무과</td>
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">원무팀</td>							
									</c:if>
									<td style="width: 150px; text-align: center;">${employeeVO.dnumber}</td>
									<td style="width: 150px; text-align: center;">${employeeVO.enumber}</td>
									<td style="width: 100px; text-align: center;"></td>
								</tr>						 	
							</table>
							</button>
						</c:if>
						
						<c:if test="${employeeVO.sign !='Y'}">
						
						<!-- 승인전 -->
							<button onclick="location.href='viewAdminUpdate?employeeIdx=${employeeVO.employeeIdx}'" class="btn btn-outline-warning btn-sm" style="border-color: black;"
									data-bs-eidx="${employeeVO.employeeIdx}"
									data-bs-name="${employeeVO.name}"
									data-bs-dnum="${employeeVO.dnumber}"
									data-bs-enum="${employeeVO.enumber}">
							
							<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
								<tr>
									<td style="width: 125px; text-align: center;">${employeeVO.employeeIdx}</td>
									<td style="width: 125px; text-align: center;">${employeeVO.name} </td>
									<c:if test="${employeeVO.dpart == '의사'}">
										<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">의무과</td>
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">${employeeVO.doctorT}팀</td>
									</c:if>
									<c:if test="${employeeVO.dpart == '간호사'}">
										<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">간호과</td>
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">${employeeVO.nurseT}팀</td>
									</c:if>
									<c:if test="${employeeVO.dpart == '병리사'}">
										<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">병리과</td>
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">병리팀</td>
									</c:if>
									<c:if test="${employeeVO.dpart == '원무과'}">
										<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">원무과</td>
										<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">원무팀</td>							
									</c:if>
									<td style="width: 150px; text-align: center;">${employeeVO.dnumber}</td>
									<td style="width: 150px; text-align: center;">${employeeVO.enumber}</td>
									<td style="width: 100px; text-align: center;"></td>
								</tr>						 	
							</table>
							</button>
						</c:if>
						
				</c:forEach>
				
			</c:if>
			</c:if>
			
			
	<div style="position: relative; left: 330px; margin-top: 50px; margin-bottom: 20px;">
		<table>
			<tr align="center">
				<td>
					<c:if test="${currentPage > 1}">
						<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
								onclick="location.href='?currentPage=1&&set=${set}'">처음</button>
					</c:if>
					
					<c:if test="${currentPage <= 1}">
						<button class="button button2" type="button" title="이미 첫 페이지 입니다." 
								disabled="disabled">처음</button>
					</c:if>
					<c:if test="${startPage > 1}">
						<button class="button button1" type="button" title="이전 10 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${startPage - 1}&set=${set}'">
							이전
						</button>
					</c:if>
					
					<c:if test="${startPage <= 1}">
						<button class="button button2" type="button" title="이미 첫 10 페이지 입니다." 
								disabled="disabled">이전</button>
					</c:if>
					<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
					
						<c:if test="${currentPage == i}">
							<button class="button button2" type="button" disabled="disabled">${i}</button>
						</c:if>
						
						<c:if test="${currentPage != i}">
							<button class="button button1" type="button" onclick="location.href='?currentPage=${i}&set=${set}'">
								${i}
							</button>
						</c:if>
					
					</c:forEach>
	
					<c:if test="${endPage < totalPage}">
						<button class="button button1" type="button" title="다음 10 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${endPage + 1}&set=${set}'">다음</button>
					</c:if>
					
					<c:if test="${endPage >= totalPage}">
						<button class="button button2" type="button" title="이미 마지막 10 페이지 입니다." 
								disabled="disabled">다음</button>
					</c:if>
					
					<c:if test="${currentPage < totalPage}">
						<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${totalPage}&set=${set}'">마지막</button>
					</c:if>
					
					<c:if test="${currentPage >= totalPage}">
						<button class="button button2" type="button" title="이미 마지막 페이지 입니다." disabled="disabled">
							마지막
						</button>
					</c:if>
				</td>
			</tr>
		</table>
	</div>	
</div>

<script type="text/javascript">

</script>
</body>
</html>