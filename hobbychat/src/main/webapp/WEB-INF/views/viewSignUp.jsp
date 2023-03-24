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
<title>회원가입</title>
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
<jsp:include page="./header/headerLogin.jsp"></jsp:include>
<br/>
	

<!-- 가입하기 -->
	<div style="margin-top: 40px; margin-bottom: 30px;" align="center">
		<form action="signUpOK" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
		
			<div class="mb-4 row" style="width: 1000px;">
				<div class="col-sm-8">
					<h3> 회원가입 </h3>
				</div>
			</div>
			
			<div class="mb-3 row" style="width: 1000px;">
				<label for="userId" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="userId" name="userId" placeholder="4~12자 영어, 숫자로 입력해주세요" required maxlength="12" style="text-transform: lowercase;">
					<input type="hidden" required id="idCheckResult">
				</div>
				
				<div id="idCheckTxt">
				</div>
				
			</div>
			
			<div class="mb-3 row" style="width: 1000px;">
				<label for="password1" class="col-sm-2 col-form-label">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="password1" name="password1" placeholder="8~20자 영문자, 숫자, 특수문자를 포함해서 입력해주세요" maxlength="20" required>
				</div>
			</div>

			
			<div class="mb-3 row" style="width: 1000px;">
				<label for="password2" class="col-sm-2 col-form-label">비밀번호 확인</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="password2" placeholder="8~20자 영문자, 숫자, 특수문자를 포함해서 입력해주세요" maxlength="20" required>
				</div>
				
			<div id="passwordCheckTxt1"></div>
			<div id="passwordCheckTxt2"></div>

			</div>

			<div class="mb-3 row" style="width: 1000px;">
				<label for="nickName" class="col-sm-2 col-form-label">닉네임</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="nickName" name="nickName" maxlength="8" required>
				</div>
				<div id="nickNameCheckTxt"></div>
			</div>
			
			<div class="mb-3 row" style="width: 1000px;">
				<label for="myTag" class="col-sm-2 col-form-label">관심태그</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="myTag" name="myTag" placeholder="1개 이상의 태그를 선택해주세요." required>
				</div>
				<div id="tagCheckTxt"></div>
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
				
			</div>
				
				
			<div class="mb-3 row" style="width: 1000px;">
				<label for="profileImg" class="col-sm-2 col-form-label">프로필 사진</label>
				<div class="col-sm-6">
					<input type="file" class="form-control" id="profileImg" name="profileImg">
				</div>
			</div>
			
			<div class="mb-5 row" style="width: 1000px;">
				<label for="myComment" class="col-sm-2 col-form-label">소개</label>
				<div class="col-sm-6">
					<textarea class="form-control" rows="3" placeholder="소개할 내용을 입력하세요." id="myComment" name="myComment"></textarea>
				</div>
			</div>
			
			<div class="mb-5 row" style="width: 1000px;">
				<div class="col-sm-2">
					개인정보 제공
				</div>
				<div class="col-sm-6" align="left">
					<input class="form-check-input" type="checkbox" id="agreeCheck" value="" required>
					<label for="agreeCheck" class="col-check-label"> &nbsp; 동의</label>
				</div>
				<div class="invalid-feedback">
					가입을 위해 동의해주세요.
				</div>
			</div>

			<div class="mb-3 row" style="width: 1000px;" align="right">
				<div id = "submitCheck"></div>
				<div class="col-sm-8">
					<input class="btn btn-primary" type="submit" value="가입하기">
				</div>
			</div>
		
		</form>
	</div>
	
<!-- < input태그의 required 속성 > -->
<!-- required 속성은 불리언(boolean) 속성입니다. 불리언 속성은 해당 속성을 명시하지 않으면  -->
<!-- 속성값이 자동으로 false 값을 가지게 되며, 명시하면 자동으로 true 값을 가지게 됩니다. -->
	
	
	
<script type="text/javascript">

//Example starter JavaScript for disabling form submissions if there are invalid fields


// submit 이벤트 처리 
(() => {
 
	'use strict'

	let forms = document.querySelectorAll('.needs-validation');

	Array.from(forms).forEach(form => {
	
		form.addEventListener('submit', event => {
  	
	  		let userId = document.querySelector('#userId');
	  		let password1 = document.querySelector('#password1');
	  		let password2 = document.querySelector('#password2');
	  		let nickName = document.querySelector('#nickName');
	  		let myTag = document.querySelector('#myTag');
	  	
	  		if (!myTag.value.trim()) {
	  			myTag.value = "";
	  		} 
	  		if (!myTag.value.trim()) {
	  			myTag.value = "";
				$("#tagCheckTxt").html('1개 이상의 태그를 선택해주세요.');
				$("#tagCheckTxt").css({
	            	fontSize: "15px",       
	            	color: "red"
	       		});
	  		}
	  		
		  	
	  		if ($("#idCheckTxt").html() == '영문자로 시작하는 영문자, 숫자 4~12자로 입력하세요.' || $("#idCheckTxt").html() == '이미 사용중인 아이디입니다.' 
	  			|| $("#idCheckTxt").html() == '아이디를 입력하세요.') {
	  		
	  			$('#userId').val("")
	  		}
	  		
	  		if ($("#passwordCheckTxt1").html() == '8 ~ 20자 영문자, 숫자, 특수문자를 포함해서 입력해주세요' || $("#passwordCheckTxt2").html() == '비밀번호가 서로 일치하지 않습니다') {
	  			
	  			$('#password1').val("")
	  			$('#password2').val("")
	  		}
	  		
	  		if ($("#nickNameCheckTxt").html() == '한글, 영문, 숫자만 사용 가능합니다' || $("#nickNameCheckTxt").html() == '이미 사용중인 닉네임 입니다.'
	  			|| $("#nickNameCheckTxt").html() == "닉네임을 입력하세요.") {
	  			
	  			$('#nickName').val("")
	  			$('#nickName').val("")
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

    click: function(evt) {
    	
    	let form1 = document.querySelector(".needs-validation")
    	form1.classList.remove("was-validated")
    	
    	console.log(evt.target)
        let v = evt.target
        v.classList.toggle("selected")
        
    	let myTag = document.querySelector('#myTag');
    	let selectedList = document.getElementsByClassName('selected');
    	console.log(selectedList)
    	let str = "";
    	for(let i = 0; i < selectedList.length; i++ ){
			let one = selectedList.item(i);
    		str += one.value + " ";
    	}
    	console.log("str: " + str)
    	str = str.trim()
    	console.log("str: " + str)
    	myTag.value = str;
    }
});

	

//전역변수
var root = null;      // 컨텍스트 경로 위해 

//컨텍스트경로 얻는 함수
function getContextPath() {
	let hostIndex = location.href.indexOf(location.host) + location.host.length
	let contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1))
	return contextPath
}

// 컨텍스트 경로
root = getContextPath()

$("#userId").focusin(function () {
   	let form1 = document.querySelector(".needs-validation")
   	form1.classList.remove("was-validated")
})
$("#password1").focusin(function () {
   	let form1 = document.querySelector(".needs-validation")
   	form1.classList.remove("was-validated")
})
$("#password2").focusin(function () {
   	let form1 = document.querySelector(".needs-validation")
   	form1.classList.remove("was-validated")
})
$("#nickName").focusin(function () {
   	let form1 = document.querySelector(".needs-validation")
   	form1.classList.remove("was-validated")
})

// 아이디 체크
$('#userId').focusout(function() {
	

	let userId = $('#userId').val().toLowerCase();
	console.log("userId :" + userId)
	console.log(root)

	// 아이디 유효성 검사
	let regExp = /^[a-z]+[a-z0-9]{3,12}$/g;
	if (!regExp.test(userId)) {
		$("#idCheckTxt").html('영문자로 시작하는 영문자, 숫자 4~12자로 입력하세요.');
		$("#idCheckTxt").css({
            fontSize: "15px",       
            color: "red"
		});
		
	} else {
		// 아이디 중복 검사(ajax)
		$.ajax({
			type : "post",
			url : root + "/idCheck",
			dataType : 'text',
			data : {userId: userId},
			success : function(result) {
				console.log('성공')
				console.log(result)
				
				if (result == "no") {
					$("#idCheckTxt").html('이미 사용중인 아이디입니다.');
					$("#idCheckTxt").css({
			            fontSize: "15px",       
			            color: "red"
			        });
					
				} else if (result == "yes") {
					$("#idCheckTxt").html('사용할 수 있는 이름입니다.');
					$("#idCheckTxt").css({
			            fontSize: "15px",       
			            color: "green"
			        });
				} else {
					$("#idCheckTxt").html('아이디를 입력하세요.');
					$("#idCheckTxt").css({
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

// 비밀번호 유효성 검사
$("#password1").focusout(function() {
	let password1 = $("#password1").val();
	let password2 = $("#password2").val();
	
	let regExp = /^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,20}$/;
	
	if (!regExp.test(password1)) {
		$("#passwordCheckTxt1").html("8 ~ 20자 영문자, 숫자, 특수문자를 포함해서 입력해주세요");
		$("#passwordCheckTxt1").css({
	    	fontSize: "15px",       
        	color: "red"
		})
	} else {
		$("#passwordCheckTxt1").html("")
		$("#passwordCheckTxt2").html("")
	}
	
	if (password1 != password2) {
		$("#passwordCheckTxt2").html("비밀번호가 서로 일치하지 않습니다")
		$("#passwordCheckTxt2").css({
	    fontSize: "15px",       
        color: "red"
		})
	} else {
		$("#passwordCheckTxt2").html("비밀번호가 일치합니다.")
		$("#passwordCheckTxt2").css({
		    fontSize: "15px",       
	        color: "green"
		})
	}

	
	if (password1 == "") {
		$("#passwordCheckTxt1").html("")
	}
	
	if (password2 == "") {
		$("#passwordCheckTxt2").html("")
	}
	
	if (password1 == password2) {
		$("#passwordCheckTxt2").html("")
	}
	
	
})

$("#password2").focusout(function() {
	let password1 = $("#password1").val();
	let password2 = $("#password2").val();
	
	if (password1 != password2) {
			$("#passwordCheckTxt2").html("비밀번호가 서로 일치하지 않습니다")
			$("#passwordCheckTxt2").css({
		    fontSize: "15px",       
	        color: "red"
			})
	} else {
		$("#passwordCheckTxt2").html("비밀번호가 일치합니다.")
		$("#passwordCheckTxt2").css({
		    fontSize: "15px",       
	        color: "green"
		})
	}
	
	if (password1 == "") {
		$("#passwordCheckTxt2").html("")
	} 
})

// 닉네임 체크
$("#nickName").focusout(function () {
	let nickName = $('#nickName').val();
	
	// 닉네임 유효성 검사
	let regExp = /^[가-힣|a-z|A-Z|0-9|]+$/
	if (!regExp.test(nickName)) {
		$("#nickNameCheckTxt").html("한글, 영문, 숫자만 사용 가능합니다")
		$("#nickNameCheckTxt").css({
		    fontSize: "15px",       
	        color: "red"
		});
		
	} else {
		// 닉네임 중복 검사(ajax)
		$.ajax({
			type: "post",
			url : root + "/nickNameCheck",
			dataType : "text",
			data : {nickName: nickName},
			success : function(result) {
				
				if (result == "no") {
					$("#nickNameCheckTxt").html('이미 사용중인 닉네임 입니다.');
					$("#nickNameCheckTxt").css({
			            fontSize: "15px",       
			            color: "red"
			        });
					
				} else if (result == "yes") {
					$("#nickNameCheckTxt").html('사용할 수 있는 닉네임 입니다.');
					$("#nickNameCheckTxt").css({
			            fontSize: "15px",       
			            color: "green"
			        });
					
				} else {
					$("#nickNameCheckTxt").html('닉네임을 입력하세요.');
					$("#nickNameCheckTxt").css({
			            fontSize: "15px",       
			            color: "red"
			        });
				}
			},
			error : function() {
				console.log('실패')
			}
		})
	}
})




</script>
	

</body>
</html>