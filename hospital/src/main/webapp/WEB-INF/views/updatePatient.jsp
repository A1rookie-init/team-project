<%@page import="com.hospital.vo.Patient_1VO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 환자 초진</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.ico" />
</head>
<body>

<jsp:include page="header/header_goback_PDetail.jsp"></jsp:include>
	<jsp:include page="./quickmenu.jsp"></jsp:include>
	<div style="width: 1100px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px; padding: 20px;">
		<form action="updatePatientOK" method="post" name="updatePatient">
			<div style="width: 500px;  margin-left: auto; margin-right: auto; border: solid 1px;">
				<table class="table table-border">
					<thead>
						<tr class="table-info">
							<th colspan="2">
								<h4>신규 환자 초진</h4>
							</th>
						</tr>
					</thead>
					<tbody>
						 <tr>
							<th>환자 등록 번호</th>
							<td><input id="patientIdx" class="form-control" type="text"
								name="patientIdx" value="${patient_1vo.getPatientIdx()}" readonly="readonly"/></td>
						</tr> 
						<tr>
							<th>이름</th>
							<td colspan="2"><input id="name" class="form-control"
								type="text" name="name" value="${patient_1vo.getName()}" readonly="readonly"/></td>
						</tr>
						<tr>
							<th>증상</th>
							<td colspan="2"><input id="cc" class="form-control" type="text"
								name="cc" placeholder="증상" autocomplete="off" /></td>
						</tr>
						<tr>
							<th>현병력</th>
							<td colspan="2"><input id="pi" class="form-control" type="text"
								name="pi" placeholder="현병력" autocomplete="off" /></td>
						</tr>
						<tr>
							<th>과거력</th>
							<td colspan="2"><input id="histroy" class="form-control" type="text"
								name="histroy" placeholder="과거력" autocomplete="off" /></td>
						</tr>
						<tr>
							<th>알레르기</th>
							<td colspan="2">
								<input id="allergytest" type="radio" name="allergy" autocomplete="off" value="N"/>알러지 없음
								<input id="allergytest" type="radio" name="allergy" autocomplete="off" value="Y"/>알러지 있음 &nbsp;&nbsp;
								<input id="allergy" class="form-control" type="text" name="allergy-detail" placeholder="알레르기" autocomplete="off"  disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<th>흡연여부</th>
							<td colspan="2">
								<input id="smoking" type="radio"name="smoking" autocomplete="off" value="Y"/>흡연 &nbsp;&nbsp;
								<input id="smoking" type="radio"name="smoking" autocomplete="off" value="N"/>비흡연
							</td>
						</tr>
						<tr>
							<th>음주여부</th>
							<td colspan="2">
								<input id="alcohol" type="radio"name="alcohol" autocomplete="off" value="Y"/>음주 &nbsp;&nbsp;
								<input id="alcohol" type="radio"name="alcohol" autocomplete="off" value="N"/>비음주
							</td>
						</tr>
						<tr>
							<th>진단명</th>
							<td colspan="2"><input id="diagnosis" class="form-control" type="text"
								name="diagnosis" placeholder="진단명" autocomplete="off" /></td>
						</tr>
						<tr>
							<th>치료계획</th>
							<td colspan="2"><input id="carePlan" class="form-control" type="text"
								name="carePlan" placeholder="치료계획" autocomplete="off" /></td>
						</tr>
						<tr>
							<th>퇴원예정일</th>
							<td colspan="2">
								<input id="exDisDate" class="form-control" type="text"name="exDisDate" placeholder=" YYYY-MM-DD" autocomplete="off" oninput="autoHyphen2(this)" maxlength="10"/>
							</td>
						</tr>
						<tr>
							<td colspan="3" style="text-align: right;">
								<input class="btn btn-info"	type="submit" value="등록하기" id="newPt"/> 
								<input class="btn btn-danger" type="reset" value="다시쓰기">
								<input class="btn btn-info" type="button" value="돌아가기" onclick="history.back(-1)" >
							</td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="dDay" value="${dDay}"/>
				<input type="hidden" name="dpart" value="${dpart}"/>
				<input type="hidden" name="employeeIdx" value="${employeeIdx}"/>			
				<input type="hidden" name="employeeName" value="${employeeName}"/>
			</div>
		</form>
	</div>
<!-- footer삽입 -->
<jsp:include page="./header/footer.jsp"></jsp:include>	
<script type="text/javascript">

$(document).ready(function(){
	 
    // 라디오버튼 클릭시 이벤트 발생
    $("input:radio[id=allergytest]").click(function(){
 
        if($("input[name=allergy]:checked").val() == "Y"){
            $("input:text[name=allergy-detail]").attr("disabled",false);
            // radio 버튼의 value 값이 Y이라면 활성화
 
        }else if($("input[name=allergy]:checked").val() == "N"){
              $("input:text[name=allergy-detail]").attr("disabled",true);
            // radio 버튼의 value 값이 N이라면 비활성화
        }
    });
});

const autoHyphen2 = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,4})(\d{0,2})(\d{0,2})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}

// 초진알림
$('#newPt').click(function(e) {
	
	let patientIdx = $('input[name="patientIdx"]').val()
	let name = $('input[name="name"]').val()
	let fromDP = '의사'
	let employeeIdx = $('input[name="employeeIdx"]').val()
	let fromName = $('input[name="employeeName"]').val()
	let dDay = $('input[name="dDay"]').val()
	let alarmN = "초진완료"
	
	root = getContextPath()
	
    $.ajax({
        type: 'post',
        url: root + '/insertNoticeToNForNewAjax',
        dataType: 'text',
        data: {
        	patientIdx: patientIdx,
        	name: name,
        	alarmN: alarmN,
        	fromDP: fromDP,
        	employeeIdx: employeeIdx,
        	fromName: fromName
        },
        success: function(data){    // db전송 성공시 실시간 알림 전송
            // 소켓에 전달되는 메시지
            socket.send("의사, N, "+ patientIdx +","+ name + ", 초진완료 ," + dDay);
        	alert(' To.간호사  ' + name + '님의 초진완료 알림이 발송되었습니다.');
            console.log(data)
            location.href='viewPatientDetail?patientIdx=' + patientIdx + '&dDay=' + dDay;
        }
    });

});
</script>
	
</body>
</html>