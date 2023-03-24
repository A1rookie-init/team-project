
onload = () => {
	console.log("welcome chatting room")
	
	let ip = window.location.host;
	console.log(ip);

	let root = getContextPath()
	console.log(root)

   
// 채팅 서버 주소
	let url = "ws://" + ip + root +"/chatserver"

//	(계속 확인해야하므로 주석)	
// 	학원컴 
//	let url = "192.168.0.93:9090/hospital_final/"; 
//	집 거실
//	let url = "192.168.0.24:9091/hospital_final/";
//	집 내방	
//	let url = "192.168.0.7:9091/hospital_final/";
	
	
	let ws;
	
	let btnConnect = document.querySelector('#btnConnect')
	
	btnConnect.addEventListener('click', event => {
			 
			 if ($('#user').val().trim() != '') {
				 
				 ws = new WebSocket(url);
				 
				 ws.onopen = function (evt) {
					 
					 console.log('서버 연결 성공');
					 print($('#user').val(), '입장했습니다.');
					 
					 ws.send('1#' + $('#user').val() + '#');
					 
					 $('#user').attr('readonly', true);
					 $('#btnConnect').attr('disabled', true);
					 $('#btnDisconnect').attr('disabled', false);
					 $('#msg').attr('disabled', false);
					 $('#msg').focus();
				 };
				 
				 ws.onmessage = function (evt) {
					 
					 let index = evt.data.indexOf("#", 2);
					 let no = evt.data.substring(0, 1); 	
					 let user = evt.data.substring(2, index);
					 let txt = evt.data.substring(index + 1);
					 
					 if (no == '1') {
						 print2(user);
					 } else if (no == '2') {		
						 print4(user, txt);
					 } else if (no == '3') {
						 print3(user);
					 }
					 $('#list').scrollTop($('#list').prop('scrollHeight'));
				 };
				 
				 ws.onclose = function (evt) {
					 console.log('소켓이 닫힙니다.');
				 };
				 
				 ws.onerror = function (evt) {
					 console.log(evt.data);
					 ws.close()
				 };
				 
			 } else {
				 alert('유저명을 입력하세요.');
				 $('#user').focus();
				 console.log(" 접속실패")
			 }

		 
	});
		 
		 function print(user, txt) {
			 let temp = '';
			 temp += '<div style="margin-bottom:3px;">';
			 temp += '[' + user + '] ';
			 temp += txt;
			 temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
			 temp += '</div>';
			 
			 $('#list').append(temp);
		 }
		 
		 function print4(user, txt) {
			 let temp = '';
			 temp += '<div><div class="bubble" style="margin-bottom:3px; margin-left: 15px;"><div style="border-bottom: 1px solid white; text-align: center; font-size: 15px;">'
				 	+ user + 
					'</div><span style="font-size: 14px;">&nbsp;'
					+ txt +
					'</span><div style="height: 1px;"></div><div style="font-size:11px;color:#777; text-align: center;">' 
					+ new Date().toLocaleTimeString() +
					'</div></div></div>';
			 
			 $('#list').append(temp);
		 }
		 
		 function print5(user, txt) {
			 let temp = '';
			 temp += '<div align="right"><div class="bubble2" style="margin-bottom:3px; margin-right: 15px;">';
			 temp += '<div style="border-bottom: 1px solid white; text-align: center; font-size: 15px;">';
			 temp += user; 
			 temp += '</div><span style="font-size: 14px;">&nbsp;';
			 temp += txt;
			 temp += '</span><div style="height: 1px;"></div><div style="font-size:11px;color:#777; text-align: center;">'
			 temp += new Date().toLocaleTimeString();
			 temp += '</div></div></div>';
			 
			 $('#list').append(temp);
		 }
		 
		 
		 function print2(user) {
			 let temp = '';
			 temp += '<div style="margin-bottom:3px;">';
			 temp += "[" + user + "] 님이 접속했습니다." ;
			 temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
			 temp += '</div>';
			 
			 $('#list').append(temp);
		 }
		 
		 function print3(user) {
			 let temp = '';
			 temp += '<div style="margin-bottom:3px;">';
			 temp += "[" + user + "] 님이 종료했습니다." ;
			 temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
			 temp += '</div>';
			 
			 $('#list').append(temp);
		 }

	
		 $('#user').keydown(function() {
			 if (event.keyCode == 13) {		
				 $('#btnConnect').click();
			 }
		 });

		 $('#msg').keydown(function() {
			 if (event.keyCode == 13) {		
				 
				 ws.send('2#' + $('#user').val() + '#' + $(this).val()); 
				 print5($('#user').val(), $(this).val()); 
				 $('#list').scrollTop($('#list').prop('scrollHeight'));
				 $('#msg').val('');
				 $('#msg').focus();
				 
			 }
		 });

		 $('#btnDisconnect').click(function() {
			 ws.send('3#' + $('#user').val() + '#');	
			 ws.close();
			 
			 $('#user').attr('readonly', false);
			 $('#user').val('');
			 
			 $('#btnConnect').attr('disabled', false);
			 $('#btnDisconnect').attr('disabled', true);
			 
			 $('#msg').val('');
			 $('#msg').attr('disabled', true);
		 });
		
}

function getContextPath() {
	let hostIndex = location.href.indexOf(location.host) + location.host.length
	let contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1))
	return contextPath
}


