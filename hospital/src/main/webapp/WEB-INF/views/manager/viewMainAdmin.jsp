<%@page import="com.hospital.calendar.SolaToLunar"%>
<%@page import="com.hospital.calendar.LunarDate"%>
<%@page import="com.hospital.calendar.MyCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.hospital.vo.Employee_20VO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hospital.vo.Dpart_23List"%>
<%@page import="com.hospital.vo.Employee_20List"%>
<%-- <%@page import="com.hospital.service.PatientService"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />


</head>
<body>

	<jsp:include page="../header/header.jsp"></jsp:include>
	
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="viewMainAdmin">관리자 HOME</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="viewAdmin">사원관리</a>
  </li>  
    <c:if test="${admin == '팀장'}">
	  <c:if test="${dpart == '간호사' or dpart == '의사'}">
			  <li class="nav-item">
			    <a class="nav-link" href="viewTeamCalendar">팀스케줄 관리</a>
			  </li>
		</c:if>
		<c:if test="${dpart == '간호사'}">
			  <li class="nav-item">
			    <a class="nav-link" href="viewTeamCalendarNInsert">팀스케줄 등록</a>
			  </li>
		</c:if>
  </c:if>
</ul>

  <div>
	<div style="width: 900px; ">
		<button style="margin-left: 520px; margin-top: 10px;" type="button" class="btn btn-outline-success btn-sm" data-bs-toggle="modal" data-bs-target="#comment-edit-modal">
			실시간 공지<span class="bi bi-chat-left-dots"></span>
		</button>
	</div> 

	<div style="width: 900px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">
		<br>
		<table style="margin-top: 0px; margin-left: 0px; position: relative;" class="table table-hover">
			<tr>
				<th colspan="7" > 
			 		<h4 align="center">승인 대기중</h4>
			 	</th>
			 </tr>
			<tr>
				<th style="width: 130px; text-align: center;">사번</th>
				<th style="width: 130px; text-align: center;">성명</th>
				<th style="width: 130px; text-align: center;">부서</th>
				<th style="width: 130px; text-align: center;">팀</th>
				<th style="width: 140px; text-align: center;">내선번호</th>
				<th style="width: 150px; text-align: center;">개인연락처</th>
				<th style="width: 90px; text-align: center;">&nbsp;</th>
			</tr>
		</table>
		<c:forEach var="employeeVO" items="${employeeList.employeeList}">
			<c:if test="${employeeVO.sign == null}">
				<button onclick="location.href='viewAdminUpdate?employeeIdx=${employeeVO.employeeIdx}'" class="btn" style="border-color: black;"
					data-bs-eidx="${employeeVO.employeeIdx}"
					data-bs-name="${employeeVO.name}"
					data-bs-dnum="${employeeVO.dnumber}"
					data-bs-enum="${employeeVO.enumber}">
					<table style="border: solid 1px; margin-top: 0px; margin-left: 0px; position: relative;">
						<tr>
							<td style="width: 125px; text-align: center;">${employeeVO.employeeIdx}</td>
							<td style="width: 125px; text-align: center;">${employeeVO.name}</td>
							<c:if test="${employeeVO.dpart == '의사'}">
								<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">의무과</td>
								<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">${employeeVO.doctorT}팀</td>
							</c:if>
							<c:if test="${employeeVO.dpart == '간호사'}">
								<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">간호과</td>
								<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">${employeeVO.nurseT}팀</td>
							</c:if>
							<c:if test="${employeeVO.dpart == '병리사'}">
								<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">병리과</td>
								<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">병리팀</td>
							</c:if>
							<c:if test="${employeeVO.dpart == '원무과'}">
								<td id="eDpart${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">원무과</td>
								<td id="eTeam${employeeVO.employeeIdx}" style="width: 125px; text-align: center;">원무팀</td>
							</c:if>
							<td style="width: 150px; text-align: center;">${employeeVO.dnumber}</td>
							<td style="width: 150px; text-align: center;">${employeeVO.enumber}</td>
							<td></td>
						</tr>
					</table>
				</button>
				
				<c:if test="${employeeVO.dpart == dpart}">
				<input type="button" class="update" onclick="location.href='updateSign?employeeIdx=${employeeVO.employeeIdx}'" value="승인" />
				</c:if>
				
			</c:if>

		</c:forEach>
	</div>

</div>



	<div style="width: 900px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">
	<div><h4 align="center">병원 일정</h4></div>
	<jsp:include page="../manager/calendar.jsp"></jsp:include>

	</div>


<!-- 모달이벤트 발생 시 모달창 -->
<div class="modal fade" id="comment-edit-modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">실시간 공지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				</button>
			</div>
			
			<div class="modal-body">
					
				<div class="form-check">
				  <input class="form-check-input" type="radio" id="flexRadioDefault0" name="inviting" value="All" checked="checked">
				  <label class="form-check-label" for="flexRadioDefault0">
				    전체
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" id="flexRadioDefault1" name="inviting" value="원무과" >
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
				<div class="form-floating">
				  <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea"></textarea>
				  <label for="floatingTextarea">공지할 내용을 입력하세요.</label>
				</div>
				<br/>
				
				<div>
					<button class="btn btn-outline-success btn-sm" type="button" style="font-size: 18px;" id="managerNotice">
						전송하기
					</button>
				</div>
			</div>
		</div>
	</div>
</div>	

<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>


<script type="text/javascript">
//실시간 공지 

$('#managerNotice').click(function(e) {

	let inBtn = $("input[name='inviting']:checked")
	let inviteBtn = inBtn.val();
	let content = $("#floatingTextarea").val();
    console.log(inBtn)

	let target = "";
	let name = "";
	switch(inviteBtn) {
		case "All":
			target = "All";
			name = "All"
			break;
		case "원무과":
			target = "A";
			name = "A"
			break;
		case "의사A팀":
			target = "D";
			name = "DA"
			break;
		case "의사B팀":
			target = "D";
			name = "DB"
			break;
		case "간호사A팀":
			target = "N";
			name = "NA"
			break;
		case "간호사B팀":
			target = "N";
			name = "NB"
			break;
		case "간호사C팀":
			target = "N";
			name = "NC"
			break;
		default:
			target = "P";
			name = "P"
			break;
	}	         
	
    socket.send("관리자, " + target + ", 000000" +", "+ name + ", " + content + ", " + "0");
    $("#floatingTextarea").val("");
    $("input[name='inviting']:checked").prop({checked : false});
    
	alert('실시간 공지 알림을 전송하였습니다.')
	$(".btn-close").click()
	$("#flexRadioDefault0").prop({checked : true});
	
 });




function update() {
	$('.update').click(function() {		
		location.href = 'updateSign'
	})
}
</script>
</body>
</html>