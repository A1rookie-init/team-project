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

<!-- viewNursing에서 투약 체크 수정 -->
<input type="hidden" value="${realTime}" id="realTime">

<!-- viewNursing에서 간호기록 수정 -->
<input type="hidden" value="${nursingComment_13VO.getRecordN()}" id="recordN">
<input type="hidden" value="${nursingComment_13VO.getPatientIdx()}" id="pIdx">

<script type="text/javascript">
	
	let patientIdx = document.querySelector('#patientIdx').value;
	let dDay = document.querySelector('#dDay').value;
		
	if (document.querySelector('#realTime').value != '') {
		let realTime = document.querySelector('#realTime').value;
		alert(realTime + ' 투약여부가 변경되었습니다.');
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
			
	} else if (document.querySelector('#recordN').value != '') {
		let pIdx = document.querySelector('#pIdx').value;
		alert('간호기록이 수정 되었습니다.');
		location.href='viewNursing?patientIdx=' + pIdx + '&dDay=' + dDay;
		
	} else {
		alert('내용을 입력해주세요.')
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
		
	}
	
</script>


</body>
</html>