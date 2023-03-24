<%@page import="com.hospital.vo.Patient_1List_All"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퇴원 환자 조회</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />


</head>
<body>

	<jsp:include page="../header/header.jsp"></jsp:include>


	<div style="width: 900px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">

		<form action="viewDisPatientMiddle" method="post">
			<div style=" margin-top: 20px; margin-left: 50px;">
				<label for="pIdx">
					<input type="radio" name="set" value="pIdx" id="pIdx" onclick="checkOnly(1)"/> 환자등록번호
				</label>
				<label for="pName">				
					<input type="radio" name="set" value="pName" id="pName" onclick="checkOnly(2)"/> 환자명
				</label>
				<label for="pDisDate">				
					<input type="radio" name="set" value="pDisDate" id="pDisDate" onclick="checkOnly(3)"/> 퇴원일
				</label>
				&nbsp;
				&nbsp;
				<input type="text" name="item" id="item">
				<input type="submit" value="검색">
				&nbsp;
				&nbsp;
				<select name="category" style="width: 120px;">
					<option value="vMed">진료기록조회</option>
					<option value="vNur">간호기록조회</option>
					<option value="vTest">검사결과조회</option>
					<option value="vPt">환자정보조회</option>
				</select>
			</div>
		</form>	
		
		<br>
		
		<div style="width: 600px; margin-left: 50px; margin-bottom : 30px; border: solid 1px;">

		<c:if test="${patient_1List_Item.patient_1List_Item.size() != 0}">
			<c:set var="patientList" value="${patient_1List_Item.patient_1List_Item}"/>
			<c:set var="item" value="${patient_1List_Item.item}"/>
			<c:set var="currentPage" value="${patient_1List_Item.currentPage}"/>
			<c:set var="startPage" value="${patient_1List_Item.startPage}"/>
			<c:set var="endPage" value="${patient_1List_Item.endPage}"/>
			<c:set var="totalPage" value="${patient_1List_Item.totalPage}"/>
	
			<c:if test="${category == 'vMed'}"> 
				<c:forEach var="patientVO" items="${patientList}">
				<fmt:formatDate var="disDay" value="${patientVO.disDate}" pattern="yyyyMMdd" />
					<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
						<tr>
							<td>
								<button style="width:593px; text-align: left;" onclick="location.href='viewDisPatientMedical?patientIdx=${patientVO.patientIdx}'">
									${patientVO.patientIdx}&nbsp;&nbsp;&nbsp;${patientVO.name}&nbsp;&nbsp;&nbsp;${patientVO.age}/${patientVO.gender}
									&nbsp;&nbsp;&nbsp;${patientVO.diagnosis}&nbsp;&nbsp;&nbsp;퇴원일 : ${disDay}
								</button>
							</td>						 	
						</tr>
					</table>		
				</c:forEach>
			</c:if>
			
			<c:if test="${category == 'vNur'}"> 
				<c:forEach var="patientVO" items="${patientList}">
				<fmt:formatDate var="disDay" value="${patientVO.disDate}" pattern="yyyyMMdd" />
					<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
						<tr>
							<td>
								<button style="width:593px; text-align: left;" onclick="location.href='viewDisPatientNursing?patientIdx=${patientVO.patientIdx}'">
									${patientVO.patientIdx}&nbsp;&nbsp;&nbsp;${patientVO.name}&nbsp;&nbsp;&nbsp;${patientVO.age}/${patientVO.gender}
									&nbsp;&nbsp;&nbsp;${patientVO.diagnosis}&nbsp;&nbsp;&nbsp;퇴원일 : ${disDay}
								</button>
							</td>						 	
						</tr>
					</table>		
				</c:forEach>			
			</c:if>
			
			<c:if test="${category == 'vTest'}">
				<c:forEach var="patientVO" items="${patientList}">
				<fmt:formatDate var="disDay" value="${patientVO.disDate}" pattern="yyyyMMdd" />
					<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
						<tr>
							<td>
								<button style="width:593px; text-align: left;" onclick="location.href='viewDisPatientTest?patientIdx=${patientVO.patientIdx}'">
									${patientVO.patientIdx}&nbsp;&nbsp;&nbsp;${patientVO.name}&nbsp;&nbsp;&nbsp;${patientVO.age}/${patientVO.gender}
									&nbsp;&nbsp;&nbsp;${patientVO.diagnosis}&nbsp;&nbsp;&nbsp;퇴원일 : ${disDay}
								</button>
							</td>						 	
						</tr>
					</table>		
				</c:forEach>			
			</c:if>
			
			<c:if test="${category == 'vPt'}"> 
				<c:forEach var="patientVO" items="${patientList}">
				<fmt:formatDate var="disDay" value="${patientVO.disDate}" pattern="yyyyMMdd" />
					<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
						<tr>
							<td>
								<button style="width:593px; text-align: left;" onclick="location.href='viewDisPatientData?patientIdx=${patientVO.patientIdx}'">
									${patientVO.patientIdx}&nbsp;&nbsp;&nbsp;${patientVO.name}&nbsp;&nbsp;&nbsp;${patientVO.age}/${patientVO.gender}
									&nbsp;&nbsp;&nbsp;${patientVO.diagnosis}&nbsp;&nbsp;&nbsp;퇴원일 : ${disDay}
								</button>
							</td>						 	
						</tr>
					</table>		
				</c:forEach>			
			</c:if>
		</c:if>
		<c:if test="${patient_1List_Item.patient_1List_Item.size() == 0}">
			<c:if test="${category == null}">
				<tr>
					<td>
						검색 조건에 해당하는 퇴원환자가 없습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${category != null}"> 
				<tr>
					<td>
						검색 조건에 해당하는 퇴원환자가 없습니다.
					</td>
				</tr>
			</c:if>
		</c:if>
	</div>	
	
	<div style="position: relative; left: 330px; margin-top: 50px; margin-bottom: 20px">
			<table>
			<!-- 페이지 이동 버튼 -->
			<tr>
				<td align="center">
					<!-- 처음으로 -->
					<c:if test="${currentPage > 1}">
						<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
								onclick="location.href='?currentPage=1&item=${item}&set=${set}&category=${category}'">처음</button>
					</c:if>
					
					<c:if test="${currentPage <= 1}">
						<button class="button button2" type="button" title="이미 첫 페이지 입니다." 
								disabled="disabled">처음</button>
					</c:if>
					
					<!-- 5페이지 앞으로 -->
					<c:if test="${startPage > 1}">
						<button class="button button1" type="button" title="이전 10 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${startPage - 1}&item=${item}&set=${set}&category=${category}'">
							이전
						</button>
					</c:if>
					
					<c:if test="${startPage <= 1}">
						<button class="button button2" type="button" title="이미 첫 10 페이지 입니다." 
								disabled="disabled">이전</button>
					</c:if>
	
					<!-- 페이지 이동 -->
					<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
					
						<c:if test="${currentPage == i}">
							<button class="button button2" type="button" disabled="disabled">${i}</button>
						</c:if>
						
						<c:if test="${currentPage != i}">
							<button class="button button1" type="button" onclick="location.href='?currentPage=${i}&item=${item}&set=${set}&category=${category}'">
								${i}
							</button>
						</c:if>
					
					</c:forEach>
	
					<!-- 5페이지 뒤로 -->
					<c:if test="${endPage < totalPage}">
						<button class="button button1" type="button" title="다음 10 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${endPage + 1}&item=${item}&set=${set}&category=${category}'">다음</button>
					</c:if>
					<c:if test="${endPage >= totalPage}">
						<button class="button button2" type="button" title="이미 마지막 10 페이지 입니다." 
								disabled="disabled">다음</button>
					</c:if>
					<!-- 마지막으로 -->
					<c:if test="${currentPage < totalPage}">
						<button class="button button1" type="button" title="마지막 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${totalPage}&item=${item}&set=${set}&category=${category}'">마지막</button>
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



<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>
<script type="text/javascript">

onload = () => {
	let item = document.querySelector('#item');
	item.focus();
	
}

function checkOnly(obj) {
	if (obj == 1) {
		
		if (item.type == 'date') {
			item.type = 'type';
		} 
		item.value = '';
		item.focus();
		
	} else if (obj == 2) {
		if (item.type == 'date') {
			item.type = 'type';
		} 
		item.value = '';
		item.focus();
		
	} else if (obj == 3) {
		if (item.type == 'text') {
			item.type = 'date';
		} 
	}
}

</script>
				
</body>
</html>