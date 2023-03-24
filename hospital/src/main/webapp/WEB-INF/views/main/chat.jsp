<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="./js/chat.js"></script>
<script type="text/javascript" src="./js/jquery-3.6.1.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script> 
<link rel="stylesheet" href="./css/css.css"/>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

<style type="text/css">

.container {
	width: 500px;
}

#list {
	height: 300px;
	padding: 15px;
	overflow: auto;
}
.bubble
{
display: inline-block;
position: relative;
width: 180px;  
padding: 3px;
background: #92C9FF; 
-webkit-border-radius: 32px;
-moz-border-radius: 32px;
border-radius: 32px;
border: #92C9FF solid 2px;
}

.bubble:after
{
content: '';
position: absolute;
border-style: solid;
border-width: 11px 28px 11px 0;
border-color: transparent #92C9FF;
display: inline-block;
width: 0;
z-index: 1;
left: -28px;
top: 34px;
}

.bubble:before
{
content: '';
position: absolute;
border-style: solid;
border-width: 12px 29px 12px 0;
border-color: transparent #92C9FF;
display: inline-block;
width: 0;
z-index: 0;
left: -31px;
top: 33px;
}

.bubble2
{
display: inline-block;
position: relative;
width: 180px;
padding: 3px;
background: #92C9FF;
-webkit-border-radius: 32px;
-moz-border-radius: 32px;
border-radius: 32px;
border: #92C9FF solid 2px;
}

.bubble2:after
{
content: '';
position: absolute;
border-style: solid;
border-width: 11px 0 11px 28px;
border-color: transparent #92C9FF;
display: inline-block;
width: 0;
z-index: 1;
right: -28px;
top: 34px;
}

.bubble2:before
{
content: '';
position: absolute;
border-style: solid;
border-width: 12px 0 12px 29px;
border-color: transparent #92C9FF;
display: inline-block;
width: 0;
z-index: 0;
right: -31px;
top: 33px;
}
.marq {
	font-size: 30px;
}

</style>

</head>
<body>

<!-- header -->
<jsp:include page="../header/header.jsp"></jsp:include>

<br/><br/>

<marquee class="marq">채팅방에 오신것을 환영합니다! :) </marquee>

<div class="container">
	<h1 class="page-header">Chat</h1>		
	
	<table class="table table-bordered">
		<tr>
			<td>
				<input type="text" name="user" id="user" class="form-control" value="${employeeIdx} - ${employeeName}">
			</td>
			<td>
				<button type="button" class="btn btn-default" id="btnConnect" >연결</button>
				<button type="button" class="btn btn-default" id="btnDisconnect" disabled>종료</button>
			</td>
		</tr>
		<tr>
			<td colspan="2"><div id="list"></div></td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="msg" id="msg" placeholder="대화 내용을 입력하세요." class="form-control" disabled></td>
		</tr>
	</table>
	
</div>
</body>
</html>
