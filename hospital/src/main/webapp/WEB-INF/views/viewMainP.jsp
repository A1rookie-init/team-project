<%@page import="java.util.Date"%>
<%@page import="com.hospital.vo.Patient_1VO"%>
<%@page import="com.hospital.vo.Patient_1List_All"%>
<%@page import="com.hospital.vo.WorkMemoP_15List"%>
<%@page import="com.hospital.vo.WorkMemoP_15VO"%>
<%@page import="com.hospital.vo.NoticeToP_14List"%>
<%@page import="com.hospital.vo.Employee_20VO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병리사 메인</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/viewMain.css" />
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

</head>
<body>


	<jsp:include page="header/header.jsp"></jsp:include>
	<jsp:include page="./quickmenu.jsp"></jsp:include>
	<jsp:include page="./loginList.jsp"></jsp:include>
	<div style="width: 1100px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">
		<header>
			<input type="button" name="employee" value="사내검색" class="btn btn-success btn-sm"  onclick="location.href='viewSearchEmployee'" /> 
			<input type="button" name="patient" value="퇴원환자조회" class="btn btn-success btn-sm"  onclick="location.href='viewDisPatient'" />
			<!-- 채팅방초대버튼 추가 -->				
			<button type="button" class="btn btn-outline-success btn-sm" 
				data-bs-toggle="modal" data-bs-target="#comment-edit-modal">채팅방</button>
		</header>

		<section>
			<nav>
				
				<div style="border: solid 1px; width: 500px; height: 250px; margin-left: 20px; overflow:auto;">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>
									업무 알림
								</th>
							</tr>
						</thead>
						<tbody>
					
							<c:if test="${noticeToPlist.noticeToPList.size() != 0}">
								<c:forEach var="noticeToPVO" items="${noticeToPlist.noticeToPList}">
	<!-- 채팅방초대 알림 시 기준으로 할 환자는 임시설정된 것이므로 if문 추가해서 환자 안보이게함 -->
									<c:if test="${noticeToPVO.alarmP == '채팅방초대'}">
										<tr>
											<td>
												<c:set var="alarmName" value="alarm${noticeToPVO.idx}"></c:set>
												<button style="width: 100%; text-align: left;" class="block" id="${alarmName}" onclick="removeBlock(${alarmName})">
													${noticeToPVO.alarmP}&nbsp;&nbsp;&nbsp;from${noticeToPVO.fromDP}&nbsp;&nbsp;
													<fmt:formatDate value="${noticeToPVO.writedate}" pattern="a h:mm" />
												</button>
											</td>
										</tr>
									</c:if>
									<c:if test="${noticeToPVO.alarmP != '채팅방초대'}">
										<tr>
											<td>
												<c:set var="alarmName" value="alarm${noticeToPVO.idx}"></c:set>
												<button style="width: 100%; text-align: left;" class="block" id="${alarmName}" onclick="removeBlock(${alarmName})">
													${noticeToPVO.alarmP}&nbsp;&nbsp;${noticeToPVO.patientIdx}&nbsp;&nbsp;${noticeToPVO.name}&nbsp;&nbsp;from${noticeToPVO.fromDP}&nbsp;&nbsp;
													<fmt:formatDate value="${noticeToPVO.writedate}" pattern="a h:mm" />
												</button>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<c:if test="${noticeToPlist.noticeToPList.size() == 0}">
								<tr>
									<td>
										수신된 알림이 없습니다.
									</td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div>
					<br />
					<div>
						<div style="border: solid 1px; width: 500px; height: 260px; position: relative; float: left; margin-top: 30px; margin-left: 20px; overflow:auto;">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>
											업무 메모
										</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${workmemoPlist.workmemoPList.size() != 0}">
										<c:forEach var="workmemopvo" items="${workmemoPlist.workmemoPList}">
											<c:set var="formName" value="form${workmemopvo.idx}"></c:set>
											<tr>
												<td>
													<label>
													<input type="checkbox" name="workmemo" class="workmemo" value="${workmemopvo.idx}">
													${workmemopvo.commentP}
													</label>
													<fmt:formatDate value="${workmemopvo.writedate}" pattern="MM/dd a h:mm" />
												</td>
											</tr>
											</c:forEach>
										</c:if>
										<c:if test="${workmemoPlist.workmemoPList.size() == 0}">
											<tr>
												<td>
													업무메모가 없습니다.
												</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
		
							<form id="form" action="./workmemoPOK" method="get" onsubmit="return workmemoCheck(this)">
								<div style="width: 95%; margin-bottom: 0px; align-items: stretch; margin-left: 20px;">
									<div style="float: left; margin-right: 0px;">
									<input style="width: 330px;" id="commentP" type="text" name="commentP"/>
									</div> 
									<div style="float: right; margin-left: 0px;">
										<input type="submit" value="등록"> 
										<input type="button" class="update" name="update" value="수정" onclick="updateMemo()" > 
										<input type="button" class="delete" name="delete" value="삭제" onclick="deleteMemo()">
									</div> 
								</div>
							</form>
						</div>
					</nav>

			<article>
				<div style="border: solid 1px; width: 450px; height: 600px; overflow:auto;">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>
									재원환자조회
								</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${patient_1List_All.patient_1List_All.size() != 0}">
								<c:forEach var="patientVO" items="${patient_1List_All.patient_1List_All}">
									<tr>
										<td>
											<!-- 재원환자별 스타일조정위해 태그에 아이디 설정-->
											<button style="width: 98%; text-align: left;" id="d${patientVO.dDay}" onclick="location.href='viewPatientDetail?patientIdx=${patientVO.patientIdx}&dDay=${patientVO.dDay}'">
												${patientVO.patientIdx}&nbsp;&nbsp;${patientVO.name}&nbsp;&nbsp;${patientVO.age}/${patientVO.gender}&nbsp;&nbsp;${patientVO.diagnosis}&nbsp;&nbsp;D+${patientVO.dDay}
											</button>
										</td>
									</tr>
								</c:forEach>
							</c:if>
	
							<c:if test="${patient_1List_All.patient_1List_All.size() == 0}">
								<tr>
									<td>재원 중인 환자가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
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
/* 	onload = () => {
		
		setInterval(() => {
			location.href='viewMainP';
			
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
		    socket.send("병리사, " + target + ", 000000" +", "+ name + ", " + content + ", " + "0");
			alert('채팅 초대 알림을 발송하였습니다.')
			$("#flexRadioDefault1").prop({checked : true});
		});
	 
	 });

	
	
// 새 알림이 오면 블럭처리된 상태인데 알림을 클릭하면 블럭처리가 사라지게하는 함수
function removeBlock(obj) {

	console.log(obj);
	obj.classList.remove("block");	
}


function checkboxcheck(val) {
	$('input:checkbox[name=workmemo]').each(function (val) {
		if($(this).is(":checked")==true){
	    	console.log($(this).val());
	    	let idx = $(this).val();
			$(this).val('');
			$(this).val(idx);
			commentDelete(idx);
			commentUpdate(idx);
	    };
	});
}; 
	
// 엄무 메모 수정/ 삭제
function commentDelete(idx) {
	$('.delete').click(function() {		
		location.href = 'workmemoPdeleteOK?idx=' + idx;
	})
}


function commentUpdate(idx) {
	$('.update').click(function() {	
		if ($('#commentP').val() == null) {
			alert('수정할 내용을 입력하세요');
			$('#commentP')[0].reset();
			$('#commentP').focus();
		} else {
			location.href = 'workmemoPupdateOK?idx=' + idx +'&commentP=' + commentP.value;
		}
	})
}

function deleteMemo() {
	 $('.delete').click(function() {	
	 	$('input:checkbox[name=workmemo]:checked').each(function(val) {
	 		mIdx = $(this).val();
	 		commentDelete(mIdx);
		});
	});
};
	

function commentDelete(idx) {
	if (idx == null) {
		alert('삭제할 메모를 선택하세요.')
	} else {
		location.href = 'workmemoPdeleteOK?idx=' + idx;
	};
};

function updateMemo() {
	 $('.update').click(function() {
		 var idx = $('input:checkbox[name=workmemo]:checked').val()
		 console.log(idx);
		 commentUpdate(idx);
	 });
}

function commentUpdate(idx) {
	if ($('#commentP').val() == null) {
		alert('수정할 내용을 입력하세요');
		$('#commentP')[0].reset();
		$('#commentP').focus();
	} else if (idx == null){
		alert('수정할 메모를 선택하세요');
	} else {
		location.href = 'workmemoPupdateOK?idx=' + idx +'&commentP=' + commentP.value;
	}

};



</script>
</body>
</html>
