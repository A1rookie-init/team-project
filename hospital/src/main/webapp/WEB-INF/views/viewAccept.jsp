<%@page import="com.hospital.vo.PrescriptionTest_5List"%>
<%@page import="com.hospital.vo.MedicalComment_7VO"%>
<%@page import="com.hospital.vo.PrescriptionMed_4VO"%>
<%@page import="com.hospital.vo.PrescriptionTest_5VO"%>
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
<style type="text/css">
td {
	border: 1px solid black;
}
</style>
<title>퇴원수납</title>
<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="./js/viewAccept.js" defer="defer"></script>

</head>
<body onload="Myfuncion()">

	<jsp:include page="header/header.jsp"></jsp:include>
	<jsp:include page="./quickmenu.jsp"></jsp:include>
	
	<div style="width: 1000px; margin-left: auto; margin-right: auto; border: solid 1px; align: center;">
		<table class="table table-striped-columns">
			<tr>
				<td width="150px">환자등록번호</td>
				<td width="200px">${patientVO.patientIdx}</td>
				<td width="150px">성명</td>
				<td width="200px">${patientVO.name}</td>
				<td width="150px">성별</td>
				<td width="200px">${patientVO.gender}</td>
			</tr>
			<tr>
				<td>주민등록번호</td>
				<td>${patientVO.registNum1}-${patientVO.registNum2}</td>
				<td>나이</td>
				<td>${patientVO.age}</td>
				<td>보험종류</td>
				<td>${patientVO.insurance}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${patientVO.address}</td>
				<td>담당의사</td>
				<td>${patientVO.doctorT}</td>
				<td>담당간호사</td>
				<td>${patientVO.nurseT}</td>
			</tr>
		</table>
	</div>

	

	<div style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px; align: center;">
		
		<table class="table table-striped-columns">
				<tr>
					<th>항목</th>
					<th>횟수</th>
					<th>금액</th>
					<th>합계</th>
				</tr>
				<tr>
					<td>진찰료</td>
					<td><input type="text" value="${medicomcount}" readonly="readonly"></td>
					<td><input type="text" value="2000" readonly="readonly"></td>
					<td><input type="text" value="${medicomcount * 2000}" readonly="readonly" class="medicomcount"></td>
				</tr>
				<tr>
					<td>병실료</td>
					<c:if test="${patientVO.room.equals('1인실')}">
					<td><input type="text" value="${patientVO.room}/ ${dDay-1}일" readonly="readonly"></td>
					<td><input type="text" value="15000" readonly="readonly"></td>
					<td><input type="text" value="${(dDay-1) * 15000}" readonly="readonly" class="room"></td>
					</c:if>
					<c:if test="${patientVO.room.equals('2인실')}">
					<td><input type="text" value="${patientVO.room}/ ${dDay-1}일" readonly="readonly"></td>
					<td><input type="text" value="10000" readonly="readonly"></td>
					<td><input type="text" value="${(dDay-1) * 10000}" readonly="readonly" class="room"></td>
					</c:if>
					<c:if test="${patientVO.room.equals('6인실')}">
					<td><input type="text" value="${patientVO.room}/ ${dDay-1}일" readonly="readonly"></td>
					<td><input type="text" value="6000" readonly="readonly"></td>
					<td><input type="text" value="${(dDay-1) * 6000}" readonly="readonly" class="room"></td>
					</c:if>
				</tr>
				<tr>
					<td>식대</td>
					<c:if test="${patientVO.meal.equals('Y')}">
						<td><input type="text" value="${dDay}일 x 3" readonly="readonly"></td>
						<td><input type="text" value="10000" readonly="readonly"></td>
						<td><input type="text" value="${(dDay-1) * 10000}" readonly="readonly" class="meal"></td>
					</c:if>
					<c:if test="${!patientVO.meal.equals('Y')}">
						<td><input type="text" value="0" readonly="readonly"></td>
						<td><input type="text" value="10000" readonly="readonly"></td>
						<td><input type="text" value="0" readonly="readonly" class="meal"></td>
					</c:if>
				</tr>
				<tr>
					<td>행위료</td>
					<td><input type="text" value="${premedcount}" readonly="readonly"></td>
					<td><input type="text" value="1500" readonly="readonly"></td>
					<td><input type="text" value="${premedcount * 1500}" readonly="readonly" class="injection"></td>
				</tr>
				<tr>
					<td>약품비</td>
					<td><input type="text" value="${premedcount}" readonly="readonly"></td>
					<td><input type="text" value="1000" readonly="readonly"></td>
					<td><input type="text" value="${premedcount * 1000}" readonly="readonly" class="medicine"></td>
				</tr>
				<tr>
					<td>혈액검사료</td>
					<td><input type="text" value="${pretestBcount}" readonly="readonly"></td>
					<td><input type="text" value="2000" readonly="readonly"></td>
					<td><input type="text" value="${pretestBcount * 2000}" readonly="readonly" class="btest"></td>	
				</tr>
				<tr>
					<td>소변검사료</td>
					<td><input type="text" value="${pretestPcount}" readonly="readonly"></td>
					<td><input type="text" value="2000" readonly="readonly"></td>
					<td><input type="text" value="${pretestPcount * 2000}" readonly="readonly" class="utest"></td>
				</tr>
				<tr>
					<th>총액</th>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="text" name="total" id="total" readonly="readonly"></td>
				</tr>
			
			
		</table>
		
		
		
		<br/><br/>
		
		<div align="left" width="900px" >
		<div align="left" style="width: 600px; border: solid 1px; margin-left: auto; margin-right: auto;">
		<table class="table table-borderless">
			<c:if test="${patientVO.insurance.equals('건강보험')}">
				<thead>
					<tr>
						<th>금액</th>
						<td colspan="2">
							<input type="checkbox" name="insurance" checked="checked" disabled="disabled"> 건강보험
							<input type="checkbox" name="insurance" disabled="disabled"> 의료급여	
						</td>
					</tr>	
				</thead>
				<tbody>
					<tr>
						<th width="115" rowspan="2">&nbsp;</th>
						<th width="260">본인부담금(20%)</th>
						<th>공단부담금(80%)</th>
					</tr>
				
					<tr>
						<td><input type="text" class="healthS" readonly="readonly"></td>
						<td><input type="text" id="healthC" readonly="readonly"></td>
					</tr>
			</c:if>
			
			<c:if test="${patientVO.insurance.equals('의료급여')}">
				<thead>
					<tr>
						<th>&nbsp;</th>
						<td colspan="2">
							<input type="checkbox" name="insurance" disabled="disabled"> 건강보험
							<input type="checkbox" name="insurance" checked="checked" disabled="disabled"> 의료급여		
						</td>
					</tr>	
				</thead>
				<tbody>
					<tr>
						<th width="115">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
						<th width="260">본인부담금(10%)</th>
						<th>공단부담금(90%)</th>
					</tr>
					<tr>
						<th>금액</th>
						<td><input type="text" class="medicalS" readonly="readonly"></td>
						<td><input type="text" id="medicalC" readonly="readonly"></td>
					</tr>
				</c:if>
			</tbody>	
		</table>
	</div>
		<br/>
		<div align="right">
			<c:if test="${patientVO.insurance.equals('건강보험')}">
				결제 금액 <input type="text" class="healthS" readonly="readonly">
			</c:if>
			<c:if test="${patientVO.insurance.equals('의료급여')}">
				결제 금액 <input type="text" class="medicalS" readonly="readonly">
			</c:if>
			
				<input class="btn btn-outline-primary btn-sm" type="button" value="수납완료" onclick="location.href='insertAcceptOK?patientIdx=${patientVO.patientIdx}'">
				<button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#comment-edit-modal">검사지발급</button>
				<input class="btn btn-outline-primary btn-sm" type="button" value="약국안내도" onclick="location.href='downloadPharm?patientIdx=${patientVO.patientIdx}&dDay=${dDay}'">
		</div>
	</div>

	</div>
<!-- 모달 -->
<div class="modal fade" id="comment-edit-modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">검사지 파일</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div style="overflow: auto; height: 500px;">
					<c:forEach var="file" items="${fileList}">
						<div class="mb-3">
							<input class="form-control form-control-sm" type="text" value="${file}" readonly="readonly"
								onclick="location.href='downloadTestAction?file=${file}&patientIdx=${patientIdx}&dDay=${dDay}'"/>    
						</div>
					</c:forEach>
				</div>	
			</div>
			
		</div>
	</div>
</div>	


<jsp:include page="./header/footer.jsp"></jsp:include>

<script type="text/javascript">

{
//	모달 요소 선택
	const commentEditModal = document.querySelector('#comment-edit-modal');
//	모달 이벤트 감지
	commentEditModal.addEventListener('show.bs.modal', function (event) {
		const triggerBtn = event.relatedTarget;
	});
}

</script>

</body>
</html>