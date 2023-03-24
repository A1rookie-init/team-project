<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>신규환자 등록</title>

<script type="text/javascript" src="./js/juminForm.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />


</head>
<body>
<body>

<jsp:include page="header/header.jsp"></jsp:include>
<jsp:include page="./quickmenu.jsp"></jsp:include>

<div style="width: 1100px;  margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px; padding: 20px;">
	<form action="insertPatientOK" method="post" name="insertPatientOK">
		<div style="width: 500px; border: solid 1px; margin-left: auto; margin-right: auto;">
			<table class="table table-border">
				<thead>
					<tr class="table-success">
						<th colspan="2">
							<h3>신규 환자 등록</h3>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th width="150px">성명</th>
						<td colspan="2">
							<input id="name" class="form-control" type="text" name="name" placeholder="이름" autocomplete="off" />
						</td>
					</tr>
					<tr>
						<th>주민등록번호</th>
						<td colspan="2">
							<input id="registNum1" type="text" name="registNum1" autocomplete="off" maxlength="6" style="width: 150px;"/>
							&nbsp;-&nbsp;&nbsp;<input id="registNum2" type="password" name="registNum2" autocomplete="off" maxlength="7" style="width: 150px;"/>
						</td>
					</tr>
					<tr>
						<th class="warning" style="vertical-align: middle;">나이</th>
						<td colspan="2">
							<input id="age" class="form-control" type="text" name="age" placeholder="나이"	autocomplete="off" />
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td colspan="2">
							<div class="form-group">
								<div class="btn-group" data-toggle="buttons">
									<label> <input type="radio" name="gender" value="M" checked="checked">남</label>&nbsp;&nbsp;
									<label> <input type="radio" name="gender" value="F">여</label>&nbsp;&nbsp;
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="2"><input id="address" class="form-control" type="text" name="address" autocomplete="off" /></td>
					</tr>
					<tr>
						<th>보험 종류</th>
						<td colspan="2">
							<div class="form-group"	>
								<div class="btn-group" data-toggle="buttons">
									<label> <input type="radio" name="insurance" value="건강보험" checked="checked">건강보험</label> &nbsp;&nbsp;
									<label> <input type="radio"	name="insurance"  value="의료급여">의료급여 </label> &nbsp;&nbsp;
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th>입원실</th>
						<td colspan="2">
							<div>
								<div class="btn-group" data-toggle="buttons">
									<label><input type="radio" name="room" checked="checked" value="6인실">6인실</label> &nbsp;&nbsp;
									<label> <input type="radio" name="room" value="2인실">2인실</label> &nbsp;&nbsp;
									<label> <input type="radio" name="room" value="1인실">1인실</label> &nbsp;&nbsp;
								</div>
							</div>
						</td>
					</tr>
	
					<tr>
						<th>식사</th>
						<td colspan="2">
							<div>
								<div class="btn-group" data-toggle="buttons">
									<label> <input type="radio" name="meal" value="true">식사</label>  &nbsp;&nbsp;
									<label> <input type="radio" name="meal"  checked="checked" value="false">신청안함</label> &nbsp;&nbsp;
								</div>
							</div>
						</td>
					</tr>
						<tr>
						<th>의사팀</th>
						<td colspan="2">
							<select name="doctorT" style="width: 200px;">
								<option value="A">의사A팀 (${teamCount.countDTeamA} 명)</option>
								<option value="B">의사B팀 (${teamCount.countDTeamB} 명)</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>간호팀</th>
						<td colspan="2">
							<select name="nurseT" style="width: 200px;">
									<option value="A">간호A팀 (${teamCount.countNTeamA} 명)</option>
									<option value="B">간호B팀 (${teamCount.countNTeamB} 명)</option>
									<option value="C">간호C팀 (${teamCount.countNTeamC} 명)</option>
							</select>
						</td>
					</tr>
					<tr align="center">
						<td colspan="3">
							<input class="btn btn-outline-primary btn-sm" type="submit" value="등록하기" id="noticeNewPt"/> &nbsp;&nbsp;&nbsp;
							<input class="btn btn-outline-danger btn-sm" type="reset" value="다시쓰기">
							<input type="hidden" value="${employeeIdx}" id="employeeIdx">
							<input type="hidden" value="${employeeName}" id="employeeName">
							<!-- 신환번호추가 -->
							<input type="hidden" value="${newPatientIdx}" id="newPatientIdx"> 
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
</div>
<!-- footer삽입 -->
<jsp:include page="./header/footer.jsp"></jsp:include>

<script type="text/javascript">
//	주민등록번호 다음칸으로 이동	
$('#registNum1').on('keyup', function() {
    if(this.value.length == 6) {
       $('#registNum2').focus()
    }
});

//	주민번호 숫자만 입력
$("input:text[id=registNum1]").on('keyup', function () {
    $(this).val($(this).val().replace(/[^0-9]/g, ""));
});
$("input:password[id=registNum2]").on('keyup', function () {
    $(this).val($(this).val().replace(/[^0-9]/g, ""));
});


// 신규환자등록 실시간 알림 
$('#noticeNewPt').click(function(e) {

	let name = $('#name').val()
	let dDay = "1"
	let patientIdx = $('#newPatientIdx').val()
	let employeeIdx = $('#employeeIdx').val()
	let fromName = $('#employeeName').val()
	let fromDP = "원무과"
	let alarmD = "신환등록";          

	root = getContextPath()
    $.ajax({
        type: 'post',
        url: root + '/insertNoticeToDForNewAjax',
        dataType: 'text',
        data: {
        	patientIdx: patientIdx,
        	name: name,
        	alarmD: alarmD,
        	fromDP: fromDP,
        	employeeIdx: employeeIdx,
        	fromName: fromName
        },
        success: function(data){    
		//	신환이라서 000000 임시번호
		    socket.send("원무과, D, " + patientIdx + ", "+ name + ", " + alarmD + ", " + dDay);
			alert(' To.의사 ' + name + '님의 ' + alarmD + ' 알림이 발송되었습니다.');
		    console.log(data)
        }
    });
	
});

 
 
</script>  

</body>
</html>