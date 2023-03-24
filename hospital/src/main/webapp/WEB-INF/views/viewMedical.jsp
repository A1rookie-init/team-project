<%@page import="com.hospital.vo.Medicine_22VO"%>
<%@page import="com.hospital.vo.Medicine_22List"%>
<%@page import="com.hospital.vo.PrescriptionTest_5List"%>
<%@page import="com.hospital.vo.PrescriptionMed_4List"%>
<%@page import="com.hospital.vo.Patient_1VO"%>
<%@page import="com.hospital.vo.MedicalComment_7List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료수행</title>

<meta name="viewpport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<link rel="shortcut icon" type="image/x-icon" href="./images/logo.png" />

<style type="text/css">
</style>

</head>

<body>

<!-- 헤더 삽입 -->
<jsp:include page="header/header_goback_PDetail.jsp"></jsp:include>
<jsp:include page="./quickmenu.jsp"></jsp:include>
<div style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px; padding: 20px;">

		<!-- 환자정보 (환자Tag) -->
		<div style="width: 500px; border: solid 1px; margin-top: 30px; margin-left: auto; margin-right: auto; position: relative; font-size: 20px; font-weight:bold;" align="center">
			${patientVO.getPatientIdx()} ${patientVO.getName()} ${patientVO.getAge()}/${patientVO.getGender()} ${patientVO.getDiagnosis()} D+${dDay}
		</div>

		<br />
			<c:if test="${mediSearch == 'f'}">
				<c:if test="${mediCode == 'f'}">
<!-- 약 검색 누르기 전 -->
					<form action="insertMedical" method="post">
						<div style="border: solid 1px; width: 400px;">
							<table class="table table-borderless">
								<thead>
									<tr>
										<th colspan="2"> 
											<div>
												<label for="mediName"> 약물처방 </label>
											</div>
										</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											약명
										</td>
										<td>
											<input id="mediName" name="mediName" type="text" style="width: 240px;" />
									
											<!-- 직종별 버튼 못쓰게 ========================================== -->
											<c:if test="${dpart == '의사'}">
												<button type="submit" onclick="mediNameSearch()">검색</button>
											</c:if>
		
											<c:if test="${dpart == '간호사'}">
												<button type="submit" onclick="mediNameSearch()" disabled="disabled">검색</button>
											</c:if>
		
											<c:if test="${dpart == '병리사'}">
												<button type="submit" onclick="mediNameSearch()" disabled="disabled">검색</button>
											</c:if>
											<!-- 여기까지  ======================================================   -->
									
										</td>
									</tr>
									<tr>
										<td>
											약용량
										</td>
										<td>
											 <input id="dosage" name="dosage" type="text" style="width: 240px;">
										</td>
									</tr>
									<tr>
										<td>
											투약경로
										</td>
										<td>
											<input value="PO" name="route" type="radio"/>PO &nbsp;
											<input value="IV" name="route" type="radio" />IV &nbsp;
											<input value="IM" name="route" type="radio" />IM &nbsp;
											<input value="SC" name="route" type="radio" />SC&nbsp;
										</td>
									</tr>
									<tr>
										<td>
											투약시간
										</td>
										<td>
											<input value="qp" name="injectTime" type="radio" />qid &nbsp;
											<input value="bid" name="injectTime" type="radio" />bid &nbsp;
											<input value="tid" name="injectTime" type="radio" />tid &nbsp;
											<input value="hs" name="injectTime" type="radio" />hs &nbsp;
											<input value="24h" name="injectTime" type="radio" />24h&nbsp;
										</td>
									</tr>		
									<tr>
										<td colspan="2">
											퇴원약 <input class="checkDisM" type="checkbox" onchange="checkDisM()">
											<!-- ============================================================= -->
											<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx" /> 
											<input type="hidden" value="${patientVO.getName()}" name="name"> 
											<input type="hidden" value="${employeeIdx}" name="employeeIdx">
											<input type="hidden" value="${employeeName}" name="employeeName">
											<input type="hidden" value="${dDay}" name="dDay">
											<!-- ============================================================= -->
										</td>
									</tr>
									<!-- 직종별 버튼 못쓰게 ========================================== -->
									<c:if test="${dpart == '의사'}">
										<tr >
											<td colspan="2">
												<input name="mediInsert" type="submit" value="처방등록" /> 
												<input name="mediReset" type="reset" value="다시쓰기">
											</td>
										</tr>
									</c:if>
									<c:if test="${dpart == '간호사'}">
										<tr>
											<td colspan="2">
												<input name="mediInsert" type="submit" value="처방등록" disabled="disabled"/> 
												<input name="mediReset" type="reset" value="다시쓰기" disabled="disabled">
											</td>
										</tr>							
									</c:if>
									<c:if test="${dpart == '병리사'}">
										<tr>
											<td colspan="2">
												<input name="mediInsert" type="submit" value="처방등록" disabled="disabled"/> 
												<input name="mediReset" type="reset" value="다시쓰기" disabled="disabled">
											</td>
										</tr>
									</c:if>
									<!-- 여기까지  ======================================================   -->
									</tbody>
								</table>
							</div>
							<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx"> 
							<input type="hidden" value="${patientVO.getName()}" name="name"> 
							<input type="hidden" value="${employeeIdx}" name="employeeIdx">
							<input type="hidden" value="${employeeName}" name="employeeName">
							<input type="hidden" value="${dDay}" name="dDay"> 
							<input type="hidden" value="N" name="dischargeM" id="dischargeM">

						</form>
					</c:if>
				
<!-- 약 검색 리스트에서 특정 약을 눌렀을때 / 처방등록버튼 누를 당시는 아래 코드로 작동됨-->
				<c:if test="${mediCode == 't'}">
					<div style="border: solid 1px; width: 400px;">
						<form action="insertMedical" method="post">
							<table class="table table-borderless">
								<thead>
									<tr>
										<td>
											<label for="mediName"> 약물처방 </label>
										</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td width="80px;">
											약명
										</td>
										<td>
											<input id="medicine" name="medicine" type="text" value="${medicineVO.getMedicine()}" style="width: 240px;">
											<!-- 직종별 버튼 못쓰게 ========================================== -->
											<c:if test="${dpart == '의사'}">
												<input value="검색" type="submit" onclick="mediNameSearch()">
											</c:if>
											<c:if test="${dpart == '간호사'}">
												<input value="검색" type="submit" 
													onclick="mediNameSearch()" disabled="disabled">
											</c:if>
											<c:if test="${dpart == '병리사'}">
												<input value="검색" type="submit" 
													onclick="mediNameSearch()" disabled="disabled">
											</c:if>
											<!-- 여기까지  ======================================================   -->
										</td>
									</tr>
									<tr>
										<td>
											약용량
										</td>
										<td>
											<input id="dosage" name="dosage" type="text" value="${medicineVO.getDosage()}">
										</td>
									</tr>
									<tr>
										<td>
											투약경로
										</td>
										<td>
											<c:if test="${medicineVO.getRoute() == 'PO'}">
												<input value="PO" name="route" type="radio" checked="checked">PO &nbsp;
												<input value="IV" name="route" type="radio">IV &nbsp;
												<input value="IM" name="route" type="radio">IM &nbsp;
												<input value="SC" name="route" type="radio">SC &nbsp;
											</c:if>
											<c:if test="${medicineVO.getRoute() == 'IV'}">
												<input value="PO" name="route" type="radio">PO &nbsp;
												<input value="IV" name="route" type="radio" checked="checked">IV &nbsp;
												<input value="IM" name="route" type="radio">IM &nbsp;
												<input value="SC" name="route" type="radio">SC &nbsp;
											</c:if>
											<c:if test="${medicineVO.getRoute() == 'IM'}">
												<input value="PO" name="route" type="radio">PO &nbsp;
												<input value="IV" name="route" type="radio">IV &nbsp;
												<input value="IM" name="route" type="radio" checked="checked">IM &nbsp;
												<input value="SC" name="route" type="radio">SC &nbsp;				 				
											</c:if>
											<c:if test="${medicineVO.getRoute() == 'SC'}">
												<input value="PO" name="route" type="radio">PO &nbsp;
												<input value="IV" name="route" type="radio">IV &nbsp;
												<input value="IM" name="route" type="radio">IM &nbsp;
												<input value="SC" name="route" type="radio" checked="checked">SC &nbsp;
											</c:if>
										</td>
									</tr>
									<tr>
										<td>
											투약시간
										</td>
										<td>
											<c:if test="${medicineVO.getInjectTime() == 'qid'}">
												<input value="qp" name="injectTime" type="radio" checked="checked">qid &nbsp;
												<input value="bid" name="injectTime" type="radio">bid &nbsp;
												<input value="tid" name="injectTime" type="radio">tid &nbsp;
												<input value="hs" name="injectTime" type="radio">hs &nbsp;
												<input value="24h" name="injectTime" type="radio">24h &nbsp;					
											</c:if>
											<c:if test="${medicineVO.getInjectTime() == 'bid'}">
												<input value="qp" name="injectTime" type="radio">qid &nbsp;
												<input value="bid" name="injectTime" type="radio" checked="checked">bid &nbsp;
												<input value="tid" name="injectTime" type="radio">tid &nbsp;
												<input value="hs" name="injectTime" type="radio">hs &nbsp;
												<input value="24h" name="injectTime" type="radio">24h &nbsp;	
											</c:if>
											<c:if test="${medicineVO.getInjectTime() == 'tid'}">
												<input value="qp" name="injectTime" type="radio">qid &nbsp;
												<input value="bid" name="injectTime" type="radio">bid &nbsp; 
												<input value="tid" name="injectTime" type="radio" checked="checked">tid &nbsp; 
												<input value="hs" name="injectTime" type="radio">hs &nbsp;
												<input value="24h" name="injectTime" type="radio">24h &nbsp;				
											</c:if>
											<c:if test="${medicineVO.getInjectTime() == 'hs'}">
												<input value="qp" name="injectTime" type="radio">qid &nbsp;
												<input value="bid" name="injectTime" type="radio">bid &nbsp;
												<input value="tid" name="injectTime" type="radio">tid &nbsp;
												<input value="hs" name="injectTime" type="radio" checked="checked">hs &nbsp;
												<input value="24h" name="injectTime" type="radio">24h &nbsp;
											</c:if>
											<c:if test="${medicineVO.getInjectTime() == '24h'}">
												<input value="qp" name="injectTime" type="radio">qid &nbsp;
												<input value="bid" name="injectTime" type="radio">bid &nbsp;
												<input value="tid" name="injectTime" type="radio">tid &nbsp;
												<input value="hs" name="injectTime" type="radio">hs &nbsp;
												<input value="24h" name="injectTime" type="radio" checked="checked">24h &nbsp;						
											</c:if>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											퇴원약 <input class="checkDisM" type="checkbox" onchange="checkDisM()">
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<!-- 직종별 버튼 못쓰게 ========================================== -->
											<c:if test="${dpart == '의사'}">
												<input type="submit" name="mediInsert" id="noticeToNforMed" value="처방등록">
											<!--다시쓰기 기능 수정함 -->
												<input type="button" name="mediReset"  id="mediReset" onclick="location.href='resetMediSearch?patientIdx=${patientIdx}&dDay=${dDay}'" value="다시쓰기">
											</c:if>
				
											<c:if test="${dpart == '간호사'}">
												<input type="submit" name="mediInsert" onclick="mediNameSearch()" value="처방등록" disabled="disabled">
												<input type="button" name="mediReset" id="mediReset" onclick="mediReset()" value="다시쓰기" disabled="disabled">
											</c:if>
				
											<c:if test="${dpart == '병리사'}">
												<button type="submit" name="mediInsert" onclick="mediNameSearch()" disabled="disabled">처방등록</button>
												<button type="button" name="mediReset" id="mediReset" onclick="mediReset()" disabled="disabled">다시쓰기</button>
											</c:if>
											<!-- 여기까지  ======================================================   -->
										</td>
									</tr>

							</tbody>
						</table>
						<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx"> 
						<input type="hidden" value="${patientVO.getName()}" name="name"> 
						<input type="hidden" value="${employeeIdx}" name="employeeIdx">
						<input type="hidden" value="${employeeName}" name="employeeName">
						<input type="hidden" value="${dDay}" name="dDay"> 
						<input type="hidden" value="N" name="dischargeM" id="dischargeM">
					</form>
				</div>
			</c:if>
		</c:if>
			
<!-- 약물검색 후에 해당하는 약물리스트 나올때 -->
			<c:if test="${mediSearch == 't'}">
				<form action="insertMedical" method="post">
					<div style="border: solid 1px; width: 400px;">
						<table class="table table-borderless">
							<thead>
								<tr>
									<th colspan="2">
										<label for="mediName"> 약물처방 </label>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td width="80px;">
										약명
									</td>
									<td>
										<input id="mediName" name="mediName" type="text" style="width: 240px;"> 
										<input value="검색" type="submit" onclick="mediNameSearch()">
									</td>
								</tr>
								<c:if test="${medicineList.medicineList.size() != 0}">
									<tr>
										<td colspan="2">
											<table style=" width:320px; border: solid 1px; margin-top: 5px; margin-left: auto; margin-right: auto; margin-bottom: 20px;" class="table">
												<tr>
													<th colspan="2" align="center">&nbsp;코드&nbsp;&nbsp;&nbsp;&nbsp;약명</th>
												</tr>
												<c:forEach var="medicineVO" items="${medicineList.medicineList}">
													<tr>
														<td colspan="2" align="center">
															<button type="button" style="width: 300px; text-align: left;" id="mediset"
																	onclick="location.href='viewMedicalBack?code=${medicineVO.code}&patientIdx=${patientIdx}&dDay=${dDay}'">
																${medicineVO.code}&nbsp;&nbsp;&nbsp;&nbsp;${medicineVO.medicine}
															</button>
														</td>
													</tr>
												</c:forEach>
										
											</table>
										</td>
									</tr>
								</c:if>
								<c:if test="${medicineList.medicineList.size() == 0}">
									<tr>
										<td colspan="2" align="center">검색한 약물이 존재하지 않습니다.</td>
									</tr>
								</c:if>
								<tr>
									<td>
										약용량
									</td>
									<td>
										<input id="dosage" name="dosage" type="text" style="width: 240px;"><br/>
									</td>
								</tr>
								<tr>
									<td>
										투약경로
									</td>
									<td>
										<input value="PO" name="route" type="radio">PO &nbsp;
										<input value="IV" name="route" type="radio">IV &nbsp;
										<input value="IM" name="route" type="radio">IM &nbsp;
										<input value="SC" name="route" type="radio">SC &nbsp;
									</td>
								</tr>
								<tr>
									<td>
										투약시간 
									</td>
									<td>
										<input value="qp" name="injectTime" type="radio">qid &nbsp;
										<input value="bid" name="injectTime" type="radio">bid &nbsp;
										<input value="tid" name="injectTime" type="radio">tid &nbsp;
										<input value="hs" name="injectTime" type="radio">hs &nbsp;
										<input value="24h" name="injectTime" type="radio">24h &nbsp;
									</td>
								</tr>
								<!-- 퇴원약 체크 -->
								<tr>
									<td colspan="2">
										퇴원약 <input class="checkDisM" type="checkbox" onchange="checkDisM()">
										<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx"> 
										<input type="hidden" value="${patientVO.getName()}" name="name"> 
										<input type="hidden" value="${employeeIdx}" name="employeeIdx">
										<input type="hidden" value="${employeeName}" name="employeeName">
										<input type="hidden" value="${dDay}" name="dDay">
									</td>
								</tr>
<!-- 직종별 버튼 못쓰게 ========================================== -->
								<c:if test="${dpart == '의사'}">
									<tr >
										<td colspan="2">
											<input name="mediInsert" type="submit" value="처방등록" /> 
											<input name="mediReset" type="reset" value="다시쓰기">
										</td>
									</tr>
									</c:if>
									<c:if test="${dpart == '간호사'}">
										<tr>
											<td colspan="2">
												<input name="mediInsert" type="submit" value="처방등록"  disabled="disabled"/> 
												<input name="mediReset" type="reset" value="다시쓰기">
											</td>
										</tr>
									</c:if>
									<c:if test="${dpart == '병리사'}">
										<tr>
											<td colspan="2">
												<input name="mediInsert" type="submit" value="처방등록" disabled="disabled"/> 
												<input name="mediReset" type="reset" value="다시쓰기">
											</td>
										</tr>
									</c:if>
								</tbody>
							</table>
							<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx"> 
							<input type="hidden" value="${patientVO.getName()}" name="name"> 
							<input type="hidden" value="${employeeIdx}" name="employeeIdx"> 
							<input type="hidden" value="${employeeName}" name="employeeName">
							<input type="hidden" value="${dDay}" name="dDay"> 
							<input type="hidden" value="N" name="dischargeM" id="dischargeM">
						</div>
					</form>
				</c:if>
			<br />
		
		
		<div style="width: 400px; border: solid 1px;">
			<form action="insertMedical" method="post">
				<table class="table table-borderless">
					<thead>
						<tr>
							<th colspan="2">
								검사처방
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td align="center">
								<label for="blood">
									<input type="radio" name="test" value="blood" id="blood">혈액검사 &nbsp;&nbsp;&nbsp;
								</label> 
								<label for="urine">
									<input type="radio" name="test" value="urine" id="urine">소변검사
								</label>
							</td>
						</tr>
						<tr>
							<!-- 직종별 버튼 못쓰게 ========================================== -->
							<c:if test="${dpart == '의사'}">
								<td align="center">
									<input name="mediasd" type="submit" value="처방등록"  id="noticeTestAjax"/>&nbsp;&nbsp;&nbsp;
									<input name="mediasd" type="reset" value="다시쓰기">
								</td>
							</c:if>
		
							<c:if test="${dpart == '간호사'}">
								<td align="center">
									<input name="mediasd" type="submit" value="처방등록" disabled="disabled" />&nbsp;&nbsp;&nbsp;
									<input name="mediasd" type="reset" value="다시쓰기" disabled="disabled" />
								</td>
							</c:if>
		
							<c:if test="${dpart == '병리사'}">
							<td align="center">
								<input name="mediasd" type="submit" value="처방등록" disabled="disabled" />&nbsp;&nbsp;&nbsp;
								<input name="mediasd" type="reset" value="다시쓰기" disabled="disabled" />
							</td>
							</c:if>
							<!-- 여기까지  ======================================================   -->
						</tr>
					</tbody>
				</table>
				<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx"/> 
				<input type="hidden" value="${patientVO.getName()}" name="name"/> 
				<input type="hidden" value="${employeeIdx}" name="employeeIdx"/> 
				<input type="hidden" value="${employeeName}" name="employeeName"/>
				<input type="hidden" value="${dDay}" name="dDay"/>
			</form>
		</div>

		<br />
		
		
		<div>
			<div style="border: solid 1px; width: 800px;">
				<table class="table table-borderless">
					<thead>
						<tr>
							<th colspan="8">
								처방내역
							</th>
						</tr>
					</thead>
					<tbody>
						<!-- 약물처방 삭제 -->
						<c:if test="${prescriptionMedList.prescriptionMedList.size() != 0}">
							<c:forEach var="prescriptionMedVO" items="${prescriptionMedList.prescriptionMedList}">
								<tr>
									<td>
										<table id="preMed-${prescriptionMedVO.idx}" style="margin-top: 0px; margin-left: 0px; position: relative;">
											<tr>
												<td><img alt="화살표" src="./images/arrow2.png" width="20" />
													&nbsp;&nbsp;</td>
												<td width="120px;"><fmt:formatDate value="${prescriptionMedVO.writedate}" pattern="a h:mm:ss" /></td>
												<td>
													<input type="text" value="${prescriptionMedVO.medicine}" readonly="readonly"/>
												</td>
												<td>
													<input type="text" size="5" value="${prescriptionMedVO.route}" readonly="readonly" />
												</td>
												<td>
													<input type="text" size="3" value="${prescriptionMedVO.dosage}" readonly="readonly" />
												</td>
												<td>
													<input type="text" size="3" value="${prescriptionMedVO.injectTime}" readonly="readonly" />
												</td>
												<!-- 직종별 버튼 못쓰게 의사만가능 ========================================== -->
												<c:if test="${dpart == '의사'}">
													<td>
														<!-- ajax 방식 -->
														<button type="button" class="deletePreMed" data-deletePreMed="${prescriptionMedVO.idx}" 
															id="preMedIdx-${prescriptionMedVO.idx}" data-bs-mediAjax="${prescriptionMedVO.medicine}">
															<%-- onclick="location.href='deleteMediPreMed?idx=${prescriptionMedVO.idx}&patientIdx=${patientIdx}&dDay=${dDay}'"> --%>
															 <img alt="삭제" src="./images/x_circle.webp" width="20px">
														</button>
													</td>
												</c:if>	
												<c:if test="${dpart == '간호사'}">
													<td>
														<button type="button" disabled="disabled">
															<img alt="삭제" src="./images/x_circle.webp" width="20px">
														</button>
													</td>
												</c:if>
				
												<c:if test="${dpart == '병리사'}">
													<td>
														<button type="button" disabled="disabled">
															<img alt="삭제" src="./images/x_circle.webp" width="20px">
														</button>
													</td>
												</c:if>	
												<!-- 여기까지===========================================  -->
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<!-- 검사 처방 삭제 -->
						<c:if test="${prescriptionTestList.prescriptionTestList.size() != 0}">
							<c:forEach var="prescriptionTestVO" items="${prescriptionTestList.prescriptionTestList}">
								<tr>
									<td>
										<table id="preTest-${prescriptionTestVO.idx}" style="margin-top: 0px; margin-left: 0px; position: relative;">
											<tr>
												<td><img alt="화살표" src="./images/arrow2.png" width="20" />
													&nbsp;&nbsp;</td>
												<td  width="120px;"><fmt:formatDate value="${prescriptionTestVO.writedate}" pattern="a h:mm:ss" /></td>
				
												<td><input type="text" style="width: 370px;" value="${prescriptionTestVO.test}" readonly="readonly" /></td>
												<!-- 직종별 버튼 못쓰게. 의사만 가능 ========================================== -->
												<c:if test="${dpart == '의사'}">
													<td>
														<!-- ajax방식 -->
														<button type="button" class="deletePreTest" data-deletePreTest="${prescriptionTestVO.idx}" 
																id="preTestIdx-${prescriptionTestVO.idx}" data-bs-test="${prescriptionTestVO.test}">
																<%-- onclick="location.href='deleteMediPreTest?idx=${prescriptionTestVO.idx}&patientIdx=${patientIdx}&dDay=${dDay}'"> --%>
															<img alt="삭제" src="./images/x_circle.webp" width="20px">
														</button>
													</td>
												</c:if>
				
												<c:if test="${dpart == '간호사'}">
													<td>
														<button type="button" disabled="disabled">
															<img alt="삭제" src="./images/x_circle.webp" width="20px">
														</button>
													</td>
												</c:if>
				
												<c:if test="${dpart == '병리사'}">
													<td>
														<button type="button" disabled="disabled">
															<img alt="삭제" src="./images/x_circle.webp" width="20px">
														</button>
													</td>
												</c:if>
												<!-- 여기까지  ======================================================   -->
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${prescriptionMedList.prescriptionMedList.size() == 0}">
							<c:if test="${prescriptionTestList.prescriptionTestList.size() == 0}">
								<tr>
									<td>금일 처방내역이 없습니다.</td>
								</tr>
							</c:if>
						</c:if>
					</tbody>
				</table>
			</div>
			<br />
		</div>
		
		
		<div style="width: 800px; border: solid 1px;">
			<table class="table table-borderless">
					<thead>
						<tr>
							<th colspan="3">
								진료기록
							</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${medicalCommentList.medicalCommentList.size() != 0}">
							<c:forEach var="vo" items="${medicalCommentList.medicalCommentList}">
								<c:set var="commentName" value="comment${vo.idx}"></c:set>
									<tr>
										<td><fmt:formatDate value="${vo.writeDate}" pattern="a h:mm:ss" /></td>
										<td width="400px">
											<input style="width: 500px" type="text" value="${vo.recordD}" readonly="readonly" id="${commentName}">
										</td>
										<!-- 직종별 버튼 못쓰게 ========================================== -->
										<c:if test="${dpart == '의사'}">
											<td><input type="checkbox" onchange="commentMediCheck(${commentName})"> 
											<input class="btn btn-outline-info btn-sm" type="button" value="수정" onclick="commentMediUpdate(${commentName}, ${vo.idx}, ${patientIdx}, ${dDay})" />
											<input class="btn btn-outline-danger btn-sm" type="button" value="삭제" onclick="location.href='deleteMediComment?idx=${vo.idx}&patientIdx=${patientIdx}&dDay=${dDay}'" />
											</td>
										</c:if>
		
										<c:if test="${dpart == '간호사'}">
											<td><input type="checkbox" onchange="commentMediCheck(${commentName})" disabled="disabled">
												<input class="btn btn-outline-info btn-sm" type="button" value="수정" disabled="disabled" onclick="commentMediUpdate(${commentName}, ${vo.idx}, ${patientIdx}, ${dDay})" />
												<input class="btn btn-outline-danger btn-sm" type="button" value="삭제" disabled="disabled" onclick="location.href='deleteMediComment?idx=${vo.idx}&patientIdx=${patientIdx}&dDay=${dDay}'" />
											</td>
										</c:if>
			
										<c:if test="${dpart == '병리사'}">
											<td><input type="checkbox" onchange="commentMediCheck(${commentName})" disabled="disabled">
												<input class="btn btn-outline-info btn-sm" type="button" value="수정" disabled="disabled" onclick="commentMediUpdate(${commentName}, ${vo.idx}, ${patientIdx}, ${dDay})" />
												<input class="btn btn-outline-danger btn-sm" type="button" value="삭제" disabled="disabled" onclick="location.href='deleteMediComment?idx=${vo.idx}&patientIdx=${patientIdx}&dDay=${dDay}'" />
											</td>
										</c:if>
										<!-- 여기까지  ======================================================   -->
									</tr>
								</c:forEach>
							</c:if>
						<c:if test="${medicalCommentList.medicalCommentList.size() == 0}">
							<tr>
								<td>진료기록을 입력해주세요.</td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<form action="insertMedical" method="post">
					<table style="width: 800px;">
						<tr>
							<td width="118px;">&nbsp;</td>
							<td>
								&nbsp;&nbsp;<input type="text" style="width: 500px;" name="recordD" />
								<!-- 직종별 버튼 못쓰게 ========================================== -->
								<c:if test="${dpart == '의사'}">
									<button type="submit" id="alarmCom" class="btn btn-info btn-sm">등록</button>
									<!-- 퇴원진료 체크 -->
									<input class="checkDisC" type="checkbox" onchange="checkDisC()" id="alarmDis"><span style="font-size: 14px;">퇴원진료</span> 
								</c:if>
								<c:if test="${dpart == '간호사'}">
									<button type="submit" disabled="disabled" class="btn btn-info btn-sm">등록</button>
									<input class="checkDisC" type="checkbox" onchange="checkDisC()" disabled="disabled"><span style="font-size: 14px;">퇴원진료</span> 
								</c:if>
		
								<c:if test="${dpart == '병리사'}">
									<button type="submit" disabled="disabled" class="btn btn-info btn-sm">등록</button>
									<input class="checkDisC" type="checkbox" onchange="checkDisC()" disabled="disabled"><span style="font-size: 14px;">퇴원진료</span> 
								</c:if>
							</td>
							<!-- 여기까지  ======================================================   -->
						</tr>
					</table>
					<input type="hidden" value="N" name="dischargeC" id="dischargeC">
					<input type="hidden" value="${patientVO.getPatientIdx()}" name="patientIdx" id="patientIdx"> 
					<input type="hidden" value="${patientVO.getName()}" name="name" id="name"> 
					<input type="hidden" value="${employeeIdx}" name="employeeIdx" id="employeeIdx"> 
					<input	type="hidden" value="${employeeName}" name="employeeName" id="employeeName">
					<input type="hidden" value="${dDay}" name="dDay" id="dDay">
				</form>
				<br/>
			</div>
		</div>
	
<!-- footer삽입 -->
<jsp:include page="./header/footer.jsp"></jsp:include>
	
<script type="text/javascript">

// 		약검색 후 다시쓰기 (다시쓰기 방식 변경 전 코드)
		function mediResetf() {

		        $("input[name='dosage']").val("");
		        $("input[name='medicine']").val("");
		        $("input[name='injectTime']").removeAttr("checked");
		        $("input[name='route']").removeAttr("checked");
		}

		function mediNameSearch() {

			 	let medi = document.querySelector('#mediName');
			 	let mediName = medi.value;
			 	location.href='viewMedicalBack.jsp?mediName=' + mediName;
		}

		function commentMediCheck(name) {

			name.removeAttribute("readonly");
			name.focus();
		}

		function commentMediUpdate(comment, nidx, pidx, day) {

			let recordD = comment.value;
			location.href = 'updateMediComment?idx=' + nidx
					+ '&patientIdx=' + pidx + '&recordD=' + recordD + '&dDay='
					+ day;
		}

// 		약물검색 후 처방등록 시, 퇴원약 체크
		function checkDisM() {
			let checkDisM = $(".checkDisM").prop('checked');			
			let disM = document.querySelector('#dischargeM');
			console.log($(".checkDisM").prop('checked'))

			if (checkDisM == true) {
				disM.value = 'Y';
			} else {
				disM.value = 'N';
			}

		}
		
// 		진료기록 등록 시, 퇴원진료 체크
		function checkDisC() {
			let checkDisC = $(".checkDisC").prop('checked');	
			let disC = document.querySelector('#dischargeC');

			if (checkDisC == true) {
				disC.value = 'Y';
			} else {
				disC.value = 'N';
			}
			console.log($(".checkDisC").prop('checked'))

		}

		// 추후 구현 예정임 작업중.
		function checkFirst() {
			// 	let disM = document.querySelector('#dischargeM');
			// 	let disC = document.querySelector('#dischargeC');

			// 	disM.value = 'Y';
			// 	disC.value = 'Y';

			// 	disM.classList.add("clicked_btn");
			// 	disC.classList.add("clicked_btn");

		}
		
		function getContextPath() {
			let hostIndex = location.href.indexOf(location.host) + location.host.length
			let contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1))
			return contextPath
		}	
		
		
		onload = () => {
			
			var root = getContextPath()
			console.log(root)
			
			var patientIdx = $('#patientIdx').val()
			var name = $('#name').val()
			var employeeIdx = $('#employeeIdx').val()
			var dDay = $("#dDay").val()
			var fromName = $('#employeeName').val()
			var fromDP = '의사'
			
			
				{
// 					< 처방내역: 약물 삭제 & 약물처방취소알림 & 실시간알림 >
//					모든 삭제 버튼을 선택해서 click 이벤트를 걸어준다.
					const DeletePreMedBtns = document.querySelectorAll('.deletePreMed');
//					모든 삭제 버튼의 이벤트 처리
					DeletePreMedBtns.forEach(btn => {
						btn.addEventListener('click', event => {
							// 이벤트를 발생시킨 요소(버튼)을 선택한다.
							const DeletePreMedBtn = event.target; // event.target도 같은 기능이 실행된다.
							const triggerBtn = DeletePreMedBtn.parentNode
							const mediNameB = triggerBtn.getAttribute('data-bs-mediAjax');
							const mediName = mediNameB.split(" ")[0];
							let idd = btn.id
							let idx = idd.substring(10);
							var alarmN1 = "약처방(" + mediName + ")취소";
							// fetch Ajax를 이용해서 호출한다.
							const url = root + '/deleteMediPreMed/' + idx;
							console.log(url);

							fetch(url, {
								method: 'GET' // DELETE 요청, 대문자로 
							}).then(response => {
								// 삭제 실패 처리
								if (!response.ok) {
									alert('약물 처방내역 삭제 실패');	
									return;
								}
						        socket.send("의사, N, "+ patientIdx +", "+ name + ", " + alarmN1 + ", " + dDay);
						        
						        alert('약물 처방내역 1개를 삭제하였습니다.')
								alert('To.간호사 약물처방 취소 알림을 발송하였습니다.')
								
								let a = '#preMed-' + idx
								const target = document.querySelector(a);
								// remove() 함수를 사용하면 화면을 새로고침하지 않고 댓글이 삭제된 결과가 표시된다.
								target.remove();
							});
						});
					});
				}

//					< 처방내역 : 검사 삭제>
			{
//				모든 삭제 버튼을 선택해서 click 이벤트를 걸어준다.
				const DeletePreTestBtns = document.querySelectorAll('.deletePreTest');
//				모든 삭제 버튼의 이벤트 처리
				DeletePreTestBtns.forEach(btn => {
					btn.addEventListener('click', event => {
						// 이벤트를 발생시킨 요소(버튼)을 선택한다.
						const DeletePreTestBtn = event.target; // event.target도 같은 기능이 실행된다.
						const triggerBtn = DeletePreTestBtn.parentNode
						const test = triggerBtn.getAttribute('data-bs-test');
						var alarmN2 = test + " 처방 취소";
						let idd = btn.id
						let idx = idd.substring(11);
						// fetch Ajax를 이용해서 호출한다.
						// @RequestMapping("/hospital_final/deleteMediPreTest/{idx}")
						const url = root + '/deleteMediPreTest/' + idx;
						console.log(url);

						fetch(url, {
							method: 'GET' 
						}).then(response => {
							// 삭제 실패 처리
							if (!response.ok) {
								alert('검사 처방내역 삭제 실패');	
								return;
							}
						    socket.send("의사, N, "+ patientIdx +", "+ name + ", " + alarmN2 + ", " + dDay);
							alert(alarmN2 + ' 처방내역 1개를 삭제하였습니다.')
							alert('To.간호사 ' + alarmN2 + ' 처방 취소 알림을 발송하였습니다.')
							
							// 현재 페이지를 새로고침 한다.
							// location.reload();
							// then()으로 왔다면 댓글이 이미 삭제가 된 상태이므로 댓글을 표시한 객체를 화면에서 지운다.
							let a = '#preTest-' + idx
							const target = document.querySelector(a);
							// remove() 함수를 사용하면 화면을 새로고침하지 않고 댓글이 삭제된 결과가 표시된다.
							target.remove();
						});
					});
				});
			}
			
		}
		// 약물처방 알림 ajax 
			$('#noticeToNforMed').click(function(e) {

	 			let patientIdxM = $('#patientIdx').val()
	 			let nameM = $('#name').val()
	 			let employeeIdxM = $('#employeeIdx').val()
	 			let dDayM = $("#dDay").val()
	 			let fromNameM = $('#employeeName').val()
	 			let fromDPM = '의사'
				let alarmN3 = '약물처방'
				
				root = getContextPath()
			    // 전송한 정보를 db에 저장	
			    $.ajax({
			        type: 'post',
			        url: root + '/insertNoticeToNForMedAjax',
			        dataType: 'text',
			        data: {
			        	patientIdx: patientIdxM,
			        	name: nameM,
			        	alarmN: alarmN3,
			        	fromDP: fromDPM,
			        	employeeIdx: employeeIdxM,
			        	fromName: fromNameM
			        },
			        success: function(data){    // db전송 성공시 실시간 알림 전송
			            // 소켓에 전달되는 메시지
			            socket.send("의사, N, "+ patientIdxM +", "+ nameM + ", " + alarmN3 + ", " + dDayM);
			        	alert(' To.간호사  ' + nameM + '님의 ' + alarmN3 + '알림이 발송되었습니다.');
			            console.log(data)
			        }
			    });
				
			});
		
		// 검사처방 알림 ajax 
			$('#noticeTestAjax').click(function(e) {

	 			let patientIdxT = $('#patientIdx').val()
	 			let nameT = $('#name').val()
	 			let employeeIdxT = $('#employeeIdx').val()
	 			let dDayT = $("#dDay").val()
	 			let fromNameT = $('#employeeName').val()
	 			let fromDPT = '의사'
	 			
	 			let blood = document.querySelector('#blood')
	 			let urine = document.querySelector('#urine')
	 			let alarmN4 = null;
	 			
	 			if (blood.checked) {
	 				alarmN4 = "혈액검사처방"
	 			} else if(urine.checked) {
	 				alarmN4 = "소변검사처방"
	 			} else {
	 			}
				root = getContextPath()
			    // 전송한 정보를 db에 저장	
			    $.ajax({
			        type: 'post',
			        url: root + '/insertNoticeToNForTestAjax',
			        dataType: 'text',
			        data: {
			        	patientIdx: patientIdxT,
			        	name: nameT,
			        	alarmN: alarmN4,
			        	fromDP: fromDPT,
			        	employeeIdx: employeeIdxT,
			        	fromName: fromNameT
			        },
			        success: function(data){    // db전송 성공시 실시간 알림 전송
			            // 소켓에 전달되는 메시지
			            socket.send("의사, N, "+ patientIdxT +", "+ nameT + ", " + alarmN4 + ", " + dDayT);
			        	alert(' To.간호사  ' + nameT + '님의 ' + alarmN4 + ' 알림이 발송되었습니다.');
			            console.log(data)
			        }
			    });
				
			});
		
		// 퇴원수속 알림 ajax 
			$('#alarmCom').click(function(e) {

				let dis = document.querySelector("#alarmDis")
	 			let patientIdxC = $('#patientIdx').val()
	 			let nameC = $('#name').val()
	 			let employeeIdxC = $('#employeeIdx').val()
	 			let dDayC = $("#dDay").val()
	 			let fromNameC = $('#employeeName').val()
	 			let fromDPC = '의사'
	 			let alarmN5 = null;
	 			
	 			if (dis.checked) {
	 				alarmN5 = "퇴원수속"
	 			} else {
	 				return
	 			}
				root = getContextPath()
			    // 전송한 정보를 db에 저장	
			    $.ajax({
			        type: 'post',
			        url: root + '/insertNoticeToNForDisAjax',
			        dataType: 'text',
			        data: {
			        	patientIdx: patientIdxC,
			        	name: nameC,
			        	alarmN: alarmN5,
			        	fromDP: fromDPC,
			        	employeeIdx: employeeIdxC,
			        	fromName: fromNameC
			        },
			        success: function(data){    // db전송 성공시 실시간 알림 전송
			            // 소켓에 전달되는 메시지
			            socket.send("의사, N, "+ patientIdxC +", "+ nameC + ", " + alarmN5 + ", " + dDayC);
			        	alert('퇴원진료기록 등록완료. \n To.간호사 ' + nameC + '님의 ' + alarmN5 + ' 알림이 발송되었습니다.');
			            console.log(data)
			        }
			    });
				
			});
		
		
	</script>




</body>
</html>