<%@page import="java.text.Format"%>
<%@page import="com.hospital.vo.ViewNursingVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.hospital.vo.NoticeToP_14VO"%>
<%@page import="com.hospital.vo.NursingComment_13VO"%>
<%@page import="com.hospital.vo.VitalSign_10VO"%>
<%@page import="com.hospital.vo.VitalSign_10List"%>
<%@page import="com.hospital.vo.Injection_11VO"%>
<%@page import="com.hospital.vo.Injection_11List"%>
<%@page import="com.hospital.vo.PrescriptionMed_4List"%>
<%@page import="com.hospital.vo.PrescriptionMed_4VO"%>
<%@page import="com.hospital.vo.Patient_1VO"%>
<%@page import="com.hospital.vo.NursingComment_13_List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간호기록 조회</title>

<style type="text/css">

th {
	border: solid 1px;
}
td {
	border: solid 1px;
}

</style>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

</head>
<body>


<!-- (주의!!!!) 하루치 기록이 나올때 해당 날짜가 나오는데, 그 날짜는 활력징후기록 데이터에서 가져오게 해두었다. -->
<!-- 그래서 하루에 활력징후 기록이 1개도 없으면 에러가 뜬다!!! 하루에 활력징후기록 한개는 무조건 넣어야함..  -->
<!-- 더미데이터에 모든날 최소 1개의 활력징후 기록을 넣는다.  -->


<!-- header 페이지 삽입  -->
<jsp:include page="../header/header_goback_PDetail.jsp"></jsp:include>
<%-- <jsp:include page="./quickmenu.jsp"></jsp:include> --%>

<div style="width: 1000px; border: solid 1px; position: absolute; top: 60px; left: 300px; padding: 5px;">

	<fmt:formatDate var= "adDate" value="${patientVO.getAdDate()}" pattern="yyyy.MM.dd(E)"/>
	
	<c:set var="view" value="${viewNursingList.viewNursingVOList}"/>
	<c:if test="${view.size() == 0}">
						<marquee> 기록된 글이 없습니다.</marquee>
	</c:if>
					
	<c:if test="${view.size() != 0}">
		<c:forEach var="i" begin="0" end="${view.size()-1}" step="1">
						
			<div style="width: 950px; border: solid 1px; padding: 10px; margin: 20px; position: relative;">
	
				<c:set var="vitalSignList" value="${view.get(i).getVitalSignList()}"/>
				<!-- 환자정보 (환자Tag) -->
				<div style="width: 700px; border: solid 1px; margin-top: 30px; margin-left: 80px; position: relative;" align="center">
					${patientVO.getPatientIdx()}&nbsp;&nbsp;${patientVO.getName()}&nbsp;&nbsp;${patientVO.getAge()}/${patientVO.getGender()}&nbsp;&nbsp;${patientVO.getDiagnosis()}   
					&nbsp;&nbsp;입원일 : ${adDate} <br/>
				</div> <br/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;기록일 : <fmt:formatDate value="${vitalSignList.vitalSignList.get(0).writeDate}" pattern="yyyy.MM.dd(E)"/> 		
		
		
				<div style="width: 600px; margin-top: 30px; margin-left: 30px; position: relative;">
					<table class="table table-bordered border-dark">
						<thead>
							<tr>
								<th colspan="5">
									활력징후 기록
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th width="70px">시간 </th>
								<th width="70px">혈압</th>
								<th width="70px">맥박</th>
								<th width="70px">체온</th> 
								<th width="70px">호흡</th> 
							</tr>
							<c:if test="${vitalSignList.vitalSignList.size() != 0}">
							<c:forEach var="vitalVO" items="${vitalSignList.vitalSignList}">
							<tr>
						 		<th width="70px">
						 			${vitalVO.vitalTime}
						 		</th>
							 	<td>
							 		${vitalVO.bp}
							 	</td>
							 	<td>
							 		${vitalVO.hr}
							 	</td>
							 	<td>
							 		${vitalVO.bt}
							 	</td>
							 	<td>
							 		${vitalVO.rr}
							 	</td>
						 	</tr>
						</c:forEach>
						</c:if>
						<c:if test="${vitalSignList.vitalSignList.size() == 0}">
							<tr>
								<td>
									활력징후 내역이 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		
		<div style="width: 800px; margin-top: 30px; margin-left: 30px; position: relative;">
			<table class="table table-bordered border-dark">
				<thead>
					<tr>
						<th colspan="9">
							투약기록
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th width="120px">처방시각</th>
						<th width="180px">약명</th>
						<th width="70px">용량</th>
						<th width="60px">경로</th>
						<th width="100px">횟수</th>
						<th>9A</th>
						<th>1P</th>
						<th>6P</th> 
						<th>9P</th>
					</tr>
					<c:set var="injectionList" value="${view.get(i).getInjectionList()}"/>	
					<c:if test="${injectionList.injectionList.size() != 0}">
						<c:forEach var="injectionVO" items="${injectionList.injectionList}">
				
							<tr>
				 				<td><fmt:formatDate value="${injectionVO.writedate}" pattern="a h:mm:ss"/></td>
								<td>${injectionVO.medicine}</td>
								<td>${injectionVO.route}</td>
								<td>${injectionVO.dosage}</td>
								<td>${injectionVO.injectTime}</td>
						
								<c:if test="${injectionVO.realTime9A != 'Y'}">
									<td>
										<input type="checkbox"  disabled="disabled"/>
									</td>
								</c:if>
						
								<c:if test="${injectionVO.realTime9A == 'Y'}">
									<td>
										<input type="checkbox" checked="checked" disabled="disabled"/>
									</td>
								</c:if>
						
								<c:if test="${injectionVO.realTime1P != 'Y'}">
									<td>
										<input type="checkbox" disabled="disabled"/>
									</td>
								</c:if>
								
								<c:if test="${injectionVO.realTime1P == 'Y'}">
									<td>
										<input type="checkbox" checked="checked" disabled="disabled"/>
									</td>
								</c:if>
							
								<c:if test="${injectionVO.realTime6P != 'Y'}">
									<td>
										<input type="checkbox" disabled="disabled"/>
									</td>
								</c:if>
								
								<c:if test="${injectionVO.realTime6P == 'Y'}">
									<td>
										<input type="checkbox" checked="checked" disabled="disabled"/>
									</td>
								</c:if>
							
								<c:if test="${injectionVO.realTime9P != 'Y'}">
									<td>
										<input type="checkbox" disabled="disabled"/>
									</td>
								</c:if>
							
								<c:if test="${injectionVO.realTime9P == 'Y'}">
									<td>
										<input type="checkbox" checked="checked" disabled="disabled"/>
									</td>
								</c:if>	
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${injectionList.injectionList.size() == 0}">
						<tr>
							<td colspan="9">
								처방내역이 없습니다.
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		
		<div style="width: 800px; margin-top: 30px; margin-left: 30px; position: relative;">
			<table class="table table-bordered border-dark">
				<thead>
					<tr>
						<th colspan="2">
							간호기록
						</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="nursingCommentList" value="${view.get(i).getNursingCommentList()}"/>
					<c:if test="${nursingCommentList.nursingCommentList.size() != 0}">
						<c:forEach var="vo" items="${nursingCommentList.nursingCommentList}">
					
							<tr>
						 		<td><fmt:formatDate value="${vo.writedate}" pattern="a h:mm:ss"/> </td>
					 			<td width="680px">${vo.recordN}</td>
				 			</tr>
						</c:forEach>
					</c:if>
					<c:if test="${nursingCommentList.nursingCommentList.size() == 0}">
						<tr>
							<td colspan="2">
								간호기록이 없습니다.
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
					<c:if test="${viewNursingList.currentPage > 1}">
						<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
								onclick="location.href='?currentPage=1&patientIdx=${patientIdx}&dDay=${dDay}'">처음</button>
					</c:if>
					<c:if test="${viewNursingList.currentPage <= 1}">
						<button class="button button2" type="button" title="이미 첫 페이지 입니다." 
								disabled="disabled">처음</button>
					</c:if>
					<!-- 5페이지 앞으로 -->
					<c:if test="${viewNursingList.startPage > 1}">
						<button class="button button1" type="button" title="이전 5 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${viewNursingList.startPage - 1}&patientIdx=${patientIdx}&dDay=${dDay}'">
							이전
						</button>
					</c:if>
					<c:if test="${viewNursingList.startPage <= 1}">
						<button class="button button2" type="button" title="이미 첫 5 페이지 입니다." 
								disabled="disabled">이전</button>
					</c:if>
					<!-- 페이지 이동 -->
					<c:forEach var="i" begin="${viewNursingList.startPage}" end="${viewNursingList.endPage}" step="1">
						<c:if test="${viewNursingList.currentPage == i}">
							<button class="button button2" type="button" disabled="disabled">${i}</button>
						</c:if>
						<c:if test="${viewNursingList.currentPage != i}">
							<button class="button button1" type="button" onclick="location.href='?currentPage=${i}&patientIdx=${patientIdx}&dDay=${dDay}'">
								${i}
							</button>
						</c:if>
					</c:forEach>
					<!-- 5페이지 뒤로 -->
					<c:if test="${viewNursingList.endPage < viewNursingList.totalPage}">
						<button class="button button1" type="button" title="다음 5 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${viewNursingList.endPage + 1}&patientIdx=${patientIdx}&dDay=${dDay}'">다음</button>
					</c:if>
					<c:if test="${viewNursingList.endPage >= viewNursingList.totalPage}">
						<button class="button button2" type="button" title="이미 마지막 5 페이지 입니다." 
								disabled="disabled">다음</button>
					</c:if>
					<!-- 마지막으로 -->
					<c:if test="${viewNursingList.currentPage < viewNursingList.totalPage}">
						<button class="button button1" type="button" title="마지막 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${viewNursingList.totalPage}&patientIdx=${patientIdx}&dDay=${dDay}'">마지막</button>
					</c:if>
					<c:if test="${viewNursingList.currentPage >= viewNursingList.totalPage}">
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
