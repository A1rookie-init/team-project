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
<title>마이페이지</title>
<link rel="icon" href="./images/logo.png"/>
</head>
<body>

<!-- header 페이지 삽입  -->
<jsp:include page="../header/header.jsp"></jsp:include>
<jsp:include page="../quickmenu.jsp"></jsp:include>
	
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="viewMyInfo">My 정보</a>
  </li>
  <c:if test="${dpart == '간호사'}">
	  <c:if test="${admin != '과장'}">
		  <c:if test="${admin != '팀장'}">
			  <li class="nav-item">
			    <a class="nav-link" href="viewMyCalendar">My 스케줄</a>
			  </li>
		  </c:if>
	  </c:if>
  </c:if>
</ul>		
	
<!-- 나의 정보 수정 -->	
		<div style="margin-top: 20px; margin-bottom: 100px;">
	
		<form action="profileUpload" method="post" enctype="multipart/form-data">
			<table width="800px" align="center" border="1" cellpadding="5" cellspacing="0" style="font-size: 12px;">
				<tr> <th>&nbsp;</th></tr>
				<tr>
					<th colspan="3" style="text-align: center;"><h3>나의 정보</h3></th>
				</tr>
				<tr> <th>&nbsp;</th></tr>
				
				<tr>
					<td align="center">
						<div style="margin-left: 50px;"><img border="1px" width="200px" alt="프로필사진" src='<spring:url value="/profile/${employeeVO.orgFileName}"></spring:url>'></div>
					</td>
					
					<td>
						<table class="table table-border">
							<tr class="table-info">
								<th colspan="2">프로필 사진 업로드</th>
							</tr>
			
								<tr>
									<th>
									<input type="file" id="profileImg" name="profileImg" />
									<input type="hidden" id="orginalImg" name="orgFileName" value="${employeeVO.orgFileName}"/>
									</th>
								</tr>
						</table>
					</td>
				</tr>
				
				<tr>
					<th style="text-align: center;">사원번호</th>
					<td colspan="2">
						<input id="employeeIdx" class="form-control" type="text" name="employeeIdx" value="${employeeVO.employeeIdx}" readonly="readonly">
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">변경 비밀번호</th>
					<td colspan="2">
					
						<input id="orginalPW" type="hidden" value="${employeeVO.password}"/>
						<input id="password1" class="form-control" type="password" name="password" placeholder="비밀번호를 입력하세요" onkeyup="passwordCheckFunction()"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">변경 비밀번호 확인</th>
					<td colspan="2">
						<input id="password2" class="form-control" type="password" name="password2" placeholder="비밀번호를 한 번 더 입력하세요" onkeyup="passwordCheckFunction()"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">이름</th>
					<td colspan="2">
						<input id="name" class="form-control" type="text" name="name" value="${employeeVO.name}"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">나이</th>
					<td colspan="2">
						<input id="age" class="form-control" type="text" name="age" value="${employeeVO.age}"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">성별</th>
					<td colspan="2">
						<div class="form-group" style="margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<c:if test="${employeeVO.gender == 'M' }">
									<label class="btn btn-success active">
										<input type="radio" name="gender" value="M" checked="checked"> &nbsp; 남자
									</label>
									<label class="btn btn-success">
										<input type="radio" name="gender" value="F"> &nbsp; 여자
									</label>
								</c:if>
								<c:if test="${employeeVO.gender == 'F'}">
									<label class="btn btn-success active">
										<input type="radio" name="gender" value="M"> &nbsp; 남자
									</label>
									<label class="btn btn-success">
										<input type="radio" name="gender" value="F" checked="checked"> &nbsp; 여자
									</label>
								</c:if>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">부서파트</th>
					<td colspan="2">
						<div class="form-group" style="margin: 0 auto;">
							<div class="btn-group">
							
								<c:if test="${employeeVO.dpart == '원무과'}">
									<label class="btn btn-success active">
										<input type="radio" name="dpart" value="원무과" checked="checked"> &nbsp; 원무과
									</label>
								</c:if>
								<c:if test="${employeeVO.dpart == '의사'}">
									<label class="btn btn-success">
										<input type="radio" name="dpart" value="의사" checked="checked"> &nbsp; 의사
									</label>
								</c:if>
								<c:if test="${employeeVO.dpart == '간호사'}">
									<label class="btn btn-success">
										<input type="radio" name="dpart" value="간호사" checked="checked"> &nbsp; 간호사
									</label>
								</c:if>
								<c:if test="${employeeVO.dpart == '병리사'}">
									<label class="btn btn-success">
										<input type="radio" name="dpart" value="병리사" checked="checked"> &nbsp; 병리사
									</label>
								</c:if>
							</div>
						</div>
					</td>
				</tr>
			<c:if test="${employeeVO.dpart == '의사'}">
				<tr class="doctorT">
					<th class="danger" style="text-align: center;">의사팀</th>
					<td colspan="2">
						<div class="form-group" style="margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<c:if test="${employeeVO.doctorT == 'A'}">
									<label class="btn btn-success active">
										<input type="radio" name="doctorT" value="A" checked="checked"> &nbsp; A
									</label>
								</c:if>
								<c:if test="${employeeVO.doctorT == 'B'}">
									<label class="btn btn-success">
										<input type="radio" name="doctorT" value="B" checked="checked"> &nbsp; B
									</label>
								</c:if>
							</div>
						</div>
					</td>
				</tr>
			</c:if>
			<c:if test="${employeeVO.dpart == '간호사'}">
				<tr class="nurseT">
					<th class="danger" style="text-align: center;">간호사팀</th>
					<td colspan="2">
						<div class="form-group" style="margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<c:if test="${employeeVO.nurseT == 'A'}">
									<label class="btn btn-success active">
										<input type="radio" name="nurseT" value="A" checked="checked"> &nbsp; A
									</label>
								</c:if>
								<c:if test="${employeeVO.nurseT == 'B'}">
									<label class="btn btn-success">
										<input type="radio" name="nurseT" value="B" checked="checked"> &nbsp; B
									</label>
								</c:if>
							</div>
						</div>
					</td>
				</tr>
			</c:if>
				 
				<tr>
					<th class="danger" style="text-align: center;">내선연락처</th>
					<td colspan="2">
						<input id="dnumber" class="form-control" type="text" name="dnumber" value="${employeeVO.dnumber}"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">개인연락처</th>
					<td colspan="2">
						<input id="enumber" class="form-control" type="text" name="enumber" value="${employeeVO.enumber}"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr> <th>&nbsp;</th></tr>
				
				<tr>
					<td colspan="3" style="text-align: right;">
						<!-- 비밀번호 일치 검사 결과 메시지가 출력될 영역 -->
						<h5 id="passwordCheckMessage" style="color: tomato; font-weight: bold;"></h5>
	 					<input class="btn btn-primary" type="submit" value="수정하기" id="updateBtn"> &nbsp;
					</td>
				</tr>
				<tr> <td>&nbsp;</td></tr>
			</table>
		</form>
	</div>
<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>
<script type="text/javascript">

//비밀 번호가 일치하는지 확인하는 함수
function passwordCheckFunction() {
	let password1 = $('#password1').val();
	let password2 = $('#password2').val();
	console.log('password1: ' + password1 + ', password2: ' + password2);
	
	if (password1 != password2) {
		$('#passwordCheckMessage').html('비밀번호가 일치하지 않습니다.');
	} else {
		$('#passwordCheckMessage').html('');	
	}
}

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