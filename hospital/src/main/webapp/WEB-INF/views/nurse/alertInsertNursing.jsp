<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 공통으로 넘어오는 데이터 -->
<input type="hidden" value="${patientIdx}" id="patientIdx">
<input type="hidden" value="${dDay}" id="dDay">

<!-- viewNursing에서 form태그 통해 넘어오는 것들, 활력징후, 검사의뢰, 간호기록 -->
<input type="hidden" value="${vitalSign_10VO.getVitalTime()}" id="vitalSign">
<input type="hidden" value="${noticeToP_14VO.getAlarmP()}" id="noticeToP">

<input type="hidden" value="${nursingComment_13VO.getRecordN()}" id="nursingComment">

<input type="hidden" value="${blank}" id="blank">

<!-- viewNursing에서 환자 이상보고 (의사에게 알림발송)-->

<input type="hidden" value="${noticeToD_2VO.getName()}" id="noticeToD">

<!-- viewDisNursing에서 퇴원수속알림 (원무과에게 알림발송)-->

<input type="hidden" value="${noticeToA_18VO.getName()}" id="noticeToA">


<script type="text/javascript">

	let patientIdx = document.querySelector('#patientIdx').value;
	let dDay = document.querySelector('#dDay').value;

	if (document.querySelector('#vitalSign').value != '') {
		
		let vitalTime = document.querySelector('#vitalSign').value;
		alert(vitalTime + "의 활력징후가 저장되었습니다.");
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
		
	} else if (document.querySelector('#noticeToP').value != '') {
		let alarmP  = document.querySelector('#noticeToP').value;
		alert('To.병리사 ' + alarmP +' 알림이 발송되었습니다.');
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
		
	} else if (document.querySelector('#nursingComment').value != '') {
		alert( '간호기록이 등록되었습니다.');
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
		
	} else if (document.querySelector('#blank').value != '') {
		alert('내용을 입력해주세요.')
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
		
	} else if (document.querySelector('#noticeToD').value != '') {
		let name  = document.querySelector('#noticeToD').value;
		alert(' To.의사  ' + name + '님의 이상보고 알림이 발송되었습니다.')
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
		
	} else if (document.querySelector('#noticeToA').value != '') {
		let name  = document.querySelector('#noticeToA').value;
		alert(' To.원무과  ' + name + '님의 퇴원수속 알림이 발송되었습니다.')
		location.href='viewMainN';
		
	}  else {
		alert('내용을 입력해주세요.')
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
		
	}

</script>


</body>
</html>