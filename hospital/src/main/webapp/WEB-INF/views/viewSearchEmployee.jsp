<%@page import="com.hospital.vo.Dpart_23List"%>
<%@page import="com.hospital.vo.Employee_20List"%>
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
<title>사내검색</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

<style type="text/css">
/* 검색 때 일치하는 단어 표시 */
	#highlight {
		font-weight: bold;
		background: yellow;
	}
</style>

</head>
<body>

<!-- header -->
<jsp:include page="./header/header.jsp"></jsp:include>
<jsp:include page="./quickmenu.jsp"></jsp:include>

<div style="width: 900px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">

	<form action="viewSearchEmployeeAfter" method="post">
			<div style=" margin-top: 20px; margin-left: 50px;">
				<label for="eName">
					<input type="radio" name="set" value="eName" id="eName" onclick="checkOnly(1)"/> 사원명
				</label>
				<label for="pName">
					<input type="radio" name="set" value="pName" id="pName" onclick="checkOnly(2)"/> 부서명
				</label>
				&nbsp;
				&nbsp;
				<input type="text" name="item" id="item">
				<input type="submit" value="검색">
				&nbsp;
				&nbsp;
			</div>
		</form>	
		
	<br>
	
	<div style="width: 800px; margin-left: 50px; margin-bottom : 30px; border: solid 1px;">

		<c:if test="${employeeList != null}">
			<c:set var="item" value="${employeeList.item}"/>
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
					</tr>						 	
				</table>		
				<c:forEach var="employeeVO" items="${employeeList.employeeList}">
				<c:if test="${employeeVO.dpart != 'del'}">
					<button type="button" class="btn btn-outline-success btn-sm" style="border-color: black;"
							data-bs-toggle="modal"
							data-bs-target="#comment-edit-modal"
							data-bs-img="${employeeVO.orgFileName}"
							data-bs-eidx="${employeeVO.employeeIdx}"
							data-bs-name="${employeeVO.name}"
							data-bs-dnum="${employeeVO.dnumber}"
							data-bs-enum="${employeeVO.enumber}">
					
					<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
						<tr>
							<td style="width: 125px; text-align: center;">${employeeVO.employeeIdx}</td>
							<td style="width: 125px; text-align: center;">
								<!-- 사원 성명에 포함된 검색어를 강조해서 표시한다. -->
								<c:set var="search" value="<span id='highlight'>${item}</span>"/>
								${fn:replace(employeeVO.name, item, search)}							
							</td>
							<c:if test="${employeeVO.dpart == '의사'}">
								<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">의무과</td>
								<c:if test="${employeeVO.admin == '과장'}">
									<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">과장</td>
								</c:if>
								<c:if test="${employeeVO.admin != '과장'}">
									<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">의사${employeeVO.doctorT}팀</td>
								</c:if>
							</c:if>
							<c:if test="${employeeVO.dpart == '간호사'}">
								<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">간호과</td>
								<c:if test="${employeeVO.admin == '과장'}">
									<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">과장</td>
								</c:if>
								<c:if test="${employeeVO.admin != '과장'}">
									<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">간호${employeeVO.nurseT}팀</td>
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
						</tr>						 	
					</table>
					</button>
				</c:if>
				</c:forEach>
				
			</c:if>
			
			<c:if test="${employeeList.employeeList.size() == 0}">
				<div style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
						검색조건에 맞는 데이터가 없습니다. 
				</div>
			</c:if>
		
		</c:if>
	
	<c:if test="${dpartList != null}"> 
		<c:set var="item" value="${dpartList.item}"/>
		<c:set var="currentPage" value="${dpartList.currentPage}"/>
		<c:set var="startPage" value="${dpartList.startPage}"/>
		<c:set var="endPage" value="${dpartList.endPage}"/>
		<c:set var="totalPage" value="${dpartList.totalPage}"/>
		
		<c:if test="${dpartList.dpartList.size() != 0}">
			<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
				<tr>
					<th style="width: 260px; text-align: center;">부서</th>
					<th style="width: 280px; text-align: center;">팀</th>
					<th style="width: 260px; text-align: center;">내선번호</th>
				</tr>						 	
			</table>		
			<c:forEach var="dpartVO" items="${dpartList.dpartList}">
				<table style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
					<tr>
						<td style="width: 260px; text-align: center;">
							<!-- 부서명에 포함된 검색어를 강조해서 표시한다. -->
							<c:set var="search" value="<span>${item}</span>"/>
							${fn:replace(dpartVO.dpartName, item, search)}	
						</td>
						
						<td style="width: 280px; text-align: center;">${dpartVO.dpartTeam}</td>
						<td style="width: 260px; text-align: center;">${dpartVO.dnumber}</td>
					</tr>						 	
				</table>
			</c:forEach>
		</c:if>
		
		<c:if test="${dpartList.dpartList.size() == 0}">
			<div style=" border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
					검색조건에 맞는 데이터가 없습니다. 
			</div>
		</c:if>
		
	</c:if>
			
	</div>	
	
	<c:if test="${currentPage != null }">
	<div style="position: relative; left: 330px; margin-top: 50px; margin-bottom: 20px">
		<table>
			<!-- 페이지 이동 버튼 -->
			<tr>
				<td align="center">
					<!-- 처음으로 -->
					<c:if test="${currentPage > 1}">
						<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
								onclick="location.href='?currentPage=1&item=${item}&set=${set}'">처음</button>
					</c:if>
					
					<c:if test="${currentPage <= 1}">
						<button class="button button2" type="button" title="이미 첫 페이지 입니다." 
								disabled="disabled">처음</button>
					</c:if>
					
					<!-- 5페이지 앞으로 -->
					<c:if test="${startPage > 1}">
						<button class="button button1" type="button" title="이전 10 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${startPage - 1}&item=${item}&set=${set}'">
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
							<button class="button button1" type="button" onclick="location.href='?currentPage=${i}&item=${item}&set=${set}'">
								${i}
							</button>
						</c:if>
					
					</c:forEach>
	
					<!-- 5페이지 뒤로 -->
					<c:if test="${endPage < totalPage}">
						<button class="button button1" type="button" title="다음 10 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${endPage + 1}&item=${item}&set=${set}'">다음</button>
					</c:if>
					<c:if test="${endPage >= totalPage}">
						<button class="button button2" type="button" title="이미 마지막 10 페이지 입니다." 
								disabled="disabled">다음</button>
					</c:if>
					<!-- 마지막으로 -->
					<c:if test="${currentPage < totalPage}">
						<button class="button button1" type="button" title="마지막 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${totalPage}&item=${item}&set=${set}'">마지막</button>
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
		</c:if>
</div>

<!-- 모달이벤트 발생 시 모달창 -->
<div class="modal fade" id="comment-edit-modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">사원 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				</button>
			</div>
			
			<div class="modal-body">
					<div class="mb-3">
						<img id="edit-comment-img" border="1px" width="120px" alt="프로필사진" src=''>
					</div>
					<div class="mb-3">
						<label class="form-label">사번</label>
						<input id="edit-comment-eidx" class="form-control form-control-sm" type="text"/>    
					</div>
					<div class="mb-3">
						<label class="form-label">성명</label>
						<input id="edit-comment-name" class="form-control form-control-sm" type="text"/>    
					</div>
					<div class="mb-3">
						<label class="form-label">부서</label>
						<input id="edit-comment-dpart" class="form-control form-control-sm" type="text"/>    
					</div>
					<div class="mb-3">
						<label class="form-label">팀</label>
						<input id="edit-comment-team" class="form-control form-control-sm" type="text"/>    
					</div>
					<div class="mb-3">
						<label class="form-label">내선번호</label>
						<input id="edit-comment-dnum" class="form-control form-control-sm" type="text"/>    
					</div>
					<div class="mb-3">
						<label class="form-label">개인연락처</label>
						<input id="edit-comment-enum" class="form-control form-control-sm" type="text"/>    
					</div>
			</div>
			
		</div>
	</div>
</div>
<!-- footer삽입 -->
<jsp:include page="./header/footer.jsp"></jsp:include>

<script type="text/javascript">

onload = () => {
	let item = document.querySelector('#item');
	item.value = '';
	item.focus();
	
}

<!-- 사원정보 모달 이벤트 처리 -->
{
//	모달 요소 선택
	const commentEditModal = document.querySelector('#comment-edit-modal');
//	모달 이벤트 감지
	commentEditModal.addEventListener('show.bs.modal', function (event) {
		const triggerBtn = event.relatedTarget;
		const img = triggerBtn.getAttribute('data-bs-img');
		const eidx = triggerBtn.getAttribute('data-bs-eidx');
		const name = triggerBtn.getAttribute('data-bs-name');
		const dnum = triggerBtn.getAttribute('data-bs-dnum');
		const enumber = triggerBtn.getAttribute('data-bs-enum');
		let eDpart = document.querySelector('#eDpart' + eidx).innerText;
		let eTeam = document.querySelector('#eTeam' + eidx).innerText;
		
		document.querySelector('#edit-comment-img').src = '<spring:url value="/profile/' + img + '"/>';
		document.querySelector('#edit-comment-eidx').value = eidx;
		document.querySelector('#edit-comment-name').value = name;
		document.querySelector('#edit-comment-dpart').value = eDpart;
		document.querySelector('#edit-comment-team').value = eTeam;
		document.querySelector('#edit-comment-dnum').value = dnum;
		document.querySelector('#edit-comment-enum').value = enumber;
	});
}


function checkOnly(obj) {
	
	if (obj == 1) {
		item.value = '';
		item.focus();
		
	} else if (obj == 2) {
		
		item.value = '';
		item.focus();
		
	} else if (obj == 3) {
		let item = document.querySelector('#item');
		
		if (item.type == 'text') {
			item.type = 'date';
		} else {
			item.type = 'text';
			item.value = '';
			item.focus();
		}
		
	}
}

</script>
				
</body>
</html>