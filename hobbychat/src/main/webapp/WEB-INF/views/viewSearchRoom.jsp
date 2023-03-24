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
<title>방 검색</title>
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
	    <a class="nav-link" href="viewHome">Home</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link active" aria-current="page" href="viewSearchRoom">방 검색</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="viewNewRoom">방 생성</a>
	  </li>
	</ul>		
	
<!-- 좌측: 나의 정보 -->	
<!-- 	<div style="margin-top: 40px; margin-bottom: 80px; margin-left: 50px; float: left;"> -->

<!-- 	</div> -->
	
<!-- 중앙: 검색창과 검색된 채팅방 목록 -->	
	<div style="margin-top: 40px; margin-bottom: 100px; margin-left: 350px; float: left;" >
		<!-- 검색창  -->
		<div>
			<form role="search" action="roomSearch">
				<table>
					<tr>
						<td style="width: 100px">
							<label for="rName" class="form-check-label">방이름</label>
							<input class="form-check-input" type="radio" name="set" value="rName" id="rName" onclick="checkOnly(1)"/>
						</td>
						<td style="width: 100px">
							<label for="rTag" class="form-check-label">방태그</label>
							<input class="form-check-input" type="radio" name="set" value="rTag" id="rTag" onclick="checkOnly(2)"/>
						</td>
						<td>
					        <input style="width: 300px; margin: 0px;" class="form-control" type="text" placeholder="Search" name="item" id="item">
						</td>
						<td>
					        <button class="btn btn-outline-secondary" style="border-color: #dee2e6;" type="submit">
					        	<img width="20px" alt="검색" src="./images/search.png">
					        </button>
						</td>
					</tr>
				</table>
		    </form>
		    <input type="hidden" value="${userId}" id="userId">
		</div>
	
		<br><br>
		
		<!-- 검색된 대화방 목록 -->
		<div>
			대화방
			<div class="border border-light-subtle" style="height: 560px; overflow: auto;">
				<c:if test="${chatRoomList.chatRoomList.size() == 0}">
					검색조건에 맞는 대화방이 존재하지 않습니다.
				</c:if>
				<c:if test="${chatRoomList.chatRoomList.size() != 0}">
					<c:set var="item" value="${chatRoomList.item}"/>
					<c:set var="currentPage" value="${chatRoomList.currentPage}"/>
					<c:set var="startPage" value="${chatRoomList.startPage}"/>
					<c:set var="endPage" value="${chatRoomList.endPage}"/>
					<c:set var="totalPage" value="${chatRoomList.totalPage}"/>
					<c:set var="chatRoomList" value="${chatRoomList.chatRoomList}"/>
					<c:forEach var="chatRoomVO" items="${chatRoomList}">
						<div class="card mb-3" style="max-width: 500px;">
						 	<div class="row g-0">
						    <div class="col-md-4">
						      <img src='<spring:url value="/cover/${chatRoomVO.coverImg}"></spring:url>' class="img-fluid rounded-start" alt="커버img">
						    </div>
						    <div class="col-md-8" style="margin-bottom: 10px;">
						      <div class="card-body">
						        <h5 class="card-title">${chatRoomVO.roomName}</h5>
						        
						        <c:set var="rComment" value="${fn:replace(chatRoomVO.rComment, '>', '&gt;')}" />
								<c:set var="rComment" value="${fn:replace(rComment, '<', '&lt;')}" />
								<c:set var="rComment" value="${fn:replace(rComment, enter, '<br/>')}" />
						        
						        <p class="card-text">${rComment}</p>
						        <p class="card-text"><small class="text-muted">${chatRoomVO.roomTag}</small></p>
						      </div>
						      <div style="margin-left: 210px;">
								<button type="button" class="btn btn-outline-secondary" onclick="enter(${chatRoomVO.roomId})">
									입장하기
								</button>
								<input type="hidden" value="${chatRoomVO.userList}" id="${chatRoomVO.roomId}">
						      </div>
						    </div>
						  </div>
						</div>
						
					</c:forEach>
				</c:if>
			</div>
		</div>
	
	
<!-- 하단: 페이징작업  -->
		<div style="position: relative; left: 100px; margin-bottom: 20px; margin-top: 20px;">
			<c:if test="${item != null}">
				<c:if test="${item != ''}">
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<!-- 처음으로 -->
							<c:if test="${currentPage > 1}">
								<li class="page-item">
									<a class="page-link" href="?currentPage=1&item=${item}&set=${set}" title="첫 페이지로 이동합니다.">처음</a>
								</li>
							</c:if>
							<c:if test="${currentPage <= 1}">
								<li class="page-item">
									<a class="page-link" href="" title="이미 첫 페이지 입니다.">처음</a>
								</li>
							</c:if>
						
							<!-- 이전 페이지묶음으로 -->
							<c:if test="${startPage > 1}">
								<li class="page-item">
									<a class="page-link" href="?currentPage=${startPage - 1}&item=${item}&set=${set}" aria-label="Previous" title="이전 3 페이지로 이동합니다.">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:if test="${startPage <= 1}">
								<li class="page-item">
									<a class="page-link" href="" aria-label="Previous" title="이미 첫 3 페이지 입니다.">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<!-- 페이지 이동 -->
							<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
								<c:if test="${currentPage == i}">
									<li class="page-item">
										<a class="page-link" href="">${i}</a>
									</li>
								</c:if>
								<c:if test="${currentPage != i}">
									<li class="page-item">
										<a class="page-link" href="?currentPage=${i}&item=${item}&set=${set}">${i}</a>
									</li>
								</c:if>
							</c:forEach>
							
							<!-- 다음 페이지묶음으로 -->
							<c:if test="${endPage < totalPage}">
								<li class="page-item">
									<a class="page-link" href="?currentPage=${endPage + 1}&item=${item}&set=${set}" aria-label="Next" title="다음 3 페이지로 이동합니다.">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
							<c:if test="${endPage >= totalPage}">
								<li class="page-item">
									<a class="page-link" href="" aria-label="Next" title="이미 마지막 3 페이지 입니다.">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
							
							<!-- 마지막으로 -->
							<c:if test="${currentPage < totalPage}">
								<li class="page-item">
									<a class="page-link" href="?currentPage=${totalPage}&item=${item}&set=${set}" title="마지막 페이지로 이동합니다.">마지막</a>
								</li>
							</c:if>
							<c:if test="${currentPage >= totalPage}">
								<li class="page-item">
									<a class="page-link" href="" title="이미 마지막 페이지 입니다.">마지막</a>
								</li>
							</c:if>
						</ul>
					</nav>
				</c:if>
			</c:if>
		</div>
	
	</div>
	
	
	
	
	
	
	
	
<!-- footer삽입 -->
<script type="text/javascript">


onload = () => {
	
	
}

function checkOnly(obj) {
	
	if (obj == 1) {
		item.value = '';
		item.focus();
		
	} else if (obj == 2) {
		
		item.value = '';
		item.focus();
	}
}


function enter(obj) {
	
	// 인수 obj: id가 특정roomId인 요소객체 자체가 들어온다.
	// html문서 내에서 특정 태그의 id속성값를 기재하면 그 id를 가지고있는 태그문서객체를 가르키게된다. 
// 	console.log(obj)
	// 위에 obj를 찍은 결과를 보면 알 수 있다. 
	
	let userList = obj.value;
	let roomId = obj.id
	let userId = document.querySelector("#userId").value;
	
	if (userList.indexOf(" " + userId + "/") != -1 ) {
		alert('이미 참여중인 대화방입니다.')
	} else {
		location.href='enterRoom?roomId=' + roomId
	}
	
}		


</script>
	

</body>
</html>