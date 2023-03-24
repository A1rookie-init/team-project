<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<!-- 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript" src="./js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="./js/bootstrap.js"></script>
 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

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
	font-size: 15px;
}
</style>

</head>
<body>


<header class="nav-header">
	<nav class="navbar navbar-expand-lg">
		<div class="container-fluid navcon">
				&nbsp;&nbsp; 
				<div class="navbar-header">
					<a class="navbar-brand" href="viewHome">
						<img src="./images/messenger.png" alt="홈으로 가기" width="50px" align="left">
						<img src="./images/title.png" alt="홈으로 가기" width="180px" align="left">
					</a>
				</div>
				 <div class="collapse navbar-collapse justify-content-end" >
			        <ul class="navbar-nav">
			        <li class="nav-item">
			           	<a href="viewMyPage">
							<img width="50px" alt="my페이지" src="./images/user1.png" style="position: absolute; margin-left:-80px;"/> 
						</a>
<!--        					<a class="navbar-brand" href=viewMainAdmin> -->
<!--        						<img width="30px" alt="설정" src="./images/setting.png"/> -->
<!--        					</a> -->
			        </li>
			        <li class="nav-item">
						<a href="logout">
							<img width="50px" alt="로그아웃" src="./images/logout.png" align="right">
						</a>
			        </li>
			        </ul>
			    </div>
	 	</div>
	</nav>
</header>

<script type="text/javascript">

// 전역변수
var root = null;      // 컨텍스트 경로 위해 

// 컨텍스트경로 얻는 함수
function getContextPath() {
	let hostIndex = location.href.indexOf(location.host) + location.host.length
	let contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1))
	return contextPath
}



</script>



</body>
</html>