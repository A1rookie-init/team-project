<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<meta name="viewpport" content="width=device-width, initial-scale=1">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="./css/login.css"/>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

</head>
<body>
<div class="wrapper fadeInDown">
  <div id="formContent">
    <div class="fadeIn first">
      <img src="./images/logo.png" id="icon" alt="User Icon" width="12"/>
    </div>
    
    <form action="loginOK" method="post">
      <input type="text" id="employeeIdx" class="fadeIn second" name="employeeIdx" placeholder="사번">
      <input type="password" id="password" class="fadeIn third" name="password" placeholder="비밀번호">
      <input type="submit" class="fadeIn fourth" value="로그인"/>
    </form>

    <div id="formFooter">
      <a class="underlineHover" href="insertEmployee">회원가입</a>
    </div>
  </div>
</div>
</body>
</html>