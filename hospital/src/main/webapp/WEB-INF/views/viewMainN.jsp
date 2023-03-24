<%@page import="com.hospital.vo.Patient_1VO"%>
<%@page import="com.hospital.vo.HandoverN_9List"%>
<%@page import="com.hospital.vo.NoticeToN_8List"%>
<%@page import="java.util.Date"%>
<%@page import="com.hospital.vo.Patient_1List_All"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간호사 메인</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/viewMain.css" />

<style type="text/css">

#d1 {
	color: blue;	/* 금일입원한 환자는 재원환자조회에서 다른색 글씨로 나오게함 */
}

.block {
	background-color: #CEECF5; /* 새 알림이 오면 블럭처리된 상태이고 클릭하면 블럭처리가 사라짐  */
}

.disUse {
	opacity: 0;
	position: absolute;
	z-index: -1;
}

.writename {

	font-size: 14px;
}


</style>


<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />
</head>
<body>

<jsp:include page="./header/header.jsp"></jsp:include>
<jsp:include page="./quickmenu.jsp"></jsp:include>
<jsp:include page="./loginList.jsp"></jsp:include>

	<div style="width: 1100px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px; overflow:auto;">
		<header>
			<input type="button" name="employee" value="사내검색" class="btn btn-success btn-sm" 
				onclick="location.href='viewSearchEmployee'"/> 
			<input type="button" name="patient" value="퇴원환자조회" class="btn btn-success btn-sm" 
				onclick="location.href='viewDisPatient'"/>
				<!-- 				채팅방초대버튼 추가 -->
			<button type="button" class="btn btn-outline-success btn-sm" 
				data-bs-toggle="modal" data-bs-target="#comment-edit-modal">채팅방</button>
		</header>

		<section>
		<nav>
			<div style="border: solid 1px; width: 500px; height: 250px; margin-left: 30px; overflow:auto;" >
				<table class="table table-hover">
					<thead>
						<tr>
							<th>
								업무 알림
							</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${noticeToNList.noticeToNList.size() != 0}">
							<c:forEach var="noticeToNVO" items="${noticeToNList.noticeToNList}">
<!-- 채팅방초대 알림 시 기준으로 할 환자는 임시설정된 것이므로 if문 추가해서 환자 안보이게함 -->
								<c:if test="${noticeToNVO.alarmN == '채팅방초대'}">
									<c:set var="alarmName" value="alarm${noticeToNVO.idx}"></c:set>
									<tr>
										<td>
											<button style="width: 100%; text-align: left;" class="block" id="${alarmName}"
												onclick="removeBlock(${alarmName})">
												${noticeToNVO.alarmN}&nbsp;&nbsp;&nbsp;from${noticeToNVO.fromDP}&nbsp;&nbsp;
												<fmt:formatDate value="${noticeToNVO.writedate}" pattern="a h:mm"/>
											</button>
										</td>
									</tr>
								</c:if>
								<c:if test="${noticeToNVO.alarmN != '채팅방초대'}">
									<c:set var="alarmName" value="alarm${noticeToNVO.idx}"></c:set>
									<tr>
										<td>
											<button style="width: 100%; text-align: left;" class="block" id="${alarmName}"
												onclick="removeBlock(${alarmName})">
												${noticeToNVO.alarmN}&nbsp;&nbsp;${noticeToNVO.patientIdx}&nbsp;&nbsp;${noticeToNVO.name}&nbsp;&nbsp;from${noticeToNVO.fromDP}&nbsp;&nbsp;
												<fmt:formatDate value="${noticeToNVO.writedate}" pattern="a h:mm"/>
											</button>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${noticeToNList.noticeToNList.size() == 0}">
							<tr>
								<td>
									수신된 알림이 없습니다.
								</td>
							</tr>
						</c:if> 
					</tbody>
				</table>
			</div>
			<br/>

			<div>
				<div style="border: solid 1px; width: 500px; height: 300px; overflow:auto; margin-left: 30px;">
					<div style="border: solid 0px; position: relative; float: left;width: 100%; ">
						<table class="table table-hover" style="width:100%" >
							<thead>
								<tr>
									<th>
										업무 인계
									</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${handoverNList.handoverNList.size() != 0}">
								<c:forEach var="handoverNVO" items="${handoverNList.handoverNList}">
									<c:set var="handName" value="hand${handoverNVO.idx}"></c:set>
									<tr>
										<td>
											<c:if test="${handoverNVO.lev > 0}">
												<c:forEach var="i" begin="1" end="${handoverNVO.lev}" step="1">
													&nbsp;&nbsp;&nbsp;
												</c:forEach>
												<img alt="화살표" src="./images/arrow2.png" width="20"/>							
											</c:if>
											<input type="checkbox" onchange="changeBtn(${handName})"/> 
											<input style="width: 250px;" type="text" readonly="readonly" value="${handoverNVO.commentN}" id="${handName}"/>
											<span class="writename"> by.${handoverNVO.fromName} <fmt:formatDate value="${handoverNVO.writedate}" pattern="MM/dd/hh:mm"/></span>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${handoverNList.handoverNList.size() == 0}">
								<tr>
									<td>
										인계 내용이 없습니다.
									</td>
								</tr>
							</c:if>	
						</tbody>
					</table>
				</div>
			</div>
			<div style="width: 99%; text-align: right; margin-bottom: 0px;">
				<form id="form" action="./insertHandoverN" method="post" >
					<input style="width: 300px;" type="text" name="commentN" id="commentN"/>
						<input type="submit" name="" value="새글등록" id="handInsert"> 
						<input type="button" name="" class="update" value="수정"> 
						<input type="button" name="" class="delete" value="삭제">
						
						<input type="hidden" value="${employeeIdx}" name="employeeIdx">
						<input type="hidden" value="${employeeName}" name="fromName">
						<input type="hidden" value="0" name="lev" id="lev">
						<input type="hidden" value="1" name="gup" id="gup">
						<input type="hidden" value="${nurseT}" name="fromDT">
				</form>
			</div>
		</div>
	</nav>
	<article>
		<div style="border: solid 1px; width: 450px; height: 600px; overflow:auto;">
			<div id="allpatient" >
				<table class="table table-hover">
					<thead>
						<tr>
							<th>
								재원환자조회
								<input type="button" name="all" value="모든환자" onclick="allpatient()">
								<input type="button" name="my" value="담당환자" onclick="mypatient()" >
								<input type="hidden" value="${nurseT}" name="nurseT">
							</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${patient_1List_All.patient_1List_All.size() != 0}">
							<c:forEach var="patientVO" items="${patient_1List_All.patient_1List_All}">
							<tr>
								<td>
							<!-- 재원환자별 스타일조정위해 태그에 아이디 설정-->				
									<button style="width: 98%; text-align: left;" id="d${patientVO.dDay}"
										onclick="location.href='viewPatientDetail?patientIdx=${patientVO.patientIdx}&dDay=${patientVO.dDay}'">
									${patientVO.patientIdx}&nbsp;&nbsp;${patientVO.name}&nbsp;&nbsp;${patientVO.age}/${patientVO.gender}&nbsp;&nbsp;${patientVO.diagnosis}&nbsp;&nbsp;D+${patientVO.dDay}
									</button>
								</td>						 	
							</tr>
							</c:forEach>
						</c:if>
						
						<c:if test="${patient_1List_All.patient_1List_All.size() == 0}">
							<tr>
								<td>
									재원 중인 환자가 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			
			<div class="disUse" id="mypatient">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>
								재원환자조회
								<input type="button" name="all" value="모든환자" onclick="allpatient()">
								<input type="button" name="my" value="담당환자" onclick="mypatient()" >
								<input type="hidden" value="${nurseT}" name="nurseT">
							</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${patient_1List_My.patient_1List_My.size() != 0}">
							<c:forEach var="patientVO" items="${patient_1List_My.patient_1List_My}">
							<tr>
								<td>
							<!-- 재원환자별 스타일조정위해 태그에 아이디 설정-->				
									<button style="width: 98%; text-align: left;" id="d${patientVO.dDay}"
										onclick="location.href='viewPatientDetail?patientIdx=${patientVO.patientIdx}&dDay=${patientVO.dDay}'">
									${patientVO.patientIdx}&nbsp;&nbsp;${patientVO.name}&nbsp;&nbsp;${patientVO.age}/${patientVO.gender}&nbsp;&nbsp;${patientVO.diagnosis}&nbsp;&nbsp;D+${patientVO.dDay}
									</button>
								</td>						 	
							</tr>
							</c:forEach>
						</c:if>
						
						<c:if test="${patient_1List_My.patient_1List_My.size() == 0}">
							<tr>
								<td>
									재원 중인 환자가 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	
	</article>
	</section>
</div>
<!-- 모달이벤트 발생 시 모달창 -->
<div class="modal fade" id="comment-edit-modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">채팅방 초대</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				</button>
			</div>
			
			<div class="modal-body">
					
					<div class="form-check">
					  <input class="form-check-input" type="radio" id="flexRadioDefault1" name="inviting" value="원무과" checked="checked">
					  <label class="form-check-label" for="flexRadioDefault1">
					    원무과
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" id="flexRadioDefault2" name="inviting" value="의사A팀">
					  <label class="form-check-label" for="flexRadioDefault2">
					    의사A팀
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" id="flexRadioDefault3" name="inviting" value="의사B팀">
					  <label class="form-check-label" for="flexRadioDefault3">
					    의사B팀
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" id="flexRadioDefault4" name="inviting" value="간호사A팀">
					  <label class="form-check-label" for="flexRadioDefault4">
					    간호사A팀
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" id="flexRadioDefault5" name="inviting" value="간호사B팀">
					  <label class="form-check-label" for="flexRadioDefault5">
					    간호사B팀
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" id="flexRadioDefault6" name="inviting" value="간호사C팀">
					  <label class="form-check-label" for="flexRadioDefault6">
					    간호사C팀
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" id="flexRadioDefault7" name="inviting" value="병리사">
					  <label class="form-check-label" for="flexRadioDefault7">
					    병리사 
					  </label>
					</div>
					<br/>
					<div>
						<button class="btn btn-outline-success btn-sm" type="button" style="font-size: 18px;" id="inviteCard">
							초대하기
						</button>
						<button class="btn btn-outline-success btn-sm" type="button" style="font-size: 18px;" onclick="location.href='chatAction'">
							입장하기
						</button>
					</div>
			</div>
		</div>
	</div>
</div>
<!-- footer삽입 -->
<jsp:include page="./header/footer.jsp"></jsp:include>

<script type="text/javascript">

//자동새로고침 함수!

/* onload = () => {
	
	setInterval(() => {
		location.href='viewMainN';
		
	}, 15 * 1000)
	
} */

// 채팅초대 실시간 알림 

$('#inviteCard').click(function(e) {

	let inBtn = $("input[name='inviting']:checked")
	let inviteBtn = inBtn.val();
	
	let rurl = "";
	let target = "";
	let content = "채팅초대";
	let name = "";
	switch(inviteBtn) {
		case "원무과":
			rurl = "/inviteA"
			target = "A";
			name = "A"
			break;
		case "의사A팀":
			rurl = "/inviteDTeamA"
			target = "D";
			name = "DA"
			break;
		case "의사B팀":
			rurl = "/inviteDTeamB"
			target = "D";
			name = "DB"
			break;
		case "간호사A팀":
			rurl = "/inviteNTeamA"
			target = "N";
			name = "NA"
			break;
		case "간호사B팀":
			target = "N";
			name = "NB"
			rurl = "/inviteNTeamB"
			break;
		case "간호사C팀":
			target = "N";
			name = "NC"
			rurl = "/inviteNTeamC"
			break;
		default:
			rurl = "/inviteP"
			target = "P";
			name = "P"
			break;
	}	         
	root = getContextPath()
	let url = root + rurl
	
	fetch(url, {
		method: 'GET' 
	}).then(response => {
		if (!response.ok) {
			alert('채팅 초대 실패');	
			return;
		}
	    socket.send("간호사, " + target + ", 000000" +", "+ name + ", " + content + ", " + "0");
		alert('채팅 초대 알림을 발송하였습니다.')
		$("#flexRadioDefault1").prop({checked : true});
	});
 
 });





// 새 알림이 오면 블럭처리된 상태인데 알림을 클릭하면 블럭처리가 사라지게하는 함수
function removeBlock(obj) {

	console.log(obj);
	obj.classList.remove("block");	
}


// 아래부터 업무인계 때 수정됐거나 추가된 코드야 

function changeBtn(obj) {	
	console.log('번호' + obj.id);
	console.log();
	let a = obj.id.substring(4);
	console.log(a);
	
	let btn = document.querySelector('#handInsert');
	let lev = document.querySelector('#lev');
	let gup = document.querySelector('#gup');
	
	if (btn.value == '댓글등록') {
		btn.value = '새글등록';
		
	} else {
		btn.value = '댓글등록';
		lev.value = '1';
		gup.value = a;
	}
	
	commentDelete(a);
	commentUpdate(a);
}
function commentDelete(a) {
	$('.delete').click(function() {		
		location.href = 'handoverNdeleteOK?idx=' + a;
	})
} 


function commentUpdate(a) {
	$('.update').click(function() {	
		if ($('#commentN').val() == null) {
			alert('수정할 내용을 입력하세요');
			$('#commentN')[0].reset();
			$('#commentN').focus();
		} else {
			location.href = 'handoverNupdateOK?idx=' + a +'&commentN=' + commentN.value;
		}
	})
}

function allpatient() {
	$('#mypatient').addClass('disUse');
	$('#allpatient').removeClass('disUse');
	
};
function mypatient() {
	$('#allpatient').addClass('disUse');
	$('#mypatient').removeClass('disUse');
};
</script>

</body>
</html>
