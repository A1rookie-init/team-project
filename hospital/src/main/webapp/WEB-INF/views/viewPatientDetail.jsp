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
<title>환자 상세</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/viewMain.css" />
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

</head>
<body>

<jsp:include page="header/header.jsp"></jsp:include>
<jsp:include page="./quickmenu.jsp"></jsp:include>

<div style="width: 1100px; height:730px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">
<!-- 메뉴바  -->
	<div style="padding: 10px;">
		<input type="button" value="환자정보조회" onclick="location.href='viewPatientDetailUpdate?patientIdx=${patientVO.getPatientIdx()}&dDay=${dDay}'"/>
		<input type="button" value="의무기록조회" onclick="location.href='viewListMedical?patientIdx=${patientVO.patientIdx}&dDay=${dDay}'" /> 
		<input type="button" value="간호기록조회" onclick="location.href='viewListNursing?patientIdx=${patientVO.patientIdx}&dDay=${dDay}'" /> 
		<input type="button" value="검사결과조회" onclick="location.href='viewListTest?patientIdx=${patientVO.getPatientIdx()}&dDay=${dDay}'"/> 
	</div>
		
	<div>
		<header style="align-items: center;">
			<!-- 환자Tag -->
			<div style="width: 500px; border: solid 1px; margin-top: 30px; margin-left: auto; margin-right: auto; position: relative; font-size: 20px; font-weight:bold;" align="center">
			${patientVO.getPatientIdx()} ${patientVO.getName()} ${patientVO.getAge()}/${patientVO.getGender()} ${patientVO.getDiagnosis()} D+${dDay}
		</div>
		</header>
		
		<section>
			<article>
				<div style="border: solid 1px; width: 460px; height: 500px; margin-left: 40px;">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th colspan="2" height="40px;">
									치료 정보
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th width="120px;" height="110px;">증상</th>
								<td>
									${patientVO.cc}
								</td>
							</tr>
							<tr>
								<th height="110px;">현병력</th>
								<td>
									${patientVO.pi}
								</td>
							</tr>
							<tr>
								<th height="110px;">과거력</th>
								<td>
									${patientVO.histroy}
								</td>
							</tr>
							<tr>
								<th height="110px;">알레르기</th>
								<td>
									${patientVO.allergy}
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</article>
			<article>
				<div style="margin-right: 50px;">
					<div style="border: solid 1px; width: 460px; height: 460px;">
						<table class="table table-bordered">
							<tr>
								<th width="120px;" height="300px;">치료 계획</th>
								<td>
									${patientVO.carePlan}
								</td>
							</tr>
							<tr>
								<th height="110px;">퇴원예정일</th>
								<td>
									${patientVO.exDisDate}
								</td>
							</tr>
							<!-- 초진버튼(임시) css작업시 위치 조정 예정 -->
							
							<tr>
								<c:if test="${dpart == '의사'}">
									<td align="right" colspan="2">
										<input type="button" value="초진"  onclick="location.href='updatePatient?employeeIdx=${employeeIdx}employeeName=${employeeName}&patientIdx=${patientVO.patientIdx}&name=${patientVO.getName()}&dDay=${dDay}'" />
									</td>
								</c:if>
							</tr>
						</table>
					</div>
					<div>
						<input type="button" value="진료수행" onclick="location.href='viewMedical?patientIdx=${patientVO.patientIdx}&dDay=${dDay}'" /> 
						<input type="button" value="간호수행" onclick="location.href='viewNursing?patientIdx=${patientVO.patientIdx}&dDay=${dDay}'" /> 
						<input type="button" value="검사수행" onclick="location.href='viewTest?patientIdx=${patientVO.patientIdx}&dDay=${dDay}'" />
		
					</div>
				</div>
			</article>
		</section>
	</div>
</div>

<!-- footer삽입 -->
<jsp:include page="./header/footer.jsp"></jsp:include>
</body>
</html>
