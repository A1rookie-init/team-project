<%@page import="java.util.Map"%>
<%@page import="com.hospital.vo.Patient_1VO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>퇴원환자 정보조회</title>

<link rel="shortcut icon" type="image/x-icon" href="./images/logo.ico" />
</head>
<body>
<div>
<!-- header 페이지 삽입  -->
<jsp:include page="../header/header_goback_DisPatient.jsp"></jsp:include>
</div>

<div style="width: 1100px; height:730px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">
<fmt:formatDate var= "adDate" value="${patientVo.getAdDate()}" pattern="yyyy.MM.dd(E)"/>
<fmt:formatDate var= "DisDate" value="${patientVo.getDisDate()}" pattern="yyyy.MM.dd(E)"/>
	<div style="width: 500px; margin-left: 30px; margin-top: 50px;  margin-bottom: 50px; border: solid 1px; float: left; position: relative;">
		<form action="viewPatientDetailUpdateOK.jsp" method="post" name="viewPatientDetailUpdate">
			<table class="table table-bordered" style="height: 600px;">
			<thead>
				<tr class="table-success"  style="height: 50px; vertical-align: middle;">
					<th colspan="2" >
						기본 정보
					</th>
				</tr>
			</thead>
			<tbody>
		
				<tr>
					<th width="150px;">환자 등록 번호</th>
					<td>
						&nbsp;&nbsp;&nbsp;${patientVo.patientIdx}
					</td>
				</tr>
				<tr>
					<th>성명</th>
					<td>
						&nbsp;&nbsp;&nbsp;${patientVo.name}
					</td>
				</tr>
				<tr>
					<th>주민등록번호</th>
					<td colspan="2">
						&nbsp;&nbsp;&nbsp;${patientVo.registNum1} -${patientVo.registNum2}				
					</td>
				</tr>
				<tr>
					<th class="warning" style="vertical-align: middle;">나이</th>
					<td>
						&nbsp;&nbsp;&nbsp;${patientVo.age} 세
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<c:if test="${patientVo.gender == 'M'}">
							&nbsp;&nbsp;&nbsp;남성
						</c:if>
						<c:if test="${patientVo.gender == 'F'}">
							&nbsp;&nbsp;&nbsp;여성
						</c:if>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td> &nbsp;&nbsp;&nbsp;${patientVo.address}</td>
				</tr>
				<tr>
					<th>보험 종류</th>
					<td>
						<c:if test="${patientVo.insurance == '건강보험'}">
							&nbsp;&nbsp;&nbsp;건강보험
						</c:if>
						<c:if test="${patientVo.insurance == '의료급여'}">
							&nbsp;&nbsp;&nbsp;의료급여
						</c:if>
					</td>
				</tr>
				<tr>
					<th>입원실</th>
					<td>
						<c:if test="${patientVo.room == '6인실'}">
							&nbsp;&nbsp;&nbsp;6인실
						</c:if>
						<c:if test="${patientVo.room == '2인실'}">
							&nbsp;&nbsp;&nbsp;2인실
						</c:if>
						<c:if test="${patientVo.room == '1인실'}">
							&nbsp;&nbsp;&nbsp;1인실
						</c:if>
					</td>
				</tr>
				<tr>
					<th>식사</th>
					<td>
						<c:if test="${patientVo.meal == true}">
							&nbsp;&nbsp;&nbsp;식사 신청
						</c:if>
						<c:if test="${patientVo.meal == false}">
								&nbsp;&nbsp;&nbsp;식사 신청안함
						</c:if>
					</td>
				</tr>
				<tr>
					<th>담당교수</th>
					<td>
						<c:if test="${patientVo.doctorT == 'A'}">
							&nbsp;&nbsp;&nbsp;의사 A팀
						</c:if>
						<c:if test="${patientVo.doctorT == 'B'}">
							&nbsp;&nbsp;&nbsp;의사 B팀					
						</c:if>
						<c:if test="${patientVo.doctorT == 'C'}">
							&nbsp;&nbsp;&nbsp;의사 C팀					
						</c:if>
					</td>
				</tr>
				<tr>
					<th>간호팀</th>
					<td>
						<c:if test="${patientVo.nurseT == 'A'}">
							&nbsp;&nbsp;&nbsp;간호 A팀						
						</c:if>
						<c:if test="${patientVo.nurseT == 'B'}">
							&nbsp;&nbsp;&nbsp;간호 B팀						
						</c:if>
						<c:if test="${patientVo.nurseT == 'C'}">
							&nbsp;&nbsp;&nbsp;간호 C팀					
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
	</div>
	<div style="width: 500px; margin-right: 30px; margin-top: 50px;  margin-bottom: 50px; border: solid 1px; float: right; position: relative;">
	<table class="table table-bordered"  style="height: 600px;">
			<tr class="table-success" style="height: 50px; vertical-align: middle;">
				<th colspan="2">초진 정보</th>
			</tr>
			<tr>
				<th width="150;">증상</th>
				<td>
					${patientVo.cc}
				</td>
			</tr>
			<tr>
				<th>현병력</th>
				<td>
					${patientVo.pi}
				</td>
			</tr>
			<tr>
				<th>과거력</th>
				<td>
					${patientVo.histroy}
				</td>
			</tr>
			<tr>
				<th>알레르기</th>
				<td>
					${patientVo.allergy}
				</td>
			</tr>
			<tr>
				<th>흡연여부</th>
				<td>
					${patientVo.alcohol}
				</td>
			</tr>
			<tr>
				<th>음주여부</th>
				<td>
					${patientVo.smoking}
				</td>
			</tr>
			<tr>
				<th>진단명</th>
				<td>
					${patientVo.diagnosis}
				</td>
			</tr>
			<tr>
				<th>치료계획</th>
				<td>
					${patientVo.carePlan}
				</td>
			</tr>
			<tr>
				<th>입원일 / 퇴원일</th>
				<td>
					${adDate} / ${DisDate}
				</td>
			</tr>
		</table>
</div>
</div>

<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>
</body>
</html>
