<%@page import="java.text.Format"%>
<%@page import="com.hospital.vo.ViewMedicalVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hospital.vo.NoticeToP_14VO"%>
<%@page import="com.hospital.vo.VitalSign_10VO"%>
<%@page import="com.hospital.vo.VitalSign_10List"%>
<%@page import="com.hospital.vo.Injection_11VO"%>
<%@page import="com.hospital.vo.Injection_11List"%>
<%@page import="com.hospital.vo.PrescriptionMed_4List"%>
<%@page import="com.hospital.vo.PrescriptionMed_4VO"%>
<%@page import="com.hospital.vo.Patient_1VO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퇴원환자 의무기록 조회</title>

<style type="text/css">

</style>
</head>
<body>


<!--  (주의!!!!) 하루치 기록이 나올때 해당일의 날짜가 나오는데, 그 날짜는 진료기록 데이터에서 가져오게 해두었다. -->
<!-- 				그래서 하루에 진료기록이 1개도 없으면 에러가 뜬다!!! 하루 당 진료기록 한개는 무조건 넣어야함..  -->


<!-- header 페이지 삽입  -->
<jsp:include page="../header/header_goback_DisPatient.jsp"></jsp:include>

<div style="width: 1000px; border: solid 1px; position: absolute; top: 60px; left: 300px; padding: 5px;">

<fmt:formatDate var= "adDate" value="${patientVO.getAdDate()}" pattern="yyyy.MM.dd(E)"/>
<fmt:formatDate var= "DisDate" value="${patientVO.getDisDate()}" pattern="yyyy.MM.dd(E)"/>


<c:set var="view" value="${viewMedicalList.viewMedicalVOList}"/>
<c:if test="${view.size() == 0}">
					<marquee> 기록된 글이 없습니다.</marquee>
</c:if>
				
<c:if test="${view.size() != 0}">


<c:forEach var="i" begin="0" end="${view.size()-1}" step="1">
					
<c:set var="medicalCommentList" value="${view.get(i).getMedicalCommentList()}"/>

<div style="width: 900px; border: solid 1px; padding: 10px; margin: 20px; position: relative;">

<!-- 환자정보 (환자Tag) -->
	<div style="width: 700px; border: solid 1px; margin-top: 30px; margin-left: 80px; position: relative;" align="center">
		${patientVO.getPatientIdx()}&nbsp;&nbsp;${patientVO.getName()}&nbsp;&nbsp;${patientVO.getAge()}/${patientVO.getGender()}&nbsp;&nbsp;${patientVO.getDiagnosis()}   
		&nbsp;&nbsp;입원일 : ${adDate} &nbsp;&nbsp;퇴원일 : ${DisDate}
	</div> <br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;기록일 : <fmt:formatDate value="${medicalCommentList.medicalCommentList.get(0).writeDate}" pattern="yyyy.MM.dd(E)"/> 		
	
	<div style="width: 800px;margin-top: 20px; margin-left: 30px; position: relative;">
		<table class="table table-bordered border-dark">
			<thead>
				<tr>
					<th colspan="6">
						처방내역
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th width="20px;">&nbsp;</th>
					<th width="120px;">처방시각</th>
					<th width="400px;">약명</th>
					<th width="80px;">용량</th>
					<th width="80px;">경로</th>
					<th width="80px;">횟수</th>
				</tr>
				<c:set var="prescriptionMedList" value="${view.get(i).getPrescriptionMedList()}"/>
				<c:if test="${prescriptionMedList.prescriptionMedList.size() != 0}">
					<c:forEach var="prescriptionMedVO" items="${prescriptionMedList.prescriptionMedList}">
						<tr>
						<td><img alt="화살표" src="./images/arrow2.png" width="20"/> &nbsp;&nbsp;</td> 
							<td><fmt:formatDate value="${prescriptionMedVO.writedate}" pattern="a h:mm:ss" /></td>
							<td>${prescriptionMedVO.medicine}</td>
							<td>${prescriptionMedVO.dosage}</td>
							<td>${prescriptionMedVO.route}</td>
							<td>${prescriptionMedVO.injectTime}</td>
						</tr>
			</c:forEach>
		</c:if>
		<c:set var="prescriptionTestList" value="${view.get(i).getPrescriptionTestList()}"/>
		<c:if test="${prescriptionTestList.prescriptionTestList.size() != 0}">
			<c:forEach var="prescriptionTestVO" items="${prescriptionTestList.prescriptionTestList}">
					<tr>
						<td><img alt="화살표" src="./images/arrow2.png" width="20"/> &nbsp;&nbsp;</td> 
						<td style="border: solid 1px;"><fmt:formatDate value="${prescriptionTestVO.writedate}" pattern="a h:mm:ss" /></td>
						<td colspan="4">${prescriptionTestVO.test}</td>
					</tr>
			</c:forEach>
		</c:if>
		<c:if test="${prescriptionMedList.prescriptionMedList.size() == 0}">
			<c:if test="${prescriptionTestList.prescriptionTestList.size() == 0}">
				<tr>
					<td colspan="6"> 처방내역이 없습니다.</td>
				</tr>					
			</c:if>
		</c:if> 
	</tbody>
</table>
</div>
				
			
		<div style="width: 800px; margin-top: 30px; margin-left: 30px; position: relative;">
			<table class="table table-bordered border-dark">
				<thead>
					<tr>
						<th colspan="2">
							진료기록
						</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${medicalCommentList.medicalCommentList.size() != 0}">
						<c:forEach var="vo" items="${medicalCommentList.medicalCommentList}">
							<c:set var="commentName" value="comment${vo.idx}"></c:set>
								<tr>
							 		<td width="150px;">
							 			<fmt:formatDate value="${vo.writeDate}" pattern="a h:mm:ss"/>
							 		</td>
								 	<td>
								 		${vo.recordD}
								 	</td>
								 	
							 	</tr>
					</c:forEach>
				</c:if>
				<c:if test="${medicalCommentList.medicalCommentList.size() == 0}">
					<tr>
						<td colspan="2">
							진료기록이 없습니다.
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>		
</div>
			
</c:forEach>
</c:if>	
	
<div style="position: relative; left: 330px; margin-top: 50px; margin-bottom: 20px">
	<table>
		<!-- 페이지 이동 버튼 -->
		<tr>
			<td align="center">
				<!-- 처음으로 -->
				<c:if test="${viewMedicalList.currentPage > 1}">
					<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
							onclick="location.href='?currentPage=1&patientIdx=${patientIdx}&dDay=${dDay}'">처음</button>
				</c:if>
				<c:if test="${viewMedicalList.currentPage <= 1}">
					<button class="button button2" type="button" title="이미 첫 페이지 입니다." disabled="disabled">처음</button>
				</c:if>
				<!-- 5페이지 앞으로 -->
				<c:if test="${viewMedicalList.startPage > 1}">
					<button class="button button1" type="button" title="이전 5 페이지로 이동합니다." 
							onclick="location.href='?currentPage=${viewMedicalList.startPage - 1}&patientIdx=${patientIdx}&dDay=${dDay}'">
						이전
					</button>
				</c:if>
				<c:if test="${viewMedicalList.startPage <= 1}">
					<button class="button button2" type="button" title="이미 첫 5 페이지 입니다." disabled="disabled">이전</button>
				</c:if>
				<!-- 페이지 이동 -->
				<c:forEach var="i" begin="${viewMedicalList.startPage}" end="${viewMedicalList.endPage}" step="1">
					<c:if test="${viewMedicalList.currentPage == i}">
						<button class="button button2" type="button" disabled="disabled">${i}</button>
					</c:if>
					<c:if test="${viewMedicalList.currentPage != i}">
						<button class="button button1" type="button" onclick="location.href='?currentPage=${i}&patientIdx=${patientIdx}&dDay=${dDay}'">
							${i}
						</button>
					</c:if>
				</c:forEach>
				<!-- 5페이지 뒤로 -->
				<c:if test="${viewMedicalList.endPage < viewMedicalList.totalPage}">
					<button class="button button1" type="button" title="다음 5 페이지로 이동합니다." 
							onclick="location.href='?currentPage=${viewMedicalList.endPage + 1}&patientIdx=${patientIdx}&dDay=${dDay}'">다음
					</button>
				</c:if>
				<c:if test="${viewMedicalList.endPage >= viewMedicalList.totalPage}">
					<button class="button button2" type="button" title="이미 마지막 5 페이지 입니다." disabled="disabled">다음</button>
				</c:if>
				<!-- 마지막으로 -->
				<c:if test="${viewMedicalList.currentPage < viewMedicalList.totalPage}">
					<button class="button button1" type="button" title="마지막 페이지로 이동합니다." 
							onclick="location.href='?currentPage=${viewMedicalList.totalPage}&patientIdx=${patientIdx}&dDay=${dDay}'">마지막
					</button>
				</c:if>
				<c:if test="${viewMedicalList.currentPage >= viewMedicalList.totalPage}">
					<button class="button button2" type="button" title="이미 마지막 페이지 입니다." disabled="disabled">
						마지막
					</button>
				</c:if>
			</td>
		</tr>
	</table>
</div>
</div>

<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>
</body>
</html>

