<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기록 조회</title>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<!-- header 페이지 삽입  -->
<jsp:include page="../header/header_goback_PDetail.jsp"></jsp:include>
<jsp:include page="../quickmenu.jsp"></jsp:include> 

<div style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px; padding: 30px;">

	<div style="width: 800px; border: solid 1px; padding: 10px; margin-left:auto; margin-right:auto; position: relative;">
			금일 입원한 환자로 이전 기록 데이터가 없습니다.
	</div>
							
</div>


<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>
</body>
</html>