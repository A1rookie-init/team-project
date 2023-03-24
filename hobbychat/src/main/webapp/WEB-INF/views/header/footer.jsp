<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

<!-- sockJS 아래꺼 안되면 위로 바꿀 것임-->
<!-- <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<style type="text/css">

#msgStack {
	height: 160px;
	padding: 15px;
}

</style>
</head>
<body>

<div id="msgStack"></div>
<script>

// 이후 엘라스틱 프로젝트에서 구현예정 

// function timeForToday(value) {
//     const today = new Date();
//     const timeValue = new Date(value);

//     const betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
//     if (betweenTime < 1) return '몇초 전';
//     if (betweenTime < 60) {
//         return `${betweenTime}분전`;
//     }
// }



// 전역변수 설정
var socket  = null;
var root = null;
console.log(root)

$(document).ready(function(){

//	웹소켓 연결
    var sock = new SockJS("<c:url value="/echo-ws"/>");
    socket = sock;

   	sock.onopen = function() {
       console.log('info: connection opened.');
   	}

// 데이터를 전달 받았을때 
    sock.onmessage = function (evt) {
		console.log('message 옴')
        let data = evt.data;
		console.log("데이터 :" + data)
	
		if (data.substr(0, 14) == "connectingList") {
			$("#ConnectingUser").html(data.substr(14));
			
		} else if () {
			
			
		} else {
			
			let speaker = evt.data.substring(2, index);
			
			print(user, txt);
			
			$('#list').scrollTop($('#list').prop('scrollHeight'));
			

		}
        
    };
    
    sock.onclose = function() {
      	console.log('connect close');
    }

    sock.onerror = function (err) {
    	console.log('Errors : ' , err);
   	};

   	
// 새로고침 방지    	
//     document.onkeydown = NotReload;
    
    
});

   	function NotReload(){
   	    if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode == 116) ) {
   	        event.keyCode = 0;
   	        event.cancelBubble = true;
   	        event.returnValue = false;
   	    } 
   	}
   	
   	function getContextPath() {
   		let hostIndex = location.href.indexOf(location.host) + location.host.length
   		let contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1))
   		return contextPath
   	}


</script>

</body>
</html>