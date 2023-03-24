onload = function () {
	
//	document.getElementsByName('registNum1')[0].focus();
	
};

function moveNext(obj, len, nextObj) {
	if (obj.value.length == len) {
		nextObj.focus();
	}
}
function formCheck(obj) {
	if (!obj.registNum1.value || obj.registNum1.value.trim().length == 0) {
		alert('주민등록번호 앞 자리를 입력하세요!!!');
		obj.registNum1.value = '';
		obj.registNum1.focus();
		return false;
	}
	
	if (obj.registNum1.value.trim().length != 6) {
		alert('주민등록번호 앞 자리는 6글자를 입력하세요!!!');
		obj.registNum1.value = '';
		obj.registNum1.focus();
		return false;
	}
	
	if (isNaN(obj.registNum1.value.trim())) {
		alert('주민등록번호 앞 자리는 숫자만 입력하세요!!!');
		obj.registNum1.value = '';
		obj.registNum1.focus();
		return false;
	}
	
	if (!obj.registNum2.value || obj.registNum2.value.trim().length == 0) {
		alert('주민등록번호 뒷 자리를 입력하세요!!!');
		obj.registNum2.value = '';
		obj.registNum2.focus();
		return false;
	}
	
	if (obj.registNum2.value.trim().length != 7) {
		alert('주민등록번호 앞 자리는 7글자를 입력하세요!!!');
		obj.registNum2.value = '';
		obj.registNum2.focus();
		return false;
	}
	
	if (isNaN(obj.registNum2.value.trim())) {
		alert('주민등록번호 뒷 자리는 숫자만 입력하세요!!!');
		obj.registNum2.value = '';
		obj.registNum2.focus();
		return false;
	}
	
	let jumin = obj.j1.value.trim() + obj.registNum2.value.trim();
	console.log(jumin);
	

	}










