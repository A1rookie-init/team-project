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
<title>관리자</title>
<link rel="icon" href="./images/logo.png" />
</head>
<body>

	<!-- header 페이지 삽입  -->
	<jsp:include page="../header/header.jsp"></jsp:include>
	<jsp:include page="../quickmenu.jsp"></jsp:include>



	<div style="margin-top: 20px; margin-bottom: 100px;">

		<table width="800px" align="center" border="1" cellpadding="5"
			cellspacing="0" style="font-size: 12px;">
			<tr>
				<th style="width: 90px; text-align: center;">${employeeList.employeeList.totalCount}</th>
			</tr>

			<tr>
				<th style="text-align: center;">사원번호</th>
				<td colspan="2"><input id="employeeIdx" class="form-control" type="text" name="employeeIdx" value="${employeeVO.employeeIdx}" readonly="readonly"></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<th class="danger" style="text-align: center;">이름</th>
				<td colspan="2"><input id="name" class="form-control" type="text" name="name" value="${employeeVO.name}" readonly="readonly" /></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<th class="danger" style="text-align: center;">직급</th>
				<td colspan="2">
						<input id="admin" class="form-control"	type="text" name="admin" value="${employeeVO.admin}" readonly="readonly" />
				</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<th class="danger" style="text-align: center;">나이</th>
				<td colspan="2"><input id="age" class="form-control" type="text" name="age" value="${employeeVO.age}" readonly="readonly" /></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<th class="danger" style="text-align: center;">성별</th>
				<td colspan="2">
					<c:if test="${employeeVO.gender == 'M'}">
						<input id="gender" class="form-control" type="text" name="gender" value="남" readonly="readonly" />
					</c:if>
					<c:if test="${employeeVO.gender == 'F'}">
						<input id="gender" class="form-control" type="text" name="gender" value="여" readonly="readonly" />
					</c:if>
			</tr>
			<tr>
				<th class="danger" style="text-align: center;">입사일</th>
				
				<td colspan="2"><input id="age" class="form-control"  type="text" name="hiredate" value="${employeeVO.hiredate}" readonly="readonly" /></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<th class="danger" style="text-align: center;">부서파트</th>
				<td colspan="2"><c:if test="${employeeVO.dpart == '원무과'}">
						<input type="text" class="form-control" name="dpart" value="원무과" checked="checked" readonly="readonly"> &nbsp;
						</c:if> <c:if test="${employeeVO.dpart == '의사'}">
						<input type="text" class="form-control" name="dpart" value="의사" checked="checked" readonly="readonly"> &nbsp; 
						</c:if> <c:if test="${employeeVO.dpart == '간호사'}">
						<input type="text" class="form-control" name="dpart" value="간호사" checked="checked" readonly="readonly"> &nbsp;
						</c:if> <c:if test="${employeeVO.dpart == '병리사'}">
						<input type="text" class="form-control" name="dpart" value="병리사" checked="checked" readonly="readonly"> &nbsp;
						</c:if></td>
			</tr>
			<c:if test="${employeeVO.dpart != null}">
			<c:if test="${employeeVO.doctorT != 'D' && employeeVO.nurseT != 'D'}">
				<tr class="Team">
					<c:if test="${employeeVO.dpart == '의사'}">
						<th class="danger" style="text-align: center;">의사팀</th>
						<td colspan="2">
							<div class="form-group" style="margin: 0 auto;">
								<div class="btn-group">
									<c:if test="${employeeVO.doctorT == 'A'}">
										<input class="form-control" type="text" name="doctorT"	value="A"> &nbsp; 
									</c:if>
									<c:if test="${employeeVO.doctorT == 'B'}">
										<input class="form-control" type="text" name="doctorT" value="B"> &nbsp;
									</c:if>
	
								</div>
							</div>
						</td>
					</c:if>
					<c:if test="${employeeVO.dpart == '간호사'}">
						<tr class="nurseT">
							<th class="danger" style="text-align: center;">간호사팀</th>
								<td colspan="2">
								<div class="form-group" style="margin: 0 auto;">
									<div class="btn-group">
										<c:if test="${employeeVO.nurseT == 'A'}">
											<input class="form-control" type="text" name="nurseT" value="A"> &nbsp; 
										</c:if>
										<c:if test="${employeeVO.nurseT == 'B'}">
											<input class="form-control" type="text" name="nurseT" value="B"> &nbsp;
										</c:if>
										<c:if test="${employeeVO.nurseT == 'C'}">
											<input class="form-control" type="text" name="nurseT" value="C"> &nbsp;
										</c:if>
									</div>
								</div>
								</td>
							</tr>
						</c:if>
					</tr>
				</c:if>
			</c:if>


			<tr>
				<th class="danger" style="text-align: center;">내선연락처</th>
				<td colspan="2"><input id="dnumber" class="form-control"
					type="text" name="dnumber" value="${employeeVO.dnumber}" /></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<th class="danger" style="text-align: center;">개인연락처</th>
				<td colspan="2"><input id="enumber" class="form-control"
					type="text" name="enumber" value="${employeeVO.enumber}" /></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;</th>
			</tr>

			<tr>
				
				<td colspan="3" style="text-align: right;">
				<c:if test="${employeeVO.doctorT != null || employeeVO.nurseT != null}">
				<input type="button" class="btn btn-success" style="border-color: black;"
					data-bs-toggle="modal" data-bs-target="#comment-edit-modal"
					data-bs-img="${employeeVO.orgFileName}"
					data-bs-eidx="${employeeVO.employeeIdx}"
					data-bs-name="${employeeVO.name}"
					data-bs-dnum="${employeeVO.dnumber}"
					data-bs-enum="${employeeVO.enumber}" value="팀이동">&nbsp;
				</c:if>
														
					<input	type="button" class="btn btn-success" style="border-color: black;"
					data-bs-toggle="modal" data-bs-target="#comment-admin-modal"
					data-bs-img="${employeeVO.orgFileName}"
					data-bs-eidx="${employeeVO.employeeIdx}"
					data-bs-name="${employeeVO.name}"
					data-bs-admin="${employeeVO.admin}" value="직급"> &nbsp;
					
					<input	type="button" class="btn btn-danger" style="border-color: black;"
					data-bs-toggle="modal" data-bs-target="#comment-delete-modal"
					data-bs-img="${employeeVO.orgFileName}"
					data-bs-eidx="${employeeVO.employeeIdx}"
					data-bs-name="${employeeVO.name}"
					data-bs-doctorT="${employeeVO.doctorT}"
					data-bs-nurseT="${employeeVO.nurseT}" value="퇴사"> &nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
	</div>

	<div class="modal fade" id="comment-edit-modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">팀이동</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div class="modal-body">
					${employeeVO.name}(${employeeVO.employeeIdx})

					<div class="mb-3">
						<c:if test="${employeeVO.dpart == '원무과'}">
							<input type="text" class="form-control" name="dpart" value="원무과"
								readonly="readonly"> &nbsp;
						</c:if>
						<c:if test="${employeeVO.dpart == '의사'}">
							<input type="text" class="form-control" name="dpart" value="의사"
								readonly="readonly"> &nbsp; 
						</c:if>
						<c:if test="${employeeVO.dpart == '간호사'}">
							<input type="text" class="form-control" name="dpart" value="간호사"
								readonly="readonly"> &nbsp;
						</c:if>
						<c:if test="${employeeVO.dpart == '병리사'}">
							<input type="text" class="form-control" name="dpart" value="병리사"
								readonly="readonly"> &nbsp;
						</c:if>
					</div>
					<form action="moveTeam">
						<div class="mb-3">
							<c:if test="${employeeVO.doctorT != null}">
								<div class="form-label">팀</div>
								<c:if test="${employeeVO.doctorT == 'A'}">
									<label class="btn"> <input type="radio" name="doctorT" value="A" checked="checked">A </label> 
									<label class="btn"> <input type="radio" name="doctorT" value="B">B </label>
								</c:if>
								<c:if test="${employeeVO.doctorT == 'B'}">
									<label class="btn"> <input type="radio" name="doctorT" value="A">A </label> 
									<label class="btn"> <input type="radio" name="doctorT" value="B" checked="checked">B </label>
								</c:if>
							</c:if>
							<c:if test="${employeeVO.nurseT != null}">
								<c:if test="${employeeVO.nurseT == 'A'}">
									<label class="btn"> <input type="radio" name="nurseT"  value="A" checked="checked">A </label> 
									<label class="btn"> <input type="radio" name="nurseT" value="B">B </label> 
									<label class="btn"> <input type="radio" name="nurseT" value="C">C </label> 
								</c:if>
								<c:if test="${employeeVO.nurseT == 'B'}">
									<label class="btn"> <input type="radio" name="nurseT"  value="A">A </label> 
									<label class="btn"> <input type="radio" name="nurseT" value="B" checked="checked">B </label> 
									<label class="btn"> <input type="radio" name="nurseT" value="C">C </label> 
								</c:if>
								<c:if test="${employeeVO.nurseT == 'C'}">
									<label class="btn"> <input type="radio" name="nurseT"  value="A">A </label> 
									<label class="btn"> <input type="radio" name="nurseT" value="B">B </label> 
									<label class="btn"> <input type="radio" name="nurseT" value="C" checked="checked">C </label> 
								</c:if>
							</c:if>
						</div>
						${employeeVO.name}(${employeeVO.employeeIdx}) 팀이동이 맞습니까? 
						<input type="submit" value="이동">
						<input type="hidden" name="employeeIdx"	value="${employeeVO.employeeIdx}">
					</form>
				</div>
			</div>
		</div>

	</div>

	<div class="modal fade" id="comment-admin-modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">${employeeVO.name}(${employeeVO.employeeIdx})</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						<c:if test="${employeeVO.dpart == '원무과'}">
							<input type="text" class="form-control" name="dpart" value="원무과" readonly="readonly"> &nbsp;
						</c:if>
						<c:if test="${employeeVO.dpart == '의사'}">
							<input type="text" class="form-control" name="dpart" value="의사" readonly="readonly"> &nbsp; 
						</c:if>
						<c:if test="${employeeVO.dpart == '간호사'}">
							<input type="text" class="form-control" name="dpart" value="간호사" readonly="readonly"> &nbsp;
						</c:if>
						<c:if test="${employeeVO.dpart == '병리사'}">
							<input type="text" class="form-control" name="dpart" value="병리사" readonly="readonly"> &nbsp;
						</c:if>
					</div>
					<div class="mb-3"> 현재직급
						<input type="text" class="form-control" name="admin" value="${employeeVO.admin}">
					</div>
					<form action="updateAdmin">
						<div class="mb-3">
							<div class="form-label">변경 직급</div>
							<c:if test="${employeeVO.admin == '과장'}">
								<label class="btn"><input type="radio" name="admin" value="과장" checked="checked">과장</label>
								<label class="btn"><input type="radio" name="admin" value="팀장">팀장</label>
								<label class="btn"><input type="radio" name="admin" value="팀원">팀원</label> 
							</c:if>
							<c:if test="${employeeVO.admin == '팀장'}">
								<label class="btn"><input type="radio" name="admin" value="과장">과장</label>
								<label class="btn"><input type="radio" name="admin" value="팀장" checked="checked">팀장</label>
								<label class="btn"><input type="radio" name="admin" value="팀원">팀원</label> 
							</c:if>
							<c:if test="${employeeVO.admin == '팀원'}">
								<label class="btn"><input type="radio" name="admin" value="과장">과장</label>
								<label class="btn"><input type="radio" name="admin" value="팀장">팀장</label>
								<label class="btn"><input type="radio" name="admin" value="팀원" checked="checked">팀원</label> 
							</c:if>
						</div>
						${employeeVO.name} 에게 권한을 부여합니다. 
						<input type="submit" value="확인">
						<input type="hidden" name="employeeIdx" value="${employeeVO.employeeIdx}">
					</form>
				</div>

			</div>
		</div>

	</div>


	<div class="modal fade" id="comment-delete-modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">${employeeVO.name}  (${employeeVO.employeeIdx})</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"  aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<img border="1px" width="200px" alt="프로필사진" src='<spring:url value="/profile/${employeeVO.orgFileName}"></spring:url>'>

					<div class="mb-3">
						<c:if test="${employeeVO.dpart == '원무과'}">
							<input type="text" class="form-control" name="dpart" value="원무과" readonly="readonly"> &nbsp;
						</c:if>
						<c:if test="${employeeVO.dpart == '의사'}">
							<input type="text" class="form-control" name="dpart" value="의사" readonly="readonly"> &nbsp; 
						</c:if>
						<c:if test="${employeeVO.dpart == '간호사'}">
							<input type="text" class="form-control" name="dpart" value="간호사" readonly="readonly"> &nbsp;
						</c:if>
						<c:if test="${employeeVO.dpart == '병리사'}">
							<input type="text" class="form-control" name="dpart" value="병리사" readonly="readonly"> &nbsp;
						</c:if>
					</div>
					
					<br> ${employeeVO.name} 퇴사처리하겠습니까?
					<form action="deleteEmployee">
						<input	type="hidden" name="employeeIdx" value="${employeeVO.employeeIdx}">
						<input type="submit" value="퇴사" onclick="location.href='deleteEmployee?employeeIdx=${employeeVO.employeeIdx}'">
					</form>
				</div>

			</div>
		</div>

	</div>





	<script type="text/javascript">


onload = () => {
	
	let updateBtn = document.querySelector('#updateBtn')
	let password = document.querySelector('#password1')	
	let orginalPW = document.querySelector('#orginalPW')
	let profileImg = document.querySelector('#profileImg')
	let orginalImg = document.querySelector('#orginalImg')
	

	updateBtn.addEventListener('click', event => {
	console.log(orginalImg.value)
	console.log(profileImg.value)
		if (password.value == null || password.value.trim() == '') {
			password.value = orginalPW.value 
			
		}
		
		
	});
	

	
}



</script>


</body>
</html>