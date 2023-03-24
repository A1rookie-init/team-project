<%@page import="java.util.Map"%>
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

<title>환자정보조회</title>

<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />
</head>
<body>
<div>
<jsp:include page="header/header_goback_PDetail.jsp"></jsp:include>
</div>
<jsp:include page="./quickmenu.jsp"></jsp:include>


<!-- 여기 뷰 가로로 두개 다 볼수 있게 css작업 할때 수정할 예정 -->
<div style="width: 1100px; height:730px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px;">
	<form action="viewPatientDetailUpdateOK" method="post" name="viewPatientDetailUpdate">
		<div style="width: 500px; margin-left: 30px; margin-top: 50px;  margin-bottom: 50px; border: solid 1px; float: left; position: relative;">
			<table class="table table-bordered">
				<thead>
					<tr class="table-success">
						<th colspan="2">
							기본 정보
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>환자 등록 번호</th>
						<td>
							<input id="patientIdx" class="form-control" type="text" name="patientIdx" value="${patientVo.patientIdx}" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>성명</th>
						<td colspan="2">
							<input id="name" class="form-control" type="text" name="name" width="250px" value="${patientVo.name}"/>
						</td>
					</tr>
					<tr>
						<th>주민등록번호</th>
						<td colspan="2">
							<input id="registNum1" type="text" name="registNum1" autocomplete="off" maxlength="6" style="width: 150px;" value="${patientVo.registNum1}"/>
							-<input id="registNum2" type="password" name="registNum2" autocomplete="off" maxlength="7" style="width: 150px;" value="${patientVo.registNum2}"/>
						</td>
					</tr>
					<tr>
						<th class="warning" style="vertical-align: middle;">나이</th>
						<td colspan="2">
							<input id="age" class="form-control" type="text" name="age" placeholder="나이"	autocomplete="off" value="${patientVo.age}" />
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td colspan="2">
						<c:if test="${patientVo.gender == 'M'}">
							<label class="btn"> <input type="radio" name="gender" value="M" checked="checked">남</label>
							<label class="btn"> <input type="radio" name="gender" value="F">여</label>
						</c:if>
						<c:if test="${patientVo.gender == 'F'}">
							<label class="btn"> <input type="radio" name="gender" value="M">남</label>
							<label class="btn"> <input type="radio" name="gender" value="F" checked="checked">여</label>
						</c:if>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="2"><input id="address" class="form-control" type="text" name="address" value="${patientVo.address}" /></td>
					</tr>
					
					<tr>
						<th>보험 종류</th>
						<td colspan="2">
							<c:if test="${patientVo.insurance == '건강보험'}">
								<label class="btn"> <input type="radio" name="insurance" value="건강보험" checked="checked">건강보험</label> 
								<label class="btn"> <input type="radio"	name="insurance"  value="의료급여">의료급여 </label>
							</c:if>
							<c:if test="${patientVo.insurance == '의료급여'}">
								<label class="btn"> <input type="radio" name="insurance" value="건강보험">건강보험</label> 
								<label class="btn"> <input type="radio"	name="insurance"  value="의료급여" checked="checked">의료급여 </label>
							</c:if>
						</td>
					</tr>
					
					<tr>
						<th>입원실</th>
						<td colspan="2">
							<c:if test="${patientVo.room == '6인실'}">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn"><input type="radio" name="room" value="6인실" checked="checked">6인실</label> 
									<label class="btn"> <input type="radio" name="room" value="2인실">2인실</label> 
									<label class="btn"> <input type="radio" name="room" value="1인실">1인실</label>
								</div>
							</c:if>
							<c:if test="${patientVo.room == '2인실'}">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn"><input type="radio" name="room" value="6인실">6인실</label> 
									<label class="btn"> <input type="radio" name="room" value="2인실" checked="checked">2인실</label> 
									<label class="btn"> <input type="radio" name="room" value="2인실">1인실</label>
								</div>
							</c:if>
							<c:if test="${patientVo.room == '1인실'}">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn"><input type="radio" name="room" value="6인실">6인실</label> 
									<label class="btn"> <input type="radio" name="room" value="2인실">2인실</label> 
									<label class="btn"> <input type="radio" name="room" value="1인실" checked="checked">1인실</label>
								</div>
							</c:if>
						</td>
					</tr>
	
					<tr>
						<th>식사</th>
						<td colspan="2">
							<c:if test="${patientVo.meal == true}">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn"> <input type="radio" name="meal" value="true" checked="checked">식사</label> 
									<label class="btn"> <input type="radio" name="meal" value="false">신청안함</label>
								</div>
							</c:if>
							<c:if test="${patientVo.meal == false}">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn"> <input type="radio" name="meal" value="true">식사</label> 
									<label class="btn"> <input type="radio" name="meal" value="false" checked="checked">신청안함</label>
								</div>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>의무팀</th>
						<td colspan="2">
							<c:if test="${patientVo.doctorT == 'A'}">
								<select name="doctorT" style="width: 200px;">
									<option value="A" selected>의사A팀</option>
									<option value="B">의사B팀</option>
								</select>
							</c:if>
							<c:if test="${patientVo.doctorT == 'B'}">
								<select name="doctorT" style="width: 200px;">
									<option value="A">의사A팀</option>
									<option value="B" selected>의사B팀</option>
								</select>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>간호팀</th>
						<td colspan="2">
							<c:if test="${patientVo.nurseT == 'A'}">
								<select name="nurseT" style="width: 200px;">
									<option value="A" selected>간호A팀</option>
									<option value="B">간호B팀</option>
									<option value="C">간호C팀</option>
								</select>
							</c:if>
							<c:if test="${patientVo.nurseT == 'B'}">
								<select name="nurseT" style="width: 200px;">
									<option value="A">간호A팀</option>
									<option value="B" selected>간호B팀</option>
									<option value="C" >간호C팀</option>
								</select>
							</c:if>
							<c:if test="${patientVo.nurseT == 'C'}">
								<select name="nurseT" style="width: 200px;">
									<option value="A">간호A팀</option>
									<option value="B">간호B팀</option>
									<option value="C" selected>간호C팀</option>
								</select>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	<!-- 초진 정보 -->
		<div style="width: 500px; margin-right: 30px; margin-top: 50px;  margin-bottom: 50px; border: solid 1px; float: right; position: relative;">
			<table class="table table-bordered">
				<thead>
					<tr class="table-success">
						<th colspan="2">초진 정보</th>
					</tr>
				</thead>
				<tbody>
				<tr>
					<th>증상</th>
					<td>
						<textarea rows="2" id="cc" name="cc" style="resize: none; width: 98%; height: 95%;">${patientVo.cc}</textarea>
					</td>
				</tr>
				<tr>
					<th>현병력</th>
					<td>
						<textarea rows="1" id="pi" name="pi" style="resize: none; width: 98%; height: 95%;">${patientVo.pi}</textarea>
					</td>
				</tr>
				<tr>
					<th>과거력</th>
					<td>
						<textarea rows="1" id="histroy" name="histroy" style="resize: none; width: 98%; height: 95%;">${patientVo.histroy}</textarea>
					</td>
				</tr>
				<tr>
					<th>알레르기</th>
					<td colspan="2">
					<c:if test="${patientVo.allergy == 'N'}">
						<input id="allergytest" type="radio" name="allergy" autocomplete="off" value="N" checked="checked" />알러지 없음
						<input id="allergytest" type="radio" name="allergy" autocomplete="off" value="Y"/>알러지 있음 &nbsp;&nbsp;
						<input id="allergy" class="form-control" type="text" name="allergy-detail" placeholder="알레르기" autocomplete="off" disabled="disabled"/>
					</c:if>
					<c:if test="${patientVo.allergy != 'N'}">
						<input id="allergytest" type="radio" name="allergy" autocomplete="off" value="N"/>알러지 없음
						<input id="allergytest" type="radio" name="allergy" autocomplete="off" value="Y" checked="checked" />알러지 있음 &nbsp;&nbsp;
						<input id="allergy-detail" class="form-control" type="text" name="allergy-detail" placeholder="알레르기" autocomplete="off" value="${patientVo.allergy}"/>
					</c:if>
					</td>
				</tr>
				<tr>
					<th>음주여부</th>
					<td colspan="2">
						<c:if test="${patientVo.alcohol == 'Y'}">
							<input id="alcohol" type="radio"name="alcohol" autocomplete="off" value="Y" checked="checked"/>음주 &nbsp;&nbsp;
							<input id="alcohol" type="radio"name="alcohol" autocomplete="off" value="N"/>비음주
						</c:if>
						<c:if test="${patientVo.alcohol == 'N'}">
							<input id="alcohol" type="radio"name="alcohol" autocomplete="off" value="Y"/>음주 &nbsp;&nbsp;
							<input id="alcohol" type="radio"name="alcohol" autocomplete="off" value="N" checked="checked"/>비음주
						</c:if>
					</td>
				</tr>
				<tr>
					<th>흡연여부</th>
					<td colspan="2">
						<c:if test="${patientVo.smoking == 'Y'}">
							<input id="smoking" type="radio"name="smoking" autocomplete="off" value="Y" checked="checked"/>흡연 &nbsp;&nbsp;
							<input id="smoking" type="radio"name="smoking" autocomplete="off" value="N"/>비흡연
						</c:if>
						<c:if test="${patientVo.smoking == 'N'}">
							<input id="smoking" type="radio"name="smoking" autocomplete="off" value="Y"/>흡연 &nbsp;&nbsp;
							<input id="smoking" type="radio"name="smoking" autocomplete="off" value="N" checked="checked"/>비흡연
						</c:if>
					</td>
				</tr>
				<tr>
					<th>진단명</th>
					<td>
						<textarea rows="1" id="diagnosis" name="diagnosis" style="resize: none; width: 98%; height: 95%;">${patientVo.diagnosis}</textarea>
					</td>
				</tr>
				<tr>
					<th>치료계획</th>
					<td>
						<textarea rows="3" id="carePlan" name="carePlan" style="resize: none; width: 98%; height: 95%;">${patientVo.carePlan}</textarea>
					</td>
				</tr>
				<tr>
					<th>퇴원 예정일</th>
					<td colspan="2">
						<input id="exDisDate" class="form-control" type="text"name="exDisDate" placeholder=" YYYY-MM-DD" value="${patientVo.exDisDate}" autocomplete="off" oninput="autoHyphen2(this)" maxlength="10"/>
					</td>
				</tr>
					<tr>
						<td colspan="3" style="text-align: right;">
							<input type="hidden" name="dDay" value="${dDay}">
							<input type="hidden" name="patientIdx" value="${patientVo.patientIdx}">
							<input class="btn btn-info" type="submit" value="수정하기"/> 
							<input class="btn btn-danger" type="button" value="돌아가기" onclick="location.href='viewPatientDetail?patientIdx=${patientVo.patientIdx}&dDay=${dDay}'">
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

$(document).ready(function(){
	 
    // 라디오버튼 클릭시 이벤트 발생
    $("input:radio[id=allergytest]").click(function(){
 
        if($("input[name=allergy]:checked").val() == "Y"){
            $("input:text[name=allergy-detail]").attr("disabled",false);
            // radio 버튼의 value 값이 Y이라면 활성화 - 알러지 있으면 텍스트 박스 활성화
 
        }else if($("input[name=allergy]:checked").val() == "N"){
              $("input:text[name=allergy-detail]").attr("disabled",true);
              $("input:text[name=allergy-detail]").val('');
            // radio 버튼의 value 값이 N이라면 비활성화 - 알러지 없으면 텍스트 박스 비활성화 DB에 "N"자동 입력 
        }
    });
});

// 퇴원 예정 일자에 자동으로 "-" 넣어주는 코드
const autoHyphen2 = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,4})(\d{0,2})(\d{0,2})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}


//주민등록번호 다음칸으로 이동	
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
</script>


</body>
</html>