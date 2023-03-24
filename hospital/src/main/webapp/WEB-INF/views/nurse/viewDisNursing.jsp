<%@page import="com.hospital.vo.PrescriptionMed_4List"%>
<%@page import="com.hospital.vo.Patient_1VO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퇴원간호</title>
</head>
<body>

<!-- header 페이지 삽입  -->
<jsp:include page="../header/header_goback_PDetail.jsp"></jsp:include>
<jsp:include page="../quickmenu.jsp"></jsp:include>
<div style="width: 700px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">
	
	<div style="text-align: center; border: solid 1px; margin: 20px;">
		${patientVO.getPatientIdx()} ${patientVO.getName()} ${patientVO.getAge()}/${patientVO.getGender()} ${patientVO.getDiagnosis()} D+${dDay}
	</div>
	
	<br><br>
	
	<div style="margin-left : 40px;">
		[&nbsp;${patientVO.getName()}&nbsp;] 환자에게<br>
		<label>
			복용약의 효과, 용법, 용량, 주의사항에대해 충분히 설명함 <input type="checkbox" id="check1"><br>
		</label>
		<label>
			응급상황 발생 시 대처법을 교육함 <input type="checkbox" id="check2"><br>
		</label>
		<label>
			지속적인 질병 관리방법과 필요한 식이에 대해 설명함 <input type="checkbox" id="check3"><br>
		</label>
		
		<input type="hidden" value="${employeeIdx}" id="employeeIdx">
		<input type="hidden" value="${employeeName}" id="fromName">
		<input type="hidden" value="${patientIdx}" id="patientIdx">
		<input type="hidden" value="${patientVO.getName()}" id="name">
		<input type="hidden" value="${dDay}" id="dDay">
	</div>
	
	<br><br>
	
	<div style="margin-left : 40px; width: 450px;border: solid 1px; margin-left: 35px; position: relative;">
		<table class="table table-border">
			<thead>
				<tr>
					<th colspan="3">
						&nbsp;&nbsp;퇴원약
					</th>
				</tr>
			</thead>
			<tbody>
	
			<tr>
				<th style="width: 190px">&nbsp;약명</th>
				<th style="width: 70px">&nbsp;용량</th>
				<th style="width: 90px">&nbsp;횟수</th>
			</tr>
		
		<c:if test="${prescriptionMedList.prescriptionMedList.size() != 0}">
			<c:forEach var="prescriptionMedVO" items="${prescriptionMedList.prescriptionMedList}">
				<c:if test="${prescriptionMedVO.dischargeM eq 'Y'}">
					
						<tr>
							<td>
							<img alt="퇴원약" src="./images/arrow2.png" width="10px;">
							${prescriptionMedVO.medicine}
							</td>
							<td>${prescriptionMedVO.dosage}</td>
							
							<c:if test="${prescriptionMedVO.injectTime eq 'qid'}">
							<td>하루 한 번</td>
							</c:if>
							<c:if test="${prescriptionMedVO.injectTime eq '24h'}">
							<td>하루 한 번</td>
							</c:if>
							<c:if test="${prescriptionMedVO.injectTime eq 'bid'}">
							<td>하루 두 번</td>
							</c:if>
							<c:if test="${prescriptionMedVO.injectTime eq 'tid'}">
							<td>하루 세 번</td>
							</c:if>
							<c:if test="${prescriptionMedVO.injectTime eq 'hs'}">
							<td>자기 전</td>
							</c:if>
							
					 	</tr>

				</c:if>
			</c:forEach>
		</c:if>
			
		<c:if test="${prescriptionMedList.prescriptionMedList.size() == 0}">
			<tr>
				<td colspan="3">
					퇴원 약이 없습니다.
				</td>
			</tr>
		</c:if>
			</tbody>
		</table>
	</div>

	<div style="text-align: right; margin: 20px;">
		<input type="button" value="퇴원확인" id="disCheck"/>	
	</div>
		
</div>
<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>
<script type="text/javascript">

$('#disCheck').click(function(e) {
	
	let check1 = document.querySelector('#check1')
	let check2 = document.querySelector('#check2')
	let check3 = document.querySelector('#check3')

	if (check1.checked && check2.checked && check3.checked) {
		
		let patientIdx = $('#patientIdx').val()
		let name = $('#name').val()
		let employeeIdx = $('#employeeIdx').val()
		let dDay = $("#dDay").val()
		let fromName = $('#fromName').val()
		let fromDP = '간호사'
		let alarmA = '퇴원수속'
		
		root = getContextPath()
		
	    $.ajax({
	        type: 'post',
	        url: root + '/insertNoticeToAAjax',
	        dataType: 'text',
	        data: {
	        	patientIdx: patientIdx,
	        	name: name,
	        	alarmA: alarmA,
	        	fromDP: fromDP,
	        	employeeIdx: employeeIdx,
	        	fromName: fromName
	        },
	        success: function(data){    // db전송 성공시 실시간 알림 전송
	            // 소켓에 전달되는 메시지
	            socket.send("간호사, A, "+ patientIdx +","+ name + ", 퇴원수속 ," + dDay);
	        	alert(' To.원무과  ' + name + '님의 퇴원수속 알림이 발송되었습니다.');
	            console.log(data)
	            location.href='viewMainN'
	        }
	    });
		
	} else {
		alert('퇴원간호 수행을 완료해주세요.')
	}
});

</script>


</body>
</html>