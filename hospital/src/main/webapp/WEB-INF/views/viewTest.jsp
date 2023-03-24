<%@page import="com.hospital.vo.Patient_1VO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검사수행</title>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<style type="text/css">
.disUse {
	opacity: 0;
	position: absolute;
	z-index: -1;
}

.use {
	
}
</style>


<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />
</head>
<body>

	<!-- header 페이지 삽입  -->
	<jsp:include page="header/header_goback_PDetail.jsp"></jsp:include>
	<jsp:include page="./quickmenu.jsp"></jsp:include>
	<div style="width: 1100px; height: 800px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">
		<section>
			<div style="width: 500px; border: solid 1px; margin-top: 30px; margin-left: auto; margin-right: auto; position: relative; font-size: 20px; font-weight:bold;" align="center">
				${patientVO.getPatientIdx()} ${patientVO.getName()} ${patientVO.getAge()}/${patientVO.getGender()} ${patientVO.getDiagnosis()} D+${dDay}
			</div>
		</section>

		<section>
			<div
				style="width: 300px; border: solid 1px; margin-top: 30px; margin-left: 100px; padding: 5px;">
				<table class="table table-borderless">
					<tr align="center">
						<th>
							<label>
								<input type="radio" class="form-check-input" value="blood" id="blood" name="insertTest">혈액검사
							</label> 
							<label>
								<input type="radio" class="form-check-input" value="urine" id="urine" name="insertTest">소변검사
							</label>
						</th>
					</tr>
					<tr align="center">
						<!-- 직종별 버튼 못쓰게 ========================================== -->
						<c:if test="${dpart == '의사'}">
							<th><input type="button" class="btn btn-sm btn-outline-info"
								value="선택" onclick="insertTestCheck()" disabled="disabled" />
								<input type="button" value="결과보고"  disabled="disabled">
							</th>
						</c:if>

						<c:if test="${dpart == '간호사'}">
							<th><input type="button" class="btn btn-sm btn-outline-info"
								value="선택" onclick="insertTestCheck()" disabled="disabled" />
								<input type="button" value="결과보고" disabled="disabled">
							</th>
						</c:if>

						<c:if test="${dpart == '병리사'}">
							<td><input type="button" class="btn btn-sm btn-outline-info"
								value="선택" onclick="insertTestCheck()" />
								<input type="button" class="btn btn-sm btn-outline-info" value="결과보고" id="noticeToDNFromP">
							</td>
						</c:if>
						<!-- 여기까지  ======================================================   -->
					</tr>
				</table>
			</div>
		</section>

		<section>
			<nav>
				<!-- =====================혈액 검사 결과 기록 ==================================== -->
				<div id="bloodTest" class="disUse"
					style="border: solid 1px; width: 400px; margin-top: 20px; margin-left: 50px; float: left;">
					<div>혈액 검사 결과 기록</div>
					<form action="testbloodresult" method="post" name="testbloodresult" id="testbloodresult">
						<table id="testbloodresult" name="testbloodresult" class="table table-bordered">
							<tr>
								<th width="100px"><label for="WBC">WBC</label></th>
								<td><input type="text" id="WBC" name="WBC"
									style="width: 150px;">&nbsp;mm<sup>3</sup></td>
							</tr>
							<tr>
								<th><label for="Hb">Hb</label></th>
								<td><input type="text" id="Hb" name="Hb"
									style="width: 150px;">&nbsp;g/dl</td>
							</tr>
							<tr>
								<th><label for="Hct">Hct</label></th>
								<td><input type="text" id="Hct" name="Hct"
									style="width: 150px;">&nbsp;%</td>
							</tr>
							<tr>
								<th><label for="RBC">RBC</label></th>
								<td><input type="text" id="RBC" name="RBC"
									style="width: 150px;">&nbsp;mm3</td>
							</tr>
							<tr>
								<th><label for="MCV">MCV</label></th>
								<td><input type="text" id="MCV" name="MCV"
									style="width: 150px;">&nbsp;fl</td>
							</tr>
							<tr>
								<th><label for="MCH">MCH</label></th>
								<td><input type="text" id="MCH" name="MCH"
									style="width: 150px;">&nbsp;pg</td>
							</tr>
							<tr>
								<th><label for="MCHC">MCHC</label></th>
								<td><input type="text" id="MCHC" name="MCHC"
									style="width: 150px;">&nbsp;g/dl</td>
							</tr>
							<tr>
								<th><label for="Platelet">Platelet</label></th>
								<td><input type="text" id="Platelet" name="Platelet"
									style="width: 150px;">&nbsp;mm<sup>3</sup></td>
							</tr>
							<tr>
<!-- 							ajax코드 위해 id속성 추가함 -->
								<th colspan="2">
									<input type="hidden" name="patientIdx" value="${patientVO.getPatientIdx()}" id="patientIdxB" /> 
									<input type="hidden" name="gender" value="${patientVO.getGender()}" /> 
									<input type="hidden" name="name" value="${patientVO.getName()}" id="nameB"/> 
									<input type="hidden" name="dDay" value="${dDay}" id="dDayB"/> 
									<input type="hidden" name="employeeIdx" value="${employeeIdx}" id="employeeIdxB"/> 
									<input type="hidden" name="employeeName" value="${employeeName}" id="employeeNameB"/>
								</th>
							</tr>
							<tr align="center">
								<th colspan="2">
									<input type="submit" id="sendtestbloodresult" class="btn btn-sm btn-outline-info" value="등록"> 
									<input type="reset" class="btn btn-sm btn-outline-danger" value="다시쓰기">
								</th>
							</tr>
						</table>
					</form>
				</div>
				<!-- =====================소변 검사 결과 기록 ==================================== -->
				<div id="urineTest" class="disUse"
					style="border: solid 1px; width: 500px; margin-top: 20px; margin-left: 50px; float: left;">
					<div>소변 검사 결과 기록</div>
					<form action="testUrineresult" method="post" name="testUrineresult" id="testUrineresult">
						<table id="testUrineresult" name="testUrineresult" class="table table-bordered">
							<tr>
								<th width="100px"><label for="color">color</label></th>
								<td colspan="3"><input type="text" id="color" name="color"></td>
							</tr>
							<tr>
								<th><label for="turbidity">turbidity</label></th>
								<td colspan="3"><input type="text" id="turbidity" name="turbidity"></td>
							</tr>
							<tr>
								<th><label for="gravity">gravity</label></th>
								<td colspan="3"><input type="text" id="gravity" name="gravity"></td>
							</tr>
							<tr>
								<th><label for="acidity">acidity</label></th>
								<td colspan="3"><input type="text" id="acidity" name="acidity"></td>
							</tr>
							<tr>
								<th>albumin</th>
								<td><select name="albumin">
										<option value="Negative">Negative</option>
										<option value="Positive">Positive</option>
								</select></td>
								<th width="100px;">glucose</th>
								<td><select name="glucose">
										<option value="Normal">Normal</option>
										<option value="Abnormal">Abnormal</option>
								</select></td>
							</tr>
							<tr>
								<th>ketones</th>
								<td><select name="ketones">
										<option value="Negative">Negative</option>
										<option value="Positive">Positive</option>
								</select></td>
								<th>bilirubin</th>
								<td><select name="bilirubin">
										<option value="Negative">Negative</option>
										<option value="Positive">Positive</option>
								</select></td>
							</tr>
							<tr>
								<th>blood</th>
								<td><select name="blood">
										<option value="Negative">Negative</option>
										<option value="Positive">Positive</option>
								</select></td>
								<th>bilinogen</th>
								<td><select name="bilinogen">
										<option value="Normal">Normal</option>
										<option value="Abnormal">Abnormal</option>
								</select></td>
							</tr>
							<tr>
								<th>nitrite</th>
								<td><select name="nitrite">
										<option value="Negative">Negative</option>
										<option value="Positive">Positive</option>
								</select></td>
								<th>leukocyte</th>
								<td><select name="leukocyte">
										<option value="Negative">Negative</option>
										<option value="Positive">Positive</option>
								</select></td>
							</tr>
							<tr align="center">
								<th colspan="4">
									<input type="hidden" name="patientIdx" value="${patientVO.getPatientIdx()}" /> 
									<input type="hidden" name="gender" value="${patientVO.getGender()}" /> 
									<input type="hidden" name="name" value="${patientVO.getName()}" /> 
									<input type="hidden" name="dDay" value="${dDay}" /> 
									<input type="hidden" name="employeeIdx" value="${employeeIdx}" /> 
									<input type="hidden" name="employeeName" value="${employeeName}" /> 
									<input type="submit" id="sendtesturineresult"  class="btn btn-sm btn-outline-info" value="등록">
									<input type="reset" class="btn btn-sm btn-outline-danger" value="다시쓰기">&nbsp;
								</th>
							</tr>
						</table>
					</form>
				</div>
				<br />
				<!-- =====================파일 보내기랑 결과 보내기 ==================================== -->
				
				<div style="width: 400px; margin-top:-137px;; border: 1px solid; margin-right: 40px; float: right;">
					<form action="fileUploadResult" method="post"
						enctype="multipart/form-data">
						<table class="table table-border">
							<tr class="table-info">
								<th colspan="2">검사결과</th>
							</tr>
							<tr>
								<th colspan="2">파일 업로드</th>
							</tr>
							<!-- 직종별 버튼 못쓰게 ========================================== -->
							<c:if test="${dpart == '의사'}">
								<tr>
									<th><input type="file" name="file1" disabled="disabled" /></th>
									<td><input type="submit" value="upload"
										disabled="disabled" /></td>
								</tr>
							</c:if>

							<c:if test="${dpart == '간호사'}">
								<tr>
									<th><input type="file" name="file1" disabled="disabled" /></th>
									<td><input type="submit" value="upload"
										disabled="disabled" /></td>
								</tr>
							</c:if>

							<c:if test="${dpart == '병리사'}">
								<tr>
									<th><input type="file" name="file1" /></th>
									<td><input type="submit" value="upload" /></td>
								</tr>
							</c:if>
							<!-- 여기까지  ======================================================   -->
						</table>
						<input type="hidden" name="patientIdx" value="${patientIdx}">
						<input type="hidden" name="dDay" value="${dDay}">
					</form>
				</div>
			</nav>
		</section>
	</div>
	
<!-- footer삽입 -->
<jsp:include page="./header/footer.jsp"></jsp:include>

<script>

// 결과보고 클릭 시 결과보고 알림전송 
$('#noticeToDNFromP').click(function(e) {
	
	let blood = document.querySelector('#blood')
	let urine = document.querySelector('#urine')
	
	let patientIdx = Number($("#patientIdxB").val())
	let name = $("#nameB").val()
	let fromDP = "병리사"
	let employeeIdx = Number($("#employeeIdxB").val())
	let fromName = $("#employeeNameB").val()
	let dDay = $("#dDayB").val()
	let alarmD = null;
		
	if (blood.checked) {
		alarmD = "혈액검사보고"
	} else if (urine.checked) {
		alarmD = "소변검사보고"
	} else {
		alert('해당하는 검사를 체크해주세요. ')
		return
	}

	let data1 = {
		"patientIdx": patientIdx,
		"name": name,
		"alarmD": alarmD,
		"fromDP": fromDP,
		"employeeIdx": employeeIdx,
		"fromName": fromName
	}	
	let data2 = {
		"patientIdx": patientIdx,
		"name": name,
		"alarmN": alarmD,
		"fromDP": fromDP,
		"employeeIdx": employeeIdx,
		"fromName": fromName
	}	
	root = getContextPath()
    // 의사 알림
    $.ajax({
        type: "post",
        url: root + "/insertNoticeToDFromPAjax", 
        data: JSON.stringify(data1),
//         dataType: "json",	// 컨트롤러에서 객체로 받는데 해당객체가 json타입이아니므로없애야함.          
        contentType: "application/json; charset=UTF-8",
        success: function(data){    // db전송 성공시 실시간 알림 전송
            console.log(data)
            // 소켓에 전달되는 메시지
            socket.send("병리사, D, "+ patientIdx + ", "+ name + ", " + alarmD + ", " + dDay);
			console.log("실시간알림전송")			
        },
        error: function(errorThrown) {
            alert(errorThrown.statusText);
        }
    });
	// 간호사 알림
    $.ajax({
        type: "post",
        url: root + "/insertNoticeToNFromPAjax", 
        data: JSON.stringify(data2),
        contentType: "application/json; charset=UTF-8",
        success: function(data){    // db전송 성공시 실시간 알림 전송
            console.log(data)
            // 소켓에 전달되는 메시지
            socket.send("병리사, N, "+ patientIdx + ", "+ name + ", " + alarmD + ", " + dDay);
			console.log("실시간알림전송")			
        	alert(' To.의사 & 간호사 \n' + name + '님의 ' + alarmD + ' 알림이 발송되었습니다.');
        },
        error: function(errorThrown) {
            alert(errorThrown.statusText);
        }
    });
});

      


//  이거 수정해서 누르면 한쪽이 readonly 설정 되게 
function insertTestCheck() {
	let insertTest = $('input[name = insertTest]:checked').val();
	$('request')
	if (insertTest == 'blood') {
		$('#urineTest').addClass('disUse')
		$('#bloodTest').removeClass('disUse')
		var insertTestCheck
	} else if (insertTest == 'urine') {
		$('#bloodTest').addClass('disUse')
		$('#urineTest').removeClass('disUse')
	}
}
		


//	혈액 검사 결과 모두 입력해야 등록
$(document).ready(function(){
	$('#sendtestbloodresult').click(function() {
		if($('#WBC').val() == null || $('#WBC').val() == "" ||
     	   $('#Hb').val() == null || $('#Hb').val() == "" ||
       	   $('#Hct').val() == null || $('#Hct').val() == "" ||
     	   $('#RBC').val() == null || $('#RBC').val() == "" ||
     	   $('#MCV').val() == null || $('#MCV').val() == "" ||
     	   $('#MCH').val() == null ||  $('#MCH').val() == "" || 
    	   $('#MCHC').val() == null ||  $('#MCHC').val() == "" ||
     	   $('#Platelet').val() == null || $('#Platelet').val() == "" ||
    	   $('#WBC').val() == null|| $('#WBC').val() == "" ) {
		
				alert('검사결과를 모두 입력해주세요');
				return false;
		 
		};
	});
});

//	소변 검사 모두 입력해야 등록
$(document).ready(function(){
	$('#sendtesturineresult').click(function() {
		if($('#color').val() == null || $('#color').val() == "" ||
     	   $('#turbidity').val() == null || $('#turbidity').val() == "" ||
       	   $('#gravity').val() == null || $('#gravity').val() == "" ||
     	   $('#acidity').val() == null || $('#acidity').val() == "" ) {
		
				alert('검사결과를 모두 입력해주세요');
				return false;
		 
		};
	});
});
		
	</script>

</body>
</html>