<%@page import="com.hospital.vo.NoticeToP_14VO"%>
<%@page import="com.hospital.vo.NursingComment_13VO"%>
<%@page import="com.hospital.vo.VitalSign_10VO"%>
<%@page import="com.hospital.vo.VitalSign_10List"%>
<%@page import="com.hospital.vo.Injection_11VO"%>
<%@page import="com.hospital.vo.Injection_11List"%>
<%@page import="com.hospital.vo.PrescriptionMed_4List"%>
<%@page import="com.hospital.vo.PrescriptionMed_4VO"%>
<%@page import="com.hospital.vo.Patient_1VO"%>
<%@page import="com.hospital.vo.NursingComment_13_List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간호수행</title>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.ico" />

<style type="text/css">

th {
	border: solid 1px;
}
td {
	border: solid 1px;
}

.abnormal {
	color: red;
}

</style>


</head>
<body>

<!-- header 페이지 삽입  -->
<jsp:include page="../header/header_goback_PDetail.jsp"></jsp:include>
<jsp:include page="../quickmenu.jsp"></jsp:include>

<div style="width: 1100px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px; padding: 20px;">

	<header style="align-items: center;">
	<!-- 환자정보 (환자Tag) -->
		<div style="width: 500px; border: solid 1px; margin-top: 30px; margin-left: auto; margin-right: auto; position: relative; font-size: 20px; font-weight:bold;" align="center">
			${patientVO.getPatientIdx()} ${patientVO.getName()} ${patientVO.getAge()}/${patientVO.getGender()} ${patientVO.getDiagnosis()} D+${dDay}
		</div>
	</header>
	
	<div style="width: 600px; text-align:right; margin-top: 15px; margin-left: auto; margin-right: auto; position: relative;">

<!-- 직종별 버튼 못쓰게 ========================================== -->					 	
		<c:if test="${dpart == '의사'}">
			<input type="button" value="환자 이상보고" id="alarmPtEvent" disabled="disabled"/>
			<input type="button" value="퇴원간호" onclick="location.href='viewDisNursing?patientIdx=${patientIdx}&dDay=${dDay}'" disabled="disabled"/>	
		</c:if>

		<c:if test="${dpart == '간호사'}">
	<!-- ajax버젼 버튼	 -->
			<input type="button" value="환자 이상보고" id="alarmPtEvent" />
	<%-- 			onclick="location.href='insertNoticeToDFromN?employeeIdx=${employeeIdx}&fromName=${employeeName}&patientIdx=${patientIdx}&name=${patientVO.getName()}&dDay=${dDay}'"/> --%>
			<input type="button" value="퇴원간호" onclick="location.href='viewDisNursing?patientIdx=${patientIdx}&dDay=${dDay}'"/>	
		</c:if>
		
		<c:if test="${dpart == '병리사'}">
			<input type="button" value="환자 이상보고" id="alarmPtEvent" disabled="disabled"/>
			<input type="button" value="퇴원간호" onclick="location.href='viewDisNursing?patientIdx=${patientIdx}&dDay=${dDay}'" disabled="disabled"/>	
		</c:if>
<!-- 여기까지  ======================================================   -->	
	
	</div>
	
	<div style="width: 800px; border: solid 1px; margin-top: 30px;  margin-left: auto; margin-right: auto;  position: relative;">
		<table class="table table-bordered">
		<thead>
			<tr>
				<th colspan="6">
					활력징후
				</th>
			</tr>
		</thead>
		<tbody>
			<tr align="center">
				<th width="150px">시간 </th>
				<th width="150px">혈압</th>
				<th width="150px">맥박</th>
				<th width="150px">체온</th> 
				<th width="150px">호흡</th> 
				<th>&nbsp;</th>
			</tr>
			<c:forEach var="vitalVO" items="${vitalSignList.vitalSignList}">
				<c:set var="bp" value="${vitalVO.bp}" />
				<c:set var="systolicBP" value="${fn:substring(bp,0,3)}" />
				<c:set var="diastolicBP" value="${fn:substring(bp,4,6)}" />
				<fmt:parseNumber value="${systolicBP}" var="systolicBP"/>
				<fmt:parseNumber value="${diastolicBP}" var="diastolicBP"/>
				<tr  align="center">
					<th>
			 			${vitalVO.vitalTime}
			 		</th>
					<!-- 수축기혈압 140 이상 - 고혈압 -->
					<c:if test="${systolicBP >= 140}">
					 	<td>
					 		<input style="width: 100px" type="text" value="${vitalVO.bp}" readonly="readonly" class="abnormal"/>
					 	</td>
					</c:if>
					<c:if test="${systolicBP < 140}">
					 	<c:if test="${systolicBP >= 90}">
						 	<td>
						 		<input style="width: 100px" type="text" value="${vitalVO.bp}" readonly="readonly" />
						 	</td>
					 	</c:if>
					<!-- 수축기혈압 90 미만 - 저혈압 -->
					 	<c:if test="${systolicBP < 90}">
						 	<td>
						 		<input style="width: 100px" type="text" value="${vitalVO.bp}" readonly="readonly" class="abnormal"/>
						 	</td>
					 	</c:if>
					</c:if>
					<c:if test="${vitalVO.hr > 100}">
					 	<td>
					 		<input style="width: 100px" type="text" value="${vitalVO.hr}" readonly="readonly" class="abnormal"/>
					 	</td>
					</c:if>
					<c:if test="${vitalVO.hr <= 100}">
						<c:if test="${60 <= vitalVO.hr}">
						 	<td>
						 		<input style="width: 100px" type="text" value="${vitalVO.hr}" readonly="readonly" />
						 	</td>
						</c:if>
						<c:if test="${vitalVO.hr < 60}">
						 	<td>
						 		<input style="width: 100px" type="text" value="${vitalVO.hr}" readonly="readonly" class="abnormal"/>
						 	</td>
						</c:if>
					</c:if>
					 <c:if test="${vitalVO.bt >= 37}">
					 	<td>
					 		<input style="width: 100px" type="text" value="${vitalVO.bt}" readonly="readonly" class="abnormal"/>
					 	</td>
					 </c:if>	
				 	<c:if test="${vitalVO.bt < 37}">
					 	<c:if test="${vitalVO.bt >= 35}">
						 	<td>
						 		<input style="width: 100px" type="text" value="${vitalVO.bt}" readonly="readonly" />
						 	</td>
					 	</c:if>
					 	<c:if test="${vitalVO.bt < 35}">
						 	<td>
						 		<input style="width: 100px" type="text" value="${vitalVO.bt}" readonly="readonly" class="abnormal"/>
						 	</td>
					 	</c:if>
				 	</c:if>
				 	<c:if test="${vitalVO.rr > 20}">
					 	<td>
					 		<input style="width: 100px" type="text" value="${vitalVO.rr}" readonly="readonly" class="abnormal"/>
					 	</td>
				 	</c:if>
				 	<c:if test="${vitalVO.rr <= 20}">
					 	<c:if test="${vitalVO.rr >= 12}">
						 	<td>
						 		<input style="width: 100px" type="text" value="${vitalVO.rr}" readonly="readonly" />
						 	</td>
					 	</c:if>
					 	<c:if test="${vitalVO.rr < 12}">
						 	<td>
						 		<input style="width: 100px" type="text" value="${vitalVO.rr}" readonly="readonly" class="abnormal"/>
						 	</td>
					 	</c:if>
				 	</c:if>	
					 	
				 	<td>
		 				<button type="button" 
					 			onclick="location.href='deleteNursingVital?idx=${vitalVO.idx}&vitalTime=${vitalVO.vitalTime}&patientIdx=${patientIdx}&dDay=${dDay}'"> 
		 					<img alt="삭제" src="./images/x_circle.webp" width="15px">
				 		</button>
					 	</td>
				 	</tr>
			</c:forEach>
			<form action="insertNursing" method="post">
				<tr  align="center">
			 		<th width="70px">
			 			<select name="vitalTime">
			 				<option value="MN">MN</option>
			 				<option value="1A">1A</option>
			 				<option value="2A">2A</option>
			 				<option value="3A">3A</option>
			 				<option value="4A">4A</option>
			 				<option value="5A">5A</option>
			 				<option value="6A">6A</option>
			 				<option value="7A">7A</option>
			 				<option value="8A">8A</option>
			 				<option value="9A" selected="selected">9A</option>
			 				<option value="10A">10A</option>
			 				<option value="11A">11A</option>
			 				<option value="MD">MD</option>
			 				<option value="1P">1P</option>
			 				<option value="2P">2P</option>
			 				<option value="3P">3P</option>
			 				<option value="4P">4P</option>
			 				<option value="5P">5P</option>
			 				<option value="6P">6P</option>
			 				<option value="7P">7P</option>
			 				<option value="8P">8P</option>
			 				<option value="9P">9P</option>
			 				<option value="10P">10P</option>
			 				<option value="11P">11P</option>
			 			</select>
				 		</th>
					 	<td>
					 		<input style="width: 100px" type="text" name="bp" />
					 	</td>
					 	<td>
							<input style="width: 100px" type="text" name="hr" />
					 	</td>
					 	<td>
							<input style="width: 100px" type="number" name="bt" value="36.5" step="0.1"/>
					 	</td>
					 	<td>
							<input style="width: 100px" type="number" name="rr" value="15"/>
					 	</td>
<!-- 직종별 버튼 못쓰게 ========================================== -->					 	
						<c:if test="${dpart == '의사'}">
							<td>
								<button type="submit" disabled="disabled"> <img alt="추가" src="./images/plus.jpg" width="20px"></button>
					 		</td>
						</c:if>
	
						<c:if test="${dpart == '간호사'}">
							<td>
								<button type="submit"> <img alt="추가" src="./images/plus.jpg" width="20px"></button>
							</td>
						</c:if>
						
						<c:if test="${dpart == '병리사'}">
							<td>
								<button type="submit" disabled="disabled"> <img alt="추가" src="./images/plus.jpg" width="20px"></button>
							</td>
						</c:if>
<!-- 여기까지  ======================================================   -->		 	
					<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx">
					<input type="hidden" value="${patientVO.getName()}" name="name">
					<input type="hidden" value="${employeeIdx}" name="employeeIdx">
					<input type="hidden" value="${employeeName}" name="employeeName">
					<input type="hidden" value="${dDay}" name="dDay">
					 	
				 	</tr>
				</form>
			</tbody>
		</table>
	</div>
	
	<div style="width: 800px; border: solid 1px; margin-top: 30px;  margin-left: auto; margin-right: auto;  position: relative;">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th colspan="9">
						투약
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th width="110px">처방시각</th>
					<th width="200px">약명</th>
					<th width="75px">용량</th>
					<th width="60px">경로</th>
					<th width="75px">횟수</th>
					<th width="20px">9A</th>
					<th width="20px">1P</th>
					<th width="20px">6P</th> 
					<th width="20px">9P</th>
				</tr>
				<c:if test="${injectionList.injectionList.size() != 0}">
					<c:forEach var="injectionVO" items="${injectionList.injectionList}">
						<tr>
					 		<td>
					 			<fmt:formatDate value="${injectionVO.writedate}" pattern="a h:mm:ss"/>
					 		</td>
							<td>${injectionVO.medicine}</td>
							<td>${injectionVO.dosage}</td>
							<td>${injectionVO.route}</td>
							<td>${injectionVO.injectTime}</td>
								
							<c:if test="${injectionVO.realTime9A != 'Y'}">
								<td>
									<input type="checkbox" onchange="location.href='updateNursingInject?idx=${injectionVO.idx}&time=90&patientIdx=${patientIdx}&dDay=${dDay}'"/>
								</td>
							</c:if>
				
							<c:if test="${injectionVO.realTime9A == 'Y'}">
								<td>
									<input type="checkbox" checked="checked"onchange="location.href='updateNursingInject?idx=${injectionVO.idx}&time=91&patientIdx=${patientIdx}&dDay=${dDay}'"/>
								</td>
							</c:if>
							
							<c:if test="${injectionVO.realTime1P != 'Y'}">
								<td>
									<input type="checkbox" onchange="location.href='updateNursingInject?idx=${injectionVO.idx}&time=130&patientIdx=${patientIdx}&dDay=${dDay}'"/>
								</td>
							</c:if>
							
							<c:if test="${injectionVO.realTime1P == 'Y'}">
								<td>
									<input type="checkbox" checked="checked" onchange="location.href='updateNursingInject?idx=${injectionVO.idx}&time=131&patientIdx=${patientIdx}&dDay=${dDay}'"/>
								</td>
							</c:if>
							
							<c:if test="${injectionVO.realTime6P != 'Y'}">
								<td>
									<input type="checkbox" onchange="location.href='updateNursingInject?idx=${injectionVO.idx}&time=180&patientIdx=${patientIdx}&dDay=${dDay}'"/>
								</td>
							</c:if>
							
							<c:if test="${injectionVO.realTime6P == 'Y'}">
								<td>
									<input type="checkbox" checked="checked" onchange="location.href='updateNursingInject?idx=${injectionVO.idx}&time=181&patientIdx=${patientIdx}&dDay=${dDay}'"/>
								</td>
							</c:if>
							
							<c:if test="${injectionVO.realTime9P != 'Y'}">
								<td>
									<input type="checkbox" onchange="location.href='updateNursingInject?idx=${injectionVO.idx}&time=210&patientIdx=${patientIdx}&dDay=${dDay}'"/>
								</td>
							</c:if>
							
							<c:if test="${injectionVO.realTime9P == 'Y'}">
								<td>
									<input type="checkbox" checked="checked" onchange="location.href='updateNursingInject?idx=${injectionVO.idx}&time=211&patientIdx=${patientIdx}&dDay=${dDay}'"/>
								</td>
							</c:if>	
						 	</tr>
					</c:forEach>
				</c:if>
							
				<c:if test="${injectionList.injectionList.size() == 0}">
					<tr>
						<td colspan="9" align="center">
							금일 처방내역이 없습니다.
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	
	<div style="width: 800px; border: solid 1px; margin-top: 30px;  margin-left: auto; margin-right: auto;  position: relative; padding: 5px;">
		<form action="insertNursing" method="post">
			<table class="table table-borderless" style="width: 400px;">
				<thead>
					<tr>
						<th colspan="3">
							검체채취
						</th>
					</tr>
				</thead>
				<tbody>
					<tr align="center">
						<th width="150px;">
							<label for="blood"><input type="radio" name="test" value="blood" id="blood">혈액검사</label>
						</th>
						<th width="150px;">
							<label for="urine"><input type="radio" name="test" value="urine" id="urine">소변검사</label>
						</th>
					<!-- 직종별 버튼 못쓰게 ========================================== -->					 	
						<c:if test="${dpart == '의사'}">
							<td>
								<button type="button" disabled="disabled">검사의뢰</button>
					 		</td>
						</c:if>
	
						<c:if test="${dpart == '간호사'}">
							<td>
								<!-- <button type="submit">검사의뢰</button> -->
								<!-- 검사의뢰알림 ajax버젼 -->
								<button type="button" id="alarmToPFromN">검사의뢰</button>
							</td>
						</c:if>
						
						<c:if test="${dpart == '병리사'}">
							<td>
								<button type="button" disabled="disabled">검사의뢰</button>
						 	</td>
						</c:if>
					<!-- 여기까지  ======================================================   -->		 	
				</tr>
			</table>
				<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx">
				<input type="hidden" value="${patientVO.getName()}" name="name">
				<input type="hidden" value="${employeeIdx}" name="employeeIdx">
				<input type="hidden" value="${employeeName}" name="fromName">
				<input type="hidden" value="${dDay}" name="dDay">
		</form>
	</div>
	
	
	
	
	<div style="width: 800px; border: solid 1px; margin-top: 30px;  margin-left: auto; margin-right: auto;  position: relative; padding: 5px;">
		<table class="table table-borderless">
			<thead>
				<tr>
					<th colspan="3">
						간호기록
					</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${nursingCommentList.nursingCommentList.size() != 0}">
					<c:forEach var="vo" items="${nursingCommentList.nursingCommentList}">
						<c:set var="commentName" value="comment${vo.idx}"></c:set>
						<tr>
					 		<td>
					 			<fmt:formatDate value="${vo.writedate}" pattern="a h:mm:ss"/>
					 		</td>
						 	<td width="400px">
						 		<input type="text" value="${vo.recordN}" readonly="readonly" id="${commentName}"  style="width: 500px;">
						 	</td>
						 	<td>
						 		<input type="checkbox" onchange="commentCheck(${commentName})">
						 		<input class="btn btn-outline-info btn-sm" type="button" value="수정" 
									onclick="commentUpdate(${commentName}, ${vo.idx}, ${patientIdx}, ${dDay})"/>
								<input class="btn btn-outline-danger btn-sm" type="button" value="삭제" 
									onclick="location.href='deleteNursingComment?idx=${vo.idx}&patientIdx=${patientIdx}&dDay=${dDay}'"/>
						 	</td>
					 	</tr>
					</c:forEach>
				</c:if>
				<c:if test="${nursingCommentList.nursingCommentList.size() == 0}">
					<tr>
						<td colspan="3">
							간호기록을 입력해주세요.
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<form action="insertNursing" method="post">
			<table>		
				<tr>
					<td width="120px;">&nbsp;</td>
					<td>
						&nbsp;&nbsp;<input type="text" style="width: 500px;" name="recordN"/>
					</td>

					<td>
					<!-- 직종별 버튼 못쓰게 ========================================== -->					 	
						<c:if test="${dpart == '의사'}">
							<td>
								&nbsp;&nbsp;<button type="submit" disabled="disabled" class="btn btn-info btn-sm">등록</button>
					 		</td>
						</c:if>
	
						<c:if test="${dpart == '간호사'}">
							<td>
								&nbsp;&nbsp;<button type="submit" class="btn btn-info btn-sm">등록</button>
							</td>
						</c:if>
						
						<c:if test="${dpart == '병리사'}">
							<td>
								&nbsp;&nbsp;<button type="submit" disabled="disabled" class="btn btn-info btn-sm">등록</button>
						 	</td>
						</c:if>
					<!-- 여기까지  ======================================================   -->	
					</td>
				</tr>		
			</table>
			<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx">
			<input type="hidden" value="${patientVO.getName()}" name="name">
			<input type="hidden" value="${employeeIdx}" name="employeeIdx">
			<input type="hidden" value="${employeeName}" name="employeeName">
			<input type="hidden" value="${dDay}" name="dDay">
		</form>
	</div>
</div>

<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>	
<script>


$('#alarmPtEvent').click(function(e) {
	
	let patientIdx = $('input[name="patientIdx"]').val()
	let name = $('input[name="name"]').val()
	let fromDP = '간호사'
	let employeeIdx = $('input[name="employeeIdx"]').val()
	let fromName = $('input[name="employeeName"]').val()
	let dDay = $('input[name="dDay"]').val()
	let alarmD = '환자이상'
	
	root = getContextPath()
    // 전송한 정보를 db에 저장	
    $.ajax({
        type: 'post',
        url: root + '/insertNoticeToDPtEvent',
        dataType: 'text',
        data: {
        	patientIdx: patientIdx,
        	name: name,
        	alarmD: alarmD,
        	fromDP: fromDP,
        	employeeIdx: employeeIdx,
        	fromName: fromName
        },
        success: function(){    // db전송 성공시 실시간 알림 전송
            // 소켓에 전달되는 메시지
            socket.send("간호사, D, "+ patientIdx +","+ name + ", 환자이상 ," + dDay);
        	alert(' To.의사  ' + name + '님의 이상보고 알림이 발송되었습니다.');
            console.log("db알림 전송 성공")
        }
    });
});

$('#alarmToPFromN').click(function(e) {
	
	let blood = document.querySelector('#blood')
	let urine = document.querySelector('#urine')
	let patientIdx = $('input[name="patientIdx"]').val()
	let name = $('input[name="name"]').val()
	let fromDP = '간호사'
	let employeeIdx = $('input[name="employeeIdx"]').val()
	let fromName = $('input[name="employeeName"]').val()
	let dDay = $('input[name="dDay"]').val()
	let alarmP = null;
	if (blood.checked) {
		alarmP = '혈액검사의뢰'
	} else if (urine.checked) {
		alarmP = '소변검사의뢰'
	} else {
		alert('해당하는 검사를 체크해주세요. ')
		return
	}
	
	root = getContextPath()
    // 전송한 정보를 db에 저장	
    $.ajax({
        type: 'post',
        url: root + '/insertNoticeToPFromN',
        dataType: 'text',
        data: {
        	patientIdx: patientIdx,
        	name: name,
        	alarmP: alarmP,
        	fromDP: fromDP,
        	employeeIdx: employeeIdx,
        	fromName: fromName
        },
        success: function(data){    // db전송 성공시 실시간 알림 전송
            // 소켓에 전달되는 메시지
            socket.send("간호사, P, "+ patientIdx + ", "+ name + ", " + alarmP + ", " + dDay);
        	alert(' To.병리사  ' + name + '님의 ' + alarmP + ' 알림이 발송되었습니다.');
            console.log(data)
        }
    });
});


function commentCheck(name) {
	
	name.removeAttribute("readonly");
	name.focus();
}

function commentUpdate(comment, nidx, pidx, day) {
	let recordN = comment.value;
 	location.href='updateNursingComment?idx=' + nidx + '&patientIdx=' + pidx + '&recordN=' + recordN + '&dDay=' + day;
}


</script>

</body>
</html>
