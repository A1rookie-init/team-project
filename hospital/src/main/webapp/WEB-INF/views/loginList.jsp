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
	.loginList div, .loginList ul, .loginList li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}
	.loginList a {text-decoration:none;}
	
	.loginList {position:absolute; width:150px; top:30%; margin-top:-50px; left:18px; background:#fff; font-size:12pt;}
	.loginList ul {position:relative;float:left;width:100%;display:inline-block;margin:0;padding:0;*display:inline;border:1px solid #ddd;}
	.loginList ul li {float:left; width:100%; text-align:left; display:inline-block; display:inline;}
	.loginList ul li a {position:relative;float:left;width:100%;height:30px;line-height:30px;text-align:left;color:#999;font-size:10pt;}
	.loginList ul li a:hover {color:#000;}
	.loginList ul li:last-child {border-bottom:0;}
	
</style>

</head>

<body>

	<div class="loginList">
		접속 중
		<ul id="loginUser">

	  	</ul>
		
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
		  $(window).scroll(function() {
		    var position = $(window).scrollTop()+200; 
		    $(".loginList").stop().animate({"top":position+"px"},500);
		  });
		});
	</script>

</body>
</html>