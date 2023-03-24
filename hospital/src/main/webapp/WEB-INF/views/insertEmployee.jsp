<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 회원가입</title>
<meta name="viewpport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="./images/logo.png"/>
<link rel="stylesheet" href="./css/bootstrap.css"/>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="./js/bootstrap.js"></script>
<script type="text/javascript" src="./js/insertemployee.js"></script>

<style type="text/css">



</style>



</head>
<body>
<jsp:include page="header/header_login.jsp"></jsp:include>

	<div style="margin-top: 20px;">
 		<form action="./insertEmployeeOK" method="post">
		<!-- <form> -->
			<table width="800px" align="center" border="1" cellpadding="5" cellspacing="0" style="font-size: 12px;">
				<tr> <th>&nbsp;</th></tr>
				<tr>
					<th colspan="3" style="text-align: center;"><h3>회원 가입</h3></th>
				</tr>
				<tr> <th>&nbsp;</th></tr>
				<tr>
					<th style="text-align: center;">사원번호</th>
					<td colspan="2">
						<input id="employeeIdx" class="form-control" type="text" name="employeeIdx" placeholder="사원번호를 입력하세요" autocomplete="off"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">비밀번호</th>
					<td colspan="2">
						<input id="password1" class="form-control" type="password" name="password1" 
								placeholder="비밀번호를 입력하세요" onkeyup="passwordCheckFunction()"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">비밀번호 확인</th>
					<td colspan="2">
						<input id="password2" class="form-control" type="password" name="password2" 
								placeholder="비밀번호를 한 번 더 입력하세요" onkeyup="passwordCheckFunction()"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">이름</th>
					<td colspan="2">
						<input id="name" class="form-control" type="text" name="name" 
								placeholder="이름을 입력하세요" autocomplete="off"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">나이</th>
					<td colspan="2">
						<input id="age" class="form-control" type="text" name="age" 
								placeholder="나이를 입력하세요" autocomplete="off"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">성별</th>
					<td colspan="2">
						<div class="form-group" style="margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-success active">
									<input type="radio" name="gender" value="M" checked="checked"> &nbsp; 남자
								</label>
								<label class="btn btn-success">
									<input type="radio" name="gender" value="F"> &nbsp; 여자
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">부서파트</th>
					<td colspan="2">
						<div class="form-group" style="margin: 0 auto;">
							<div class="btn-group">
								<label class="btn btn-success active">
									<input type="radio" name="dpart" value="원무과" checked="checked"> &nbsp; 원무과
								</label>
								<label class="btn btn-success">
									<input type="radio" name="dpart" value="의사"> &nbsp; 의사
								</label>
								<label class="btn btn-success">
									<input type="radio" name="dpart" value="간호사"> &nbsp; 간호사
								</label>
								<label class="btn btn-success">
									<input type="radio" name="dpart" value="병리사"> &nbsp; 병리사
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr class="doctorT">
					<th class="danger" style="text-align: center;">의사팀</th>
					<td colspan="2">
						<div class="form-group" style="margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-success active">
									<input type="radio" name="team" value="A"> &nbsp; A
								</label>
								<label class="btn btn-success">
									<input type="radio" name="team" value="B"> &nbsp; B
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr class="nurseT">
					<th class="danger" style="text-align: center;">간호사팀</th>
					<td colspan="2">
						<div class="form-group" style="margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-success active">
									<input type="radio" name="team" value="A"> &nbsp; A
								</label>
								<label class="btn btn-success">
									<input type="radio" name="team" value="B"> &nbsp; B
								</label>
								<label class="btn btn-success">
									<input type="radio" name="team" value="C"> &nbsp; C
								</label>
							</div>
						</div>
					</td>
				</tr>
				 
				<tr>
					<th class="danger" style="text-align: center;">내선연락처</th>
					<td colspan="2">
						<input id="dnumber" class="form-control" type="text" name="dnumber" 
								placeholder="내선연락처를 입력하세요" autocomplete="off"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<th class="danger" style="text-align: center;">개인연락처</th>
					<td colspan="2">
						<input id="enumber" class="form-control" type="text" name="enumber" 
								placeholder="개인연락처를 입력하세요" autocomplete="off"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr> <th>&nbsp;</th></tr>
				
				<tr>
					<td colspan="3" style="text-align: center;">
						<!-- 비밀번호 일치 검사 결과 메시지가 출력될 영역 -->
						<h5 id="passwordCheckMessage" style="color: tomato; font-weight: bold;"></h5>
						
	 					<input class="btn btn-primary" type="submit" value="회원가입"> &nbsp;
						<input class="btn btn-primary" type="reset" value="다시쓰기">
					</td>
				</tr>
				<tr> <td>&nbsp;</td></tr>
			</table>
		</form>
	</div>

<script type="text/javascript">
onload = () => {
	let employeeIdx = document.querySelector('#employeeIdx');
	employeeIdx.focus();
	
}


</script>
	
	
</body>
</html>


