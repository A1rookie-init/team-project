<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript" src="./js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="./js/bootstrap.js"></script>

<style type="text/css">

.nav-header {
	height: 60px;
	display: flex; 
	width: 100%;
	padding: 5px;

}

.navcon {
	width: 100%;
}

.navbar {
	width: 100%;
}

.dpartspan {
	vertical-align: sub;
	font-weight: bold;
	font-family: Segoe Ul;
/* 	margin-top:59px;
	margin-left: -165px; */
	
	
}

</style>

</head>
<body>

<!-- 
	< 페이지 설명 >  
	로그인정보, 로그아웃버튼, 메인페이지로 돌아가기, 

	페이지 최상단에 삽입되는 헤더 페이지.
	로그인 정보(세션변수)와 로그아웃 버튼을 포함한다. 
	세션변수 : employeeIdx, employeeName, dpart, doctorT, nurseT

 -->

<div style="text-align: right; height: 60px; padding: 20px">
	<c:if test="${dpart == '의사'}">
		<a href="viewMyInfo">
			<img width="60px" alt="의사" src="./images/doctor.png" style="position: absolute; margin-left:-80px;"/> 
		</a>
		<span style="font-weight: bold; font-size: 16px; font-family: Segoe Ul; position: absolute; margin-top:59px; margin-left: -136px;">
		${dpart} ${doctorT}팀 ${employeeName}
		</span>
		 <c:if test="${admin != '팀원'}">
			<a href=viewMainAdmin>
				<img width="30px" alt="관리자모드" src="./images/admin.png"/>
			</a>
		</c:if>
	</c:if>
	
	<c:if test="${dpart == '간호사'}">     
		<a href="viewMyInfo">
			<img width="60px" alt="간호사" src="./images/nurse.png" style="position: absolute; margin-left:-80px;"/> 
		</a>
		<span style="font-weight: bold; font-family: Segoe Ul; position: absolute; margin-top:59px; margin-left: -165px;">
		${dpart} ${nurseT}팀 ${employeeName}
		</span>
		 <c:if test="${admin != '팀원'}">
			<a href=viewMainAdmin>
				<img width="30px" alt="관리자모드" src="./images/admin.png"/>
			</a>
		</c:if>
	</c:if>
	
	<c:if test="${dpart == '병리사'}">
		<a href="viewMyInfo">
			<img width="60px" alt="병리사" src="./images/pathologist.png" style="position: absolute; margin-left:-80px;"/> 
		</a>
		<span style="font-weight: bold; font-family: Segoe Ul; position: absolute; margin-top:59px; margin-left: -140px;">
		${dpart} ${employeeName}
		</span>
		 <c:if test="${admin != '팀원'}">
			<a href=viewMainAdmin>
				<img width="30px" alt="관리자모드" src="./images/admin.png"/>
			</a>
		</c:if>
	</c:if>
	
	<c:if test="${dpart == '원무과'}">
		<a href="viewMyInfo">
			<img width="60px" alt="원무과" src="./images/accountant.png" style="position: absolute; margin-left:-80px;"/> 
		</a>
		<span style="font-weight: bold; font-family: Segoe Ul; position: absolute; margin-top:59px; margin-left: -131px;">
		${dpart} ${employeeName}
		</span>
		 <c:if test="${admin != '팀원'}">
			<a href=viewMainAdmin>
				<img width="30px" alt="관리자모드" src="./images/admin.png"/>
			</a>
		</c:if>
	</c:if>
	
	<a style="border-color: white; background-color: white; "  href="logout">
		<img width="50px" alt="로그아웃" src="./images/logout.png" align="right">
	</a>
	&nbsp;&nbsp;
</div> 

<div style="text-align: left;">

	<c:if test="${dpart == '의사'}">
		&nbsp;&nbsp; 
		<button style="border-color: white; background-color: white;" 
			onclick="location.href='viewMainDoctor'">
			<img width="30px" alt="돌아가기" src="./images/previous.png">
		</button>
		메인으로 돌아가기
	
	</c:if>
	
	<c:if test="${dpart == '간호사'}">
			&nbsp;&nbsp; 
		<button style="border-color: white; background-color: white;" 
			onclick="location.href='viewMainN'">
			<img width="30px" alt="돌아가기" src="./images/previous.png">
		</button>
		메인으로 돌아가기
	
	</c:if>
	
	<c:if test="${dpart == '병리사'}">
			&nbsp;&nbsp; 
		<button style="border-color: white; background-color: white;" 
			onclick="location.href='viewMainP'">
			<img width="30px" alt="돌아가기" src="./images/previous.png">
		</button>
		메인으로 돌아가기
	
	</c:if>
	
	<c:if test="${dpart == '원무과'}">
				&nbsp;&nbsp; 
		<button style="border-color: white; background-color: white;" 
			onclick="location.href='viewMainA'">
			<img width="30px" alt="돌아가기" src="./images/previous.png">
		</button>
		메인으로 돌아가기
	</c:if>


</div>





</body>
</html>