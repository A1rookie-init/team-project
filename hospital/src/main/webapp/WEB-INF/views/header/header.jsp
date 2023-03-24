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
	font-size: 15px;
}
</style>

</head>
<body>

<!--  
	< 페이지 설명 >  
	모든 페이지 최상단에 삽입되는 헤더 페이지.
	로그인 정보(세션변수)와 로그아웃 버튼을 포함한다. 
	세션변수 : employeeIdx, employeeName, dpart, doctorT, nurseT

-->

<header class="nav-header">
	<nav class="navbar navbar-expand-lg">
		<div class="container-fluid navcon">
			<c:if test="${dpart == '의사'}">
				&nbsp;&nbsp; 
				<div class="navbar-header">
					<a class="navbar-brand" href="viewMainDoctor">
						<img src="./images/logo.png" alt="메인으로 가기" width="50px" align="left">
					</a>
				</div>
				 <div class="collapse navbar-collapse justify-content-end" >
			        <ul class="navbar-nav">
			        <li class="nav-item">
			           	<a href="viewMyInfo">
							<img width="60px" alt="의사" src="./images/doctor.png" style="position: absolute; margin-left:-80px;"/> 
						</a>
			        </li>
			        <li class="nav-item">
				        <span class="dpartspan">
				           	${dpart} ${doctorT}팀 ${employeeName}&nbsp;&nbsp;&nbsp;
			           	</span>
			        </li>
			         <c:if test="${admin != '팀원'}">
				        <li class="nav-item">
        					<a class="navbar-brand" href=viewMainAdmin>
        						<img width="30px" alt="관리자모드" src="./images/admin.png"/>
        					</a>
				        </li>
   					</c:if>
			        <li class="nav-item">
			           <button style="border-color: white; background-color: white; "  onclick="location.href='logout'">
							<img width="50px" alt="로그아웃" src="./images/logout.png" align="right">
						</button>
			        </li>
			        </ul>
			    </div>
			</c:if>
			<c:if test="${dpart == '간호사'}">
				&nbsp;&nbsp; 
				<a class="navbar-brand" href="viewMainN" style="align-items: flex-start;">
		 			<img src="./images/logo.png" alt="메인으로 가기" width="50px"">
				</a>
				<div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
			        <ul class="navbar-nav">
				        <li class="nav-item">
				           	<a href="viewMyInfo">
								<img width="60px" alt="간호사" src="./images/nurse.png" style="position: absolute; margin-left:-80px;"/> 
							</a>
				        </li>
				        <li class="nav-item">
					        <span class="dpartspan">
					           	 ${dpart} ${nurseT}팀 ${employeeName}&nbsp;&nbsp;&nbsp;
				           	</span>
				        </li>
				         <c:if test="${admin != '팀원'}">
					        <li class="nav-item">
	        					<a class="navbar-brand" href=viewMainAdmin>
	        						<img width="30px" alt="관리자모드" src="./images/admin.png"/>
	        					</a>
					        </li>
	   					</c:if>
				        <li class="nav-item">
				           <button style="border-color: white; background-color: white; "  onclick="location.href='logout'">
								<img width="50px" alt="로그아웃" src="./images/logout.png" align="right">
							</button>
				        </li>
			        </ul>
			    </div>
			</c:if>
			<c:if test="${dpart == '병리사'}">
				&nbsp;&nbsp; 
				<a class="navbar-brand" href="viewMainP" style="align-items: flex-start;">
					<img src="./images/logo.png" alt="메인으로 가기" width="50px"">
				</a>
				 <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
			        <ul class="navbar-nav">
				        <li class="nav-item">
				           	<a href="viewMyInfo">
								<img width="60px" alt="병리사" src="./images/pathologist.png" style="position: absolute; margin-left:-80px;"/> 
							</a> 
				        </li>
				        <li class="nav-item">
					        <span class="dpartspan">
					           	 ${dpart} ${employeeName}&nbsp;&nbsp;&nbsp;
				           	</span>
				        </li>
				         <c:if test="${admin != '팀원'}">
					        <li class="nav-item">
	        					<a class="navbar-brand" href=viewMainAdmin>
	        						<img width="30px" alt="관리자모드" src="./images/admin.png"/>
	        					</a>
					        </li>
	   					</c:if>
				        <li class="nav-item">
				           <button style="border-color: white; background-color: white; "  onclick="location.href='logout'">
								<img width="50px" alt="로그아웃" src="./images/logout.png" align="right">
							</button>
				        </li>
			        </ul>
			    </div>
			</c:if>
			<c:if test="${dpart == '원무과'}">
				&nbsp;&nbsp; 
				<a class="navbar-brand" href="viewMainA" style="align-items: flex-start;">
		 			<img src="./images/logo.png" alt="메인으로 가기" width="50px">
				</a>
				 <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
			        <ul class="navbar-nav">
				        <li class="nav-item">
				           	<a href="viewMyInfo">
								<img width="60px" alt="원무과" src="./images/accountant.png" style="position: absolute; margin-left:-80px;"/> 
							</a>
				        </li>
				        <li class="nav-item">
					        <span class="dpartspan">
					           	 ${dpart} ${employeeName}&nbsp;&nbsp;&nbsp;
				           	</span>
				        </li>
				         <c:if test="${admin != '팀원'}">
					        <li class="nav-item">
	        					<a class="navbar-brand" href=viewMainAdmin>
	        						<img width="30px" alt="관리자모드" src="./images/admin.png"/>
	        					</a>
					        </li>
	   					</c:if>
				        <li class="nav-item">
				           <button style="border-color: white; background-color: white; "  onclick="location.href='logout'">
								<img width="50px" alt="로그아웃" src="./images/logout.png" align="right">
							</button>
				        </li>
			        </ul>
			    </div>
			</c:if>
	 	</div>
	</nav>
</header>





</body>
</html>