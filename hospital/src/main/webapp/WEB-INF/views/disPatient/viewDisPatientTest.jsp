<%@page import="com.hospital.vo.TestBlood_17List"%>
<%@page import="com.hospital.vo.TestUrine_21List"%>
<%@page import="com.hospital.vo.TestBlood_17VO"%>
<%@page import="com.hospital.vo.Patient_1VO"%>
<%@page import="com.hospital.vo.TestUrine_21VO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퇴원환자 검사결과조회</title>
</head>
<body>
<!-- header 페이지 삽입  -->
<jsp:include page="../header/header_goback_DisPatient.jsp"></jsp:include>

<div style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 20px; border: solid 1px; padding: 10px;">

	<fmt:formatDate var= "adDate" value="${patientVO.getAdDate()}" pattern="yyyy.MM.dd(E)"/>
	<fmt:formatDate var= "DisDate" value="${patientVO.getDisDate()}" pattern="yyyy.MM.dd(E)"/>


	<div style="margin-top: 20px; margin-left: 20px;">
		<form action="viewDisPatientTestMiddle">
			<!-- 혈액검사 결과 보는 중에는 체크 상태 유지 -->
			<c:if test="${viewTestList.test == 'blood' || viewTestList.test == null}">
				<label for="blood">
					<input type="radio" name="test" id="blood" value="blood" checked="checked"/>혈액검사
				</label>
				<label for="urine">
					<input type="radio" name="test" id="urine" value="urine"/>소변검사
				</label>
			</c:if>
			<!-- 소변검사 결과 보는 중에는 체크 상태 유지 -->
			<c:if test="${viewTestList.test == 'urine'}">
				<label for="blood">
					<input type="radio" name="test" id="blood" value="blood"/>혈액검사
				</label>
				<label for="urine">
					<input type="radio" name="test" id="urine" value="urine" checked="checked"/>소변검사
				</label>
			</c:if>
			&nbsp;&nbsp;
			<input type="hidden" id="patientIdx" name="patientIdx" value="${patientVO.getPatientIdx()}">
			<input type="submit" value="조회">
		</form>
	</div>
	<hr/>
<!-- 환자정보 (환자Tag) -->
	<div style="width: 700px; border: solid 1px; margin-top: 30px; margin-left: 80px; position: relative;" align="center">
		${patientVO.getPatientIdx()}&nbsp;&nbsp;${patientVO.getName()}&nbsp;&nbsp;${patientVO.getAge()}/${patientVO.getGender()}&nbsp;&nbsp;${patientVO.getDiagnosis()}   
		&nbsp;&nbsp;입원일 : ${adDate} &nbsp;&nbsp;퇴원일 : ${DisDate}<br/>
	</div> <br/>
	<c:if test="${viewTestList.test == 'blood'}">
	
	
	<c:if test="${viewTestList.testBloodList.size() == 0}">
		<div style="width: 900px; border: solid 1px; padding: 10px; margin: 20px; position: relative;">
							혈액검사 결과 데이터가 없습니다.
		</div>
	</c:if>
					
	<c:if test="${viewTestList.testBloodList.size() != 0}">
	
		<c:forEach var="testBloodVo" items="${viewTestList.testBloodList}">
		
			<div style="width: 900px; border: solid 1px; padding: 10px; margin: 20px; position: relative;">
			
			
					검사보고일 : <fmt:formatDate value="${testBloodVo.writeDate}" pattern="yyyy.MM.dd(E)"/> 		
				
				<!-- 결과 테이블로 수정하기 -->
				<div style="width: 400px; border: solid 1px; margin-top: 30px; margin-left: 30px; margin-bottom:30px; position: relative;">
						<table class="table">
							<thead>
								<tr class="table-success">
									<th colspan="2"  width="150px;">
										혈액검사 결과
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>
										WBC
									</th>
									<td>
										${testBloodVo.WBC}&nbsp;&nbsp;&nbsp;mm<sup>3</sup>
									</td>
								</tr>
								<tr>
									<th>
										Hb 
									</th>
									<td>
										${testBloodVo.hb}&nbsp;&nbsp;&nbsp;g/dl
									</td>
								</tr>
								<tr>
									<th>
										Hct 
									</th>
									<td>
										${testBloodVo.hct}&nbsp;&nbsp;&nbsp;%
									</td>
								</tr>
								<tr>
									<th>
										RBC 
									</th>
									<td>
										${testBloodVo.RBC}&nbsp;&nbsp;&nbsp;mm3
									</td>
								</tr>
								<tr>
									<th>
										MCV 
									</th>
									<td>
										${testBloodVo.MCV}&nbsp;&nbsp;&nbsp;fl
									</td>
								</tr>
								<tr>
									<th>
										MCH 
									</th>
									<td>
										${testBloodVo.MCH}&nbsp;&nbsp;&nbsp;pg
									</td>
								</tr>
								<tr>
									<th>
										MCHC 
									</th>
									<td>
										${testBloodVo.MCHC}&nbsp;&nbsp;&nbsp;g/dl
									</td>
								</tr>
								<tr>
									<th>
										Platelet 
									</th>
									<td>
										${testBloodVo.platelet}&nbsp;&nbsp;&nbsp;mm<sup>3</sup>
									</td>
								</tr>
							</tbody>
						</table>
								
					</div>
			</div>
		</c:forEach>
	
	<div style="position: relative; left: 330px; margin-top: 50px; margin-bottom: 20px">
		<table>
			<!-- 페이지 이동 버튼 -->
			<tr>
				<td align="center">
					<!-- 처음으로 -->
					<c:if test="${viewTestList.currentPage > 1}">
						<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
								onclick="location.href='?currentPage=1&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">처음</button>
					</c:if>
					
					<c:if test="${viewTestList.currentPage <= 1}">
						<button class="button button2" type="button" title="이미 첫 페이지 입니다." 
								disabled="disabled">처음</button>
					</c:if>
					
					<!-- 5페이지 앞으로 -->
					<c:if test="${viewTestList.startPage > 1}">
						<button class="button button1" type="button" title="이전 5 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${viewTestList.startPage - 1}&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">
							이전
						</button>
					</c:if>
					
					<c:if test="${viewTestList.startPage <= 1}">
						<button class="button button2" type="button" title="이미 첫 5 페이지 입니다." 
								disabled="disabled">이전</button>
					</c:if>
	
					<!-- 페이지 이동 -->
					<c:forEach var="i" begin="${viewTestList.startPage}" end="${viewTestList.endPage}" step="1">
					
						<c:if test="${viewTestList.currentPage == i}">
							<button class="button button2" type="button" disabled="disabled">${i}</button>
						</c:if>
						
						<c:if test="${viewTestList.currentPage != i}">
							<button class="button button1" type="button" onclick="location.href='viewDisPatientTestMiddle?currentPage=${i}&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">
								${i}
							</button>
						</c:if>
					
					</c:forEach>
	
					<!-- 5페이지 뒤로 -->
					<c:if test="${viewTestList.endPage < viewTestList.totalPage}">
						<button class="button button1" type="button" title="다음 5 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${viewTestList.endPage + 1}&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">다음</button>
					</c:if>
					
					<c:if test="${viewTestList.endPage >= viewTestList.totalPage}">
						<button class="button button2" type="button" title="이미 마지막 5 페이지 입니다." 
								disabled="disabled">다음</button>
					</c:if>
					
					<!-- 마지막으로 -->
					<c:if test="${viewTestList.currentPage < viewTestList.totalPage}">
						<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
								onclick="location.href='?currentPage=${viewTestList.totalPage}&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">마지막</button>
					</c:if>
					
					<c:if test="${viewTestList.currentPage >= viewTestList.totalPage}">
						<button class="button button2" type="button" title="이미 마지막 페이지 입니다." disabled="disabled">
							마지막
						</button>
					</c:if>
				
				</td>
			</tr>
			
		</table>
	
	
	</div>
	
	</c:if>
	</c:if>
<!-- ============================================퇴원환자 혈액검사 조회================================================================================================ -->
<c:if test="${viewTestList.test == 'urine'}">
	<c:if test="${viewTestList.testUrineList.size() == 0}">
	
		<div style="width: 900px; border: solid 1px; padding: 10px; margin: 20px; position: relative;">
							소변검사 결과 데이터가 없습니다.
		</div>
		
		</c:if>
						
		<c:if test="${viewTestList.testUrineList.size() != 0}">
		
		<c:forEach var="testUrinVo" items="${viewTestList.testUrineList}">
		
			<div style="width: 900px; border: solid 1px; padding: 10px; margin: 20px; position: relative;">
				 <br/>
				검사보고일 : <fmt:formatDate value="${testUrinVo.writeDate}" pattern="yyyy.MM.dd(E)"/> 		
				
				<div style="width: 400px; border: solid 1px; margin-top: 30px; margin-left: 30px; margin-bottom:30px; position: relative;">
					<table class="table">
						<thead>
							<tr class="table-success">
								<th colspan="2">
									소변검사 결과
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th  width="180px;">
									색깔
								</th>
								<td>
									${testUrinVo.color}
								</td>
							</tr>
							<tr>
								<th>
									혼탁도
								</th>
								<td>
									${testUrinVo.turbidity}
								</td>
							</tr>
							<tr>
								<th>
									비중
								</th>
								<td>
									${testUrinVo.gravity}
								</td>
							</tr>
							<tr>
								<th>
									산도
								</th>
								<td>
									 ${testUrinVo.acidity}
								</td>
							</tr>
							<tr>
								<th>
									알부민
								</th>
								<td>
									${testUrinVo.albumin}
								</td>
							</tr>
							<tr>
								<th>
									포도당
								</th>
								<td>
									${testUrinVo.glucose}
								</td>
							</tr>
							<tr>
								<th>
									케톤
								</th>
								<td>
									 ${testUrinVo.ketones}
								</td>
							</tr>
							<tr>
								<th>
									빌리루빈
								</th>
								<td>
									${testUrinVo.bilirubin}
								</td>
							</tr>
							<tr>
								<th>
									잠혈
								</th>
								<td>
									${testUrinVo.blood}
								</td>
							</tr>
							<tr>
								<th>
									유로빌리노겐
								</th>
								<td>
									 ${testUrinVo.bilinogen}
								</td>
							</tr>
							<tr>
								<th>
									유로빌리노겐
								</th>
								<td>
									 ${testUrinVo.bilinogen}
								</td>
							</tr>
							<tr>
								<th>
									나이트리트
								</th>
								<td>
									 ${testUrinVo.nitrite}
								</td>
							</tr>
							<tr>
								<th>백혈구
								</th>
								<td>
									 ${testUrinVo.leukocyte}
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</c:forEach>
		
		<div style="position: relative; left: 330px; margin-top: 50px; margin-bottom: 20px">
			<table>
				<!-- 페이지 이동 버튼 -->
				<tr>
					<td align="center">
					
						<!-- 처음으로 -->
						<c:if test="${viewTestList.currentPage > 1}">
							<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
									onclick="location.href='?currentPage=1&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">처음</button>
						</c:if>
						
						<c:if test="${viewTestList.currentPage <= 1}">
							<button class="button button2" type="button" title="이미 첫 페이지 입니다." 
									disabled="disabled">처음</button>
						</c:if>
						
						<!-- 5페이지 앞으로 -->
						<c:if test="${viewTestList.startPage > 1}">
							<button class="button button1" type="button" title="이전 5 페이지로 이동합니다." 
									onclick="location.href='?currentPage=${testUrineList.startPage - 1}&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">
								이전
							</button>
						</c:if>
						
						<c:if test="${viewTestList.startPage <= 1}">
							<button class="button button2" type="button" title="이미 첫 5 페이지 입니다." 
									disabled="disabled">이전</button>
						</c:if>
		
						<!-- 페이지 이동 -->
						<c:forEach var="i" begin="${viewTestList.startPage}" end="${viewTestList.endPage}" step="1">
						
							<c:if test="${viewTestList.currentPage == i}">
								<button class="button button2" type="button" disabled="disabled">${i}</button>
							</c:if>
							
							<c:if test="${viewTestList.currentPage != i}">
								<button class="button button1" type="button" onclick="location.href='?currentPage=${i}&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">
									${i}
								</button>
							</c:if>
						
						</c:forEach>
		
						<!-- 5페이지 뒤로 -->
						<c:if test="${viewTestList.endPage < viewTestList.totalPage}">
							<button class="button button1" type="button" title="다음 5 페이지로 이동합니다." 
									onclick="location.href='?currentPage=${testUrineList.endPage + 1}&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">다음</button>
						</c:if>
						
						<c:if test="${viewTestList.endPage >= viewTestList.totalPage}">
							<button class="button button2" type="button" title="이미 마지막 5 페이지 입니다." 
									disabled="disabled">다음</button>
						</c:if>
						
						<!-- 마지막으로 -->
						<c:if test="${viewTestList.currentPage < viewTestList.totalPage}">
							<button class="button button1" type="button" title="첫 페이지로 이동합니다." 
									onclick="location.href='?currentPage=${viewTestList.totalPage}&patientIdx=${patientIdx}&dDay=${dDay}&test=${viewTestList.test}'">마지막</button>
						</c:if>
						
						<c:if test="${viewTestList.currentPage >= viewTestList.totalPage}">
							<button class="button button2" type="button" title="이미 마지막 페이지 입니다." disabled="disabled">
								마지막
							</button>
						</c:if>
					</td>
				</tr>
			</table>
		</div>
	</c:if>
</c:if>



					
</div>

<!-- footer삽입 -->
<jsp:include page="../header/footer.jsp"></jsp:include>
</body>
</html>
