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

}

.navcon {
	width: 100%;
}

.navbar {
	width: 100%;
}


</style>

</head>
<body>

<!-- 
	< 페이지 설명 >  
	사원회원가입페이지에 삽입되는 헤더 페이지. 로그인페이지로 돌아간다 

 -->

<header class="nav-header">
	<nav class="navbar navbar-expand-lg">
		<div class="container-fluid navcon">
			<div class="navbar-header">
				<button style="border-color: white; background-color: white;" onclick="location.href='login'">
					<img width="55px" alt="로그인페이지" src="./images/login.png" /> 
				</button>
			</div>
		</div> 
	</nav> 
</header>





</body>
</html>