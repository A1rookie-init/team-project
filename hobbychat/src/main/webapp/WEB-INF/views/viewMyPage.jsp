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
<title>MyPage</title>
<link rel="icon" href="./images/messenger.png"/>
</head>
<body>

<br/>
<!-- header 페이지 삽입  -->
<jsp:include page="./header/header.jsp"></jsp:include>
<br/>
	
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link" href="viewHome">Home</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="viewSearchRoom">방 검색</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="viewNewRoom">방 생성</a>
  </li>
</ul>		
	
<!-- 나의 정보 수정 -->	
		<div style="margin-top: 40px; margin-bottom: 100px;">
	
		<form action="updateUser" method="post" enctype="multipart/form-data">
			<table width="800px" align="center" border="0" cellpadding="5" cellspacing="0" style="font-size: 12px;">
				<tr> <th>&nbsp;</th></tr>
				<tr>
					<th colspan="3" style="text-align: center;"><h3>My 정보</h3></th>
				</tr>
				<tr> <th>&nbsp;</th></tr>
				
				<tr>
					<td align="center">
						<div style="margin-left: 50px;"><img class="rounded" style="border-color: #dee2e6;" border="1px" width="200px" alt="프로필사진" src='<spring:url value="/profile/${userVO.profileImg}"></spring:url>'></div>
					</td>
					
					<td>
						<table class="table table-border">
							<tr class="table-light">
								<th colspan="2">프로필 사진 업로드</th>
							</tr>
			
								<tr>
									<th>
									<input type="file" id="parameterFile" name="parameterFile" class="form-control"/>
									<input type="hidden" id="profileImg" name="profileImg" value="${userVO.profileImg}"/>
									</th>
								</tr>
						</table>
					</td>
				</tr>

				<tr>
					<th class="danger" style="text-align: center;">닉네임</th>
					<td colspan="2">
						<input id="name" class="form-control" type="text" name="nickName" value="${userVO.nickName}"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				
				<tr>
					<th class="danger" style="text-align: center;">변경 비밀번호</th>
					<td colspan="2">
					
						<input id="orginalPW" type="hidden" value="${userVO.password}"/>
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
					<!-- 비밀번호 일치 검사 결과 메시지가 출력될 영역 -->
					<th class="danger" style="text-align: center;"></th>
					<td colspan="2">
						<span id="passwordCheckMessage" style="color: red; font-weight: bold;"></span>
					</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">관심 태그</th>
					<td colspan="2">
						<input id="enumber" class="form-control" type="text" name="myTag" value="${userVO.myTag}"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">소개</th>
					<td colspan="2">
						<div class="form-floating">
							<c:set var="myComment" value="${fn:replace(userVO.myComment, '>', '&gt;')}" />
							<c:set var="myComment" value="${fn:replace(myComment, '<', '&lt;')}" />
							<c:set var="myComment" value="${fn:replace(myComment, enter, '<br/>')}" />
						 	<textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea" name="myComment" rows="3">${myComment}</textarea>
						  	<label for="floatingTextarea">소개할 내용을 입력하세요.</label>
						</div>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr> <th>&nbsp;</th></tr>
				
				
				<tr>
					<td colspan="3" style="text-align: right;">
						<!-- 비밀번호 일치 검사 결과 메시지가 출력될 영역 -->
<!-- 						<h5 id="passwordCheckMessage" style="color: red; font-weight: bold;"></h5> -->
	 					<input class="btn btn-primary" type="submit" value="수정하기" id="updateBtn"> &nbsp;
					</td>
				</tr>
				<tr> <td>&nbsp;</td></tr>
			</table>
			<input type="hidden" name="userId" value="${userId}">
		</form>
	</div>
	
	
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

	updateBtn.addEventListener('click', event => {
		if (password.value == null || password.value.trim() == '') {
			password.value = orginalPW.value 
			
		}
		
	});
	

	
}



</script>
	

</body>
</html>