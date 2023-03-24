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

<!-- viewNursing에서 활력징후 삭제 -->
<input type="hidden" value="${vitalTime}" id="vitalTime">

<!-- viewNursing에서 간호기록 삭제 -->
<input type="hidden" value="${cIdx}" id="cIdx">


<script type="text/javascript">

	let patientIdx = document.querySelector('#patientIdx').value;
	let dDay = document.querySelector('#dDay').value;
		
	if (document.querySelector('#vitalTime').value != '') {
		let vitalTime = document.querySelector('#vitalTime').value;
		alert(vitalTime + ' 의 활력징후가 삭제 되었습니다.');
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
			
	} else if (document.querySelector('#cIdx').value != '') {
		alert('간호기록이 삭제 되었습니다.');
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
		
	} else {
		alert('내용을 입력해주세요.')
		location.href='viewNursing?patientIdx=' + patientIdx + '&dDay=' + dDay;
	}


</script>


</body>
</html>