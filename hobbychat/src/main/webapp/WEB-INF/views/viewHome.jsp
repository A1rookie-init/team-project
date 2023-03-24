<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<link rel="icon" href="./images/messenger.png"/>


<style type="text/css">


</style>

</head>
<body>

	<br/>
<!-- header 페이지 삽입  -->
	<jsp:include page="./header/header.jsp"></jsp:include>
	<br/>
	
<!-- navigation -->		
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link active" aria-current="page" href="viewHome">Home</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="viewSearchRoom">방 검색</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="viewNewRoom">방 생성</a>
	  </li>
	</ul>		
	
<!-- 좌측: 나의 정보 -->	
	<div style="margin-top: 40px; margin-bottom: 100px; margin-left: 50px; float: left;">
			<div class="mb-3">
				<img class="rounded" border="1px" style="border-color: #dee2e6;" width="200px" alt="프로필사진" src='<spring:url value="/profile/${userVO.profileImg}"></spring:url>'>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">닉네임</label>
				<input type="text" class="form-control" id="exampleFormControlInput1" value="${userVO.nickName}" readonly="readonly">
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput2" class="form-label">관심태그</label>
				<textarea class="form-control" id="exampleFormControlInput2" rows="2" readonly="readonly">${userVO.myTag}</textarea>
			</div>
			<div class="mb-3">
				<c:set var="myComment" value="${fn:replace(userVO.myComment, '>', '&gt;')}" />
				<c:set var="myComment" value="${fn:replace(myComment, '<', '&lt;')}" />
				<c:set var="myComment" value="${fn:replace(myComment, enter, '<br/>')}" />

				<label for="exampleFormControlTextarea3" class="form-label">소개</label>
				<textarea class="form-control" id="exampleFormControlTextarea3" rows="3" readonly="readonly">${myComment}</textarea>
			</div>
	</div>
	
	
	<div style="margin-top: 40px; margin-bottom: 100px; margin-left: 150px; float: left; width: 380px; overflow: auto; height: 600px;">
		참여 중인 대화방
		<div class="d-grid gap-2" style="width: 300px; margin-top: 10px;">
			<c:if test="${myRoomList.size() != 0}">
				<c:forEach var="myRoomVO" items="${myRoomList}">
<!-- 	unRead 추가하기				 -->
					<button type="button" class="btn btn-outline-secondary position-relative" onclick="location.href='viewRoom?roomId=${myRoomVO.roomId}&newMsg=${myRoomVO.newMsg}'">
						<div class="row g-0">
							<div class="col-md-1">
								<img class="rounded" border="1px" style="border-color: #dee2e6;" width="40px" alt="커버" src='<spring:url value="/cover/${myRoomVO.coverImg}"></spring:url>'>
							</div>
							<div class="col-md-6">
								&nbsp; ${myRoomVO.roomName}
							</div>
					  </div>
						  	<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
						   		${myRoomVO.newMsg}
						    	<span class="visually-hidden">unread messages</span>
						  	</span>
					</button>
				</c:forEach>
			</c:if>
			<c:if test="${myRoomList.size() == 0}">
				<div class="d-grid gap-2" style="border: solid 1px black; width: 300px;">
					대화방이 존재하지 않습니다.
				</div>
			</c:if>
			
		</div>
	
	</div>
	
	
	
	
	
	
	
<!-- footer삽입 -->
<script type="text/javascript">


//자동새로고침 함수!

// onload = () => {
	
// 	setInterval(() => {
// 		location.href='viewHome';
		
// 	}, 5 * 1000)
	
// }



</script>
	

</body>
</html>