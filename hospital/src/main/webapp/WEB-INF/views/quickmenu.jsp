<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
	div, ul, li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}
	a {text-decoration:none;}
	
	.quickmenu {position:absolute;width:150px;top:30%;margin-top:-50px;right:10px;background:#fff;}
	.quickmenu ul {position:relative;float:left;width:100%;display:inline-block;margin:0;padding:0;*display:inline;border:1px solid #ddd;}
	.quickmenu ul li {float:left;width:100%;border-bottom:1px solid #ddd;text-align:center;display:inline-block;*display:inline;}
	.quickmenu ul li a {position:relative;float:left;width:100%;height:50px;line-height:50px;text-align:center;color:#999;font-size:12pt;}
	.quickmenu ul li a:hover {color:#000;}
	.quickmenu ul li:last-child {border-bottom:0;}
	
</style>

</head>

<body>

	<div class="quickmenu">
		<c:if test="${dpart == '의사'}">
			<ul>
			    <li><a href="./viewMainDoctor">메인페이지</a></li>
			    <li><a href="./viewSearchEmployee">사내검색</a></li>
			    <li><a href="./viewDisPatient">퇴원환자조회</a></li>
		  	</ul>
		</c:if>
		
		<c:if test="${dpart == '간호사'}">
			<ul>
			    <li><a href="./viewMainN">메인페이지</a></li>
			    <li><a href="./viewSearchEmployee">사내검색</a></li>
			    <li><a href="./viewDisPatient">퇴원환자조회</a></li>
		  	</ul>
		</c:if>
		
		<c:if test="${dpart == '병리사'}">
			<ul>
			    <li><a href="./viewMainP">메인페이지</a></li>
			    <li><a href="./viewSearchEmployee">사내검색</a></li>
			    <li><a href="./viewDisPatient">퇴원환자조회</a></li>
		  	</ul>
		</c:if>
		
		<c:if test="${dpart == '원무과'}">
			<ul>
			    <li><a href="./viewMainA">메인페이지</a></li>
			    <li><a href="./insertPatient">환자등록</a></li>
			    <li><a href="./viewSearchEmployee">사내검색</a></li>
			    <li><a href="./viewDisPatient">퇴원환자조회</a></li>
		  	</ul>
		</c:if>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
		  $(window).scroll(function() {
		    var position = $(window).scrollTop()+200; 
		    $(".quickmenu").stop().animate({"top":position+"px"},500);
		  });
		});
	</script>

</body>
</html>