
// 비밀 번호가 일치하는지 확인하는 함수
function passwordCheckFunction() {
	let password1 = $('#password1').val();
	let password2 = $('#password2').val();
	console.log('password1: ' + password1 + ', password2: ' + password2);
	
	if (password1 != password2) {
		$('#passwordCheckMessage').html('비밀번호가 일치하지 않습니다.');
	} else {
		$('#passwordCheckMessage').html('');	
	}
}

// ================================================

// 부서파트(dpart)에서 의사 클릭 시 의사팀(doctorT) 선택/ 간호사 선택 시 간호사 팀(nurseT) 선택

$(document).ready(function() {
	
	$('.doctorT').hide();
	$('.nurseT').hide();
	
	$("input[name='dpart']").change(function() {		
		if ($("input[name='dpart']:checked").val() == '원무과') {
			$('.doctorT').hide();
			$('.nurseT').hide();
		}
		if ($("input[name='dpart']:checked").val() == '의사') {
			$('.doctorT').show();
			$('.nurseT').hide();
			//$('.nurseT').css('disabled', 'disabled');
		}
		if ($("input[name='dpart']:checked").val() == '간호사') {
			$('.doctorT').hide();
			$('.nurseT').show();
			//$('.doctorT').css('disabled', 'disabled')
		}
		if ($("input[name='dpart']:checked").val() == '병리사') {
			$('.doctorT').hide();
			$('.nurseT').hide();
		}
	})
	
})


	













