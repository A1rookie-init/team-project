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
<title>방 생성</title>
<link rel="icon" href="./images/messenger.png"/>


<style type="text/css">

.selected {

	background-color: lightpink;

}

.tag {
	border: 0px;
}

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
    <a class="nav-link" href="viewSearchRoom">방 검색</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="viewNewRoom">방 생성</a>
  </li>
</ul>

<!-- 새 방 생성하기 -->
	<div style="margin-top: 40px; margin-bottom: 100px;" align="center">
	
		<form action="createRoom" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
		
			<div class="mb-4 row" style="width: 1000px;">
				<div class="col-sm-8">
					<h3> New 대화방 </h3>
				</div>
			</div>
			
			<div class="mb-3 row" style="width: 1000px;">
				<label for="roomName" class="col-sm-2 col-form-label">방 이름</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="roomName" name="roomName" maxlength="10" required>
				</div>
				<div id="rNameCheckTxt">
				</div>
			</div>
			
			<div class="mb-3 row" style="width: 1000px;">
				<label for="roomTag" class="col-sm-2 col-form-label">방 태그</label>
				<div class="col-sm-6">
					<input type="text" name="roomTag" id="roomTag" required="required" class="form-control">
				</div>
				<div id="rTagCheckTxt">
				</div>
			</div>
			
			<div class="mb-3 row" style="width: 1000px;">
					<div class="d-flex align-items-start">
						<div class="col-sm-2">
	  						<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
							    <button class="nav-link active" id="v-pills-exercise-tab" data-bs-toggle="pill" data-bs-target="#v-pills-exercise" type="button" role="tab" aria-controls="v-pills-exercise" aria-selected="true">운동</button>
							    <button class="nav-link" id="v-pills-enter-tab" data-bs-toggle="pill" data-bs-target="#v-pills-enter" type="button" role="tab" aria-controls="v-pills-enter" aria-selected="false">엔터</button>
							    <button class="nav-link" id="v-pills-make-tab" data-bs-toggle="pill" data-bs-target="#v-pills-make" type="button" role="tab" aria-controls="v-pills-make" aria-selected="false">창작</button>
							    <button class="nav-link" id="v-pills-love-tab" data-bs-toggle="pill" data-bs-target="#v-pills-love" type="button" role="tab" aria-controls="v-pills-love" aria-selected="false">반려</button>
							    <button class="nav-link" id="v-pills-study-tab" data-bs-toggle="pill" data-bs-target="#v-pills-study" type="button" role="tab" aria-controls="v-pills-study" aria-selected="false">학습</button>
							    <button class="nav-link" id="v-pills-game-tab" data-bs-toggle="pill" data-bs-target="#v-pills-game" type="button" role="tab" aria-controls="v-pills-game" aria-selected="false">게임</button>
							    <button class="nav-link" id="v-pills-electro-tab" data-bs-toggle="pill" data-bs-target="#v-pills-electro" type="button" role="tab" aria-controls="v-pills-electro" aria-selected="false">모빌리티/전자</button>
							</div>
						</div>
							
						<div class="col-sm-6">
						<div class="tab-content" id="v-pills-tabContent">
						    <div class="tab-pane fade show active" id="v-pills-exercise" role="tabpanel" aria-labelledby="v-pills-exercise-tab" tabindex="0">
						    	<input type="button" value="#축구" class="tag">
						    	<input type="button" value="#농구" class="tag">
						    	<input type="button" value="#야구" class="tag">
						    	<input type="button" value="#런닝" class="tag">
						    	<input type="button" value="#걷기" class="tag">
						    	<input type="button" value="#등산" class="tag">
						    	<input type="button" value="#골프" class="tag">
						    	<input type="button" value="#테니스" class="tag">
						    	<input type="button" value="#클라이밍" class="tag">
						    	<input type="button" value="#헬스" class="tag">
						    	<input type="button" value="#크로스핏" class="tag">
						    	<input type="button" value="#태권도" class="tag">
						    	<input type="button" value="#운동기타" class="tag">
						    </div>
						    
						    <div class="tab-pane fade" id="v-pills-enter" role="tabpanel" aria-labelledby="v-pills-enter-tab" tabindex="0">
						    	<input type="button" value="#영화" class="tag">
						    	<input type="button" value="#연극" class="tag">
						    	<input type="button" value="#뮤지컬" class="tag">
						    	<input type="button" value="#엔터기타" class="tag">
						    </div>
						    
						    <div class="tab-pane fade" id="v-pills-make" role="tabpanel" aria-labelledby="v-pills-make-tab" tabindex="0">
						    	<input type="button" value="#글쓰기" class="tag">
						    	<input type="button" value="#블로그" class="tag">
						    	<input type="button" value="#미술" class="tag">
						    	<input type="button" value="#공예" class="tag">
						    	<input type="button" value="#사진" class="tag">
						    	<input type="button" value="#요리" class="tag">
						    	<input type="button" value="#창작기타" class="tag">
						    </div>
						    
						    <div class="tab-pane fade" id="v-pills-love" role="tabpanel" aria-labelledby="v-pills-love-tab" tabindex="0">
						    	<input type="button" value="#갱지" class="tag">
						    	<input type="button" value="#강아지" class="tag">
						    	<input type="button" value="#고양이" class="tag">
						    	<input type="button" value="#개냥이" class="tag">
						    	<input type="button" value="#토끼" class="tag">
						    	<input type="button" value="#햄스터" class="tag">
						    	<input type="button" value="#새" class="tag">
						    	<input type="button" value="#물고기" class="tag">
						    	<input type="button" value="#식물" class="tag">
						    	<input type="button" value="#곤충" class="tag">
						    	<input type="button" value="#반려기타" class="tag">
						    </div>
						    
						    <div class="tab-pane fade" id="v-pills-study" role="tabpanel" aria-labelledby="v-pills-study-tab" tabindex="0">
						    	<input type="button" value="#독서" class="tag">
						    	<input type="button" value="#영어" class="tag">
						    	<input type="button" value="#중국어" class="tag">
						    	<input type="button" value="#일본어" class="tag">
						    	<input type="button" value="#철학" class="tag">
						    	<input type="button" value="#인문학" class="tag">
						    	<input type="button" value="#경제" class="tag">
						    	<input type="button" value="#주식" class="tag">
						    	<input type="button" value="#코인" class="tag">
						    	<input type="button" value="#부동산" class="tag">
						    	<input type="button" value="#웹개발" class="tag">
						    	<input type="button" value="#앱개발" class="tag">
						    	<input type="button" value="#인공지능" class="tag">
						    	<input type="button" value="#빅데이터" class="tag">
						    	<input type="button" value="#학습기타" class="tag">
						    </div>
						    
						    <div class="tab-pane fade" id="v-pills-game" role="tabpanel" aria-labelledby="v-pills-game-tab" tabindex="0">
						    	<input type="button" value="#바람의나라" class="tag">
						    	<input type="button" value="#리니지" class="tag">
						    	<input type="button" value="#롤" class="tag">
						    	<input type="button" value="#크아" class="tag">
						    	<input type="button" value="#카트라이더" class="tag">
						    	<input type="button" value="#게임기타" class="tag">
						    </div>
						    
						    <div class="tab-pane fade" id="v-pills-electro" role="tabpanel" aria-labelledby="v-pills-electro-tab" tabindex="0">
						    	<input type="button" value="#세차" class="tag">
						    	<input type="button" value="#자동차" class="tag">
						    	<input type="button" value="#바이크" class="tag">
						    	<input type="button" value="#컴퓨터" class="tag">
						    	<input type="button" value="#모빌리티/전자기타" class="tag">
						    </div>
						</div>
					</div>	
				</div>
				
				<div class="invalid-feedback">
					1개 이상의 태그를 선택해주세요.
				</div>
			</div>
			
			<div class="mb-3 row" style="width: 1000px;">
				<label for="coverImg" class="col-sm-2 col-form-label">커버 사진</label>
				<div class="col-sm-6">
					<input type="file" class="form-control" id="parameterFile" name="parameterFile">
				</div>
			</div>
			
			<div class="mb-5 row" style="width: 1000px;">
				<label for="rComment" class="col-sm-2 col-form-label">방 소개</label>
				<div class="col-sm-6">
					<textarea class="form-control" rows="3" placeholder="소개할 내용을 입력하세요." id="rComment" name="rComment"></textarea>
				</div>
			</div>
			
			<div class="mb-3 row" style="width: 1000px;" align="right">
				<div class="col-sm-8">
					<input class="btn btn-primary" type="submit" value="생성하기">
				</div>
			</div>
	
		</form>
	</div>
	
	
<script type="text/javascript">


// submit 이벤트 처리 
(() => {
 
	'use strict'
	
	let forms = document.querySelectorAll('.needs-validation')
	
	Array.from(forms).forEach(form => {
	
		form.addEventListener('submit', event => {
  	
	  		let roomTag = document.querySelector('#roomTag');
	  		let roomName = document.querySelector('#roomName');
	  		
	  	
	  		if (!roomName.value.trim()) {
	  			roomName.value = "";
	  		} 
	  		if (!roomTag.value.trim()) {
				$("#rTagCheckTxt").html('1개 이상의 태그를 선택해주세요.');
				$("#rTagCheckTxt").css({
	            	fontSize: "15px",       
	            	color: "red"
	       		});
	  			roomTag.value = "";
	  		}
	  	
	  		if ($("#rNameCheckTxt").html() == '사용할 수 없는 이름입니다.' || $("#rNameCheckTxt").html() == '이름을 입력하세요.' 
	  			|| $("#rNameCheckTxt").html() == '1자 이상 한글10자(영문자30자) 이하로 입력해주세요.') {
	  		
	  			$('#roomName').val("")
	  		}
	  	
	    	if (!form.checkValidity()) {
	  	  
	    		event.preventDefault()
	      		event.stopPropagation()
	   		 }

    		form.classList.add('was-validated')
    		
 		}, false)
  
	})
  
})()

// tag 클래스 요소 클릭 이벤트 처리

$(".tag").on({        

    click: function(evt) { // click 이벤트가 발생했을 때
    	
    	let form1 = document.querySelector('.needs-validation')
    	
    	form1.classList.remove('was-validated')
    	
    	console.log(evt.target)
        let v = evt.target
        v.classList.toggle("selected")
        
    	let roomTag = document.querySelector('#roomTag');
    	let selectedList = document.getElementsByClassName('selected');
    	console.log(selectedList)
    	let str = "";
    	for( let i = 0; i < selectedList.length; i++ ){
			let one = selectedList.item(i);
    		str += one.value;
    		str += " "
		}
    	console.log("str: " + str)
    	str = str.trim()
    	console.log("str: " + str)
    	roomTag.value = str;

    }

});


// 컨텍스트 경로 (메소드는 header페이지에 있음)
root = getContextPath()

//
$('#roomName').focusin(function () {
	let form1 = document.querySelector('.needs-validation')
	form1.classList.remove('was-validated')
})


// 채팅방 이름 중복 방지 
$('#roomName').focusout(function () {
	
	let roomName = $('#roomName').val();
	console.log("roomName :" + roomName)
	console.log( "dud :"+ roomTag.value + ":")
	
	// 채팅방 유효성 검사
	let regExp = /^[가-힣|a-z|A-Z|0-9|]+$/
	if (!regExp.test(roomName)) {
		$("#rNameCheckTxt").html('1자 이상 한글10자(영문자, 숫자 30자) 이하로 입력해주세요.')
		$("#rNameCheckTxt").css({
		    fontSize: "15px",       
	        color: "red"
		});
		
	} else {
		
		$.ajax({
			type : "post",
			url : root + "/rNameCheck",
			dataType : 'text',
			data : {roomName: roomName},
			success : function(result) {
				console.log('성공')
				console.log(result)
				if (result == "no") {
					$("#rNameCheckTxt").html('사용할 수 없는 이름입니다.');
					$("#rNameCheckTxt").css({
			            fontSize: "15px",       
			            color: "red"
			        });
					
				} else if (result == "yes") {
					$("#rNameCheckTxt").html('사용할 수 있는 이름입니다.');
					$("#rNameCheckTxt").css({
			            fontSize: "15px",       
			            color: "green"
			        });
				} else {
					$("#rNameCheckTxt").html('이름을 입력하세요.');
					$("#rNameCheckTxt").css({
			            fontSize: "15px",       
			            color: "red"
			        });
				}
			},
			error : function(){
				console.log('실패')
			}
		})
	}
	
})


</script>
	

</body>
</html>