package com.hospital.mybatis;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import com.hospital.vo.Dpart_23List;
import com.hospital.vo.Dpart_23VO;
import com.hospital.vo.Employee_20List;
import com.hospital.vo.Employee_20VO;
import com.hospital.vo.HandoverD_3VO;
import com.hospital.vo.HandoverN_9VO;
import com.hospital.vo.Injection_11VO;
import com.hospital.vo.MedicalComment_7VO;
import com.hospital.vo.Medicine_22VO;
import com.hospital.vo.NoticeToA_18VO;
import com.hospital.vo.NoticeToD_2VO;
import com.hospital.vo.NoticeToN_8VO;
import com.hospital.vo.NoticeToP_14VO;
import com.hospital.vo.NursingComment_13VO;
import com.hospital.vo.Patient_1List_All;
import com.hospital.vo.Patient_1List_Item;
import com.hospital.vo.Patient_1VO;
import com.hospital.vo.PrescriptionMed_4VO;
import com.hospital.vo.PrescriptionTest_5VO;
import com.hospital.vo.ScheduleN_d_24VO;
import com.hospital.vo.ScheduleN_e_25VO;
import com.hospital.vo.ScheduleN_n_26VO;
import com.hospital.vo.TestBlood_17VO;
import com.hospital.vo.TestUrine_21VO;
import com.hospital.vo.VitalSign_10VO;
import com.hospital.vo.WorkMemoA_19VO;
import com.hospital.vo.WorkMemoP_15VO;

public interface MyBatisDAO {
	
//	혈액검사 저장
	void insertTestBlood(TestBlood_17VO testBloodVO);
	
//	혈액검사 저장 중에 해당 환자의 최근 검사 idx구하기
	TestBlood_17VO selectBloodTestIdx(int patientIdx);
	
//	소변 검사 저장
	void insertTestUrine(TestUrine_21VO testUrineVO);
	
//	소변검사 저장 중에 해당 환자의 최근 검사 idx구하기
	TestUrine_21VO selectUrineTestIdx(int patienIdx);	
	
//	환자 정보 꺼내기
	Patient_1VO selectPatient(int patientIdx);
//	환자 정보 수정
	void updatePatientDetail(Patient_1VO patientVO);
//	의사에게 알람보내기
	void insertNoticeToD(NoticeToD_2VO noticeToDVO);
//	간호사에게 알람보내기
	void insertNoticeToN(NoticeToN_8VO noticeToNVO);
//	소변검사 목록 꺼내기
	ArrayList<TestUrine_21VO> selectUrineTest(int patientIdx);
//	혈액검사 목록 꺼내기
	ArrayList<TestBlood_17VO> selectBloodTest(int patientIdx);
//	초진 
	void updatePatient(Patient_1VO patientVO);
//	직원 정보 꺼내기
	Employee_20VO selectByEmployeeIdx(int parseInt);

	
//	신환등록
	void insertPatient(Patient_1VO patientVO);
//	임시 환자번호 받기
	int selectnewPatientIdx();
//	팀별 담당 환자수
	int countDT(String string);
	int countNT(String string);
	
	
	// 사원조회
	ArrayList<Employee_20VO> selectEmployeeListByName(String item);
	ArrayList<Dpart_23VO> selectdpartListByName(String item);


	//	간호사 다오
	ArrayList<VitalSign_10VO> selectVitalSignList(int patientIdx);
	ArrayList<Injection_11VO> selectInjectionList(int patientIdx);
	ArrayList<NursingComment_13VO> selectNursingCommentList(int patientIdx);
	void insertVital(VitalSign_10VO vitalSign_10VO);
	void insertNoticeToP(NoticeToP_14VO noticeToP_14VO);
	void insertNursingComment(NursingComment_13VO nursingComment_13VO);
	void updateInjection9Y(int idx);
	void updateInjection9N(int idx);
	void updateInjection13Y(int idx);
	void updateInjection13N(int idx);
	void updateInjection18Y(int idx);
	void updateInjection18N(int idx);
	void updateInjection21Y(int idx);
	void updateInjection21N(int idx);
	void updateNursingComment(NursingComment_13VO nursingComment_13VO);
	void deleteNursingComment(int idx);
	void deleteNursingVital(int idx);
	void insertNoticeToDFromN(NoticeToD_2VO noticeToD_2VO);
	ArrayList<PrescriptionMed_4VO> selectPrescriptionMedList(int patientIdx);
	void insertNoticeToA(NoticeToA_18VO noticeToA_18VO);

	/* 의사 */
	ArrayList<PrescriptionTest_5VO> selectPrescriptionTestList(int patientIdx);
	ArrayList<MedicalComment_7VO> selectMediCommentList(int patientIdx);
	ArrayList<Medicine_22VO> selectMedicineListByName(String trim);
	Medicine_22VO selectMedicineByCode(String code);
	void insertMediPreMed(PrescriptionMed_4VO prescriptionMed_4VO);
	void insertNoticeToNFromD(NoticeToN_8VO noticeToN_8VO);
	void insertMediComment(MedicalComment_7VO medicalComment_7VO);
	void insertMediPreTest(PrescriptionTest_5VO prescriptionTest_5VO);
	void insertInjection(PrescriptionMed_4VO prescriptionMed_4VO);
	void updateMediComment(MedicalComment_7VO medicalComment_7VO);
	void deleteMediComment(int idx);
	void deleteMediPreMed(int idx);
	void deleteMediPreTest(int idx);
	
//	처방내역 삭제 아작스 코드 
	// 처방 약물 1개 꺼내오기
	PrescriptionMed_4VO selectPrescriptionMedOne(int idx);
	// 처방 검사 1개 꺼내오기
	PrescriptionTest_5VO selectPrescriptionTestOne(int idx);
	

	//퇴원환자 검색
	ArrayList<Patient_1VO> selectPatientList_pIdx(int pIdx);
	ArrayList<Patient_1VO> selectPatientList_pName(String pName);
	ArrayList<Patient_1VO> selectPatientList_pDisDate(Date date);
	ArrayList<PrescriptionTest_5VO> selectPrescriptionTest(int patientIdx);
	
	// 퇴원환자조회 페이징
	int selectCountPatientList_pIdx(int pIdx);
	int selectCountPatientList_pName(String pName);
	int selectCountPatientList_pDisDate(Date date);
	ArrayList<Patient_1VO> selectPatientList_pIdxForPaging(Patient_1List_Item patient_1List_Item);
	ArrayList<Patient_1VO> selectPatientList_pNameForPaging(Patient_1List_Item patient_1List_Item);
	ArrayList<Patient_1VO> selectPatientList_pDisDateForPaging(Patient_1List_Item patient_1List_Item);
	
	// 퇴원환자검색 - 간호기록조회 
	ArrayList<VitalSign_10VO> selectVitalSignList_Menu(HashMap<String, Integer> hmap);
	ArrayList<Injection_11VO> selectInjectionList_Menu(HashMap<String, Integer> hmap);
	ArrayList<NursingComment_13VO> selectNursingCommentList_Menu(HashMap<String, Integer> hmap);


	
	//	퇴원 환자 계산
	int selectPreTestBCount(int patientIdx);
	int selectPreTestPCount(int patientIdx);
	int selectPrescriptionMed(int patientIdx);
	int selectMedicalComment(int patientIdx);
	
	//퇴원 환자 수납
	void updatePatientDischarge(int patientIdx);
	ArrayList<PrescriptionMed_4VO> selectPrescriptionMedList_Menu(HashMap<String, Integer> hmap);
	ArrayList<PrescriptionTest_5VO> selectPrescriptionTestList_Menu(HashMap<String, Integer> hmap);
	ArrayList<MedicalComment_7VO> selectMediCommentList_Menu(HashMap<String, Integer> hmap);
	
	// 회원가입
	void employeeinsert(Employee_20VO employeeVO);

	
	// 원무과 메인
	ArrayList<NoticeToA_18VO> selectNoticeToAList();
	ArrayList<WorkMemoA_19VO> selectmemoList();
	ArrayList<Patient_1VO> selectPatientList_All();
	void workmemoinsert(WorkMemoA_19VO workmemoavo);
	void deletememo(int idx);
	void updatememo(WorkMemoA_19VO workmemoavo);
	
	// 병리사 메인
	ArrayList<NoticeToP_14VO> selectNoticeToPList();
	ArrayList<WorkMemoP_15VO> selectmemoPList();
	void workmemoPinsert(WorkMemoP_15VO workmemopvo);
	void deletePmemo(int idx);
	void updatePmemo(WorkMemoP_15VO workmemopvo);

	// 의사 메인
	ArrayList<NoticeToD_2VO> selectNoticeToDList(String doctorT);
	ArrayList<HandoverD_3VO> selectHandoverDList(String doctorT);
	void insertHandoverD_new(HandoverD_3VO handoverDVO);
	void insertHandoverD_reply(HandoverD_3VO handoverDVO);
	void deletehandover(int idx);
	void updatehandover(HandoverD_3VO handoverDVO);
	//	담당환자 목록
	ArrayList<Patient_1VO> selectPatientList_Doctor(String doctorT);
	
	// 간호사 메인
	ArrayList<NoticeToN_8VO> selectNoticeToNList(String nurseT);
	ArrayList<HandoverN_9VO> selectHandoverNList(String nurseT);
	void insertHandoverN_new(HandoverN_9VO handoverNVO);
	void insertHandoverN_reply(HandoverN_9VO handoverNVO);
	void deleteNhandover(int idx);
	void updateNhandover(HandoverN_9VO handoverNVO);
	ArrayList<Patient_1VO> selectPatientList_Nurse(String nurseT);
	
	
	
// < 마이페이지 >
	
	// 프로필사진 업로드 (사진과 내용을 한번에 수정하게 되면서 불필요해진메소드)
	void updateEmployeeImg(Employee_20VO employee_20vo);
	// 프로필사진 보여주기(orgFileName 꺼내오기) 
	String selectEmployeeImg(int employeeIdx);
	// 나의 정보 (사원 꺼내오기)
	Employee_20VO selectEmployee(int employeeIdx);
	// 나의 정보 수정 (여기서 사진까지 다 업로드 되게 함) 
	void updateEmployee(Employee_20VO employee_20vo);
	
	
//	<사내검색>
	int selectCountEmpListByName(String item);
	ArrayList<Employee_20VO> selectEmpListByNameForPaging(Employee_20List employeeList);
	int selectCountDpartListByName(String item);
	ArrayList<Dpart_23VO> selectDpartListByNameForPaging(Dpart_23List dpartList);
	
	//	퇴원환자 검사 리스트 
	int countTestBloodList(int patientIdx);
	int countTestUrineList(int patientIdx);
	
	
// < 관리자 페이지 > -> employee.xml	
	int selectCountEmployeeDpart(String set);
	ArrayList<Employee_20VO> selectEmployeeDpart(String set);
	ArrayList<Employee_20VO> selectSignDpartForPaging(Employee_20List employeeList);
	ArrayList<Employee_20VO> selectSignForPaging(Employee_20List employeeList);
	Employee_20VO moveTeam(int employeeIdx);
	void deleteEmployee(int employeeIdx);
	Employee_20VO selectEmployeeSign();
	ArrayList<Employee_20VO> selectSign();
	int selectCountSign();
	void updateSign(int employeeIdx);
	void moveTeamD(Employee_20VO employee_20vo);
	void moveTeamN(Employee_20VO employee_20vo);
	void updateAdmin(Employee_20VO employee_20vo);
	void updateAdminDoc(Employee_20VO employee_20vo);
	void updateAdminNur(Employee_20VO employee_20vo);
	
	
	// < 팀 스케줄 >
	
	// 팀별 사원목록꺼내오기 (의사팀)
	ArrayList<Employee_20VO> selectEmpListByDTeam(String team);
	// 팀별 사원목록꺼내오기 (간호사팀)
	ArrayList<Employee_20VO> selectEmpListByNTeam(String team);
	// 부서별 사원목록 
	ArrayList<Employee_20VO> selectEmpListBydpart(String dpart);
	
	// 과장 팀장 제외한 팀별 사원목록꺼내오기 (의사팀)
	ArrayList<Employee_20VO> selectEmpListByDTeamNotAdmin(String team);
	// 과장 팀장 제외한 팀별 사원목록꺼내오기 (간호사팀)
	ArrayList<Employee_20VO> selectEmpListByNTeamNotAdmin(String team);
	
	// 간호사 팀별 월스케줄 꺼내오기 (데이/이브닝/나이트)
	ScheduleN_d_24VO selectScheduleNDay(String idx);  // idx : YYMMT (연도-월-팀명)
	ScheduleN_e_25VO selectScheduleNEven(String idx);
	ScheduleN_n_26VO selectScheduleNNig(String idx);
	
	// 간호사 팀별 월스케줄 등록하기
	void insertTeamCalendarNDay(ScheduleN_d_24VO scheduleN_d_24VO);
	void insertTeamCalendarNEven(ScheduleN_e_25VO scheduleN_e_25VO);
	void insertTeamCalendarNNig(ScheduleN_n_26VO scheduleN_n_26VO);
	
	// 간호사 팀별 월스케줄 수정하기
	void updateTeamCalendarNDay(ScheduleN_d_24VO scheduleN_d_24VO);
	void updateTeamCalendarNEven(ScheduleN_e_25VO scheduleN_e_25VO);
	void updateTeamCalendarNNig(ScheduleN_n_26VO scheduleN_n_26VO);
	
	
	
// 채팅초대	
	
	// 해당 팀 환자중 최근환자 아무나 꺼내오기
	Patient_1VO selectRecentPatientByNTeam(String nurseT);
	Patient_1VO selectRecentPatientByDTeam(String doctorT);





	

	
	
	


}
