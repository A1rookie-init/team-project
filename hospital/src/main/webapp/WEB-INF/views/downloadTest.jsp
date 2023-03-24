<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검사지 다운로드</title>
</head>
<body>

<%

// 모달 창으로 변경하면서 쓰지 않는 뷰페이지이지만 학습용으로 남겨둠.

	String uploadDirectory = "C:" + File.separator + "Upload" + File.separator + "testfile" + File.separator + "excelfile" + File.separator;
	String[] files = new File(uploadDirectory).list();
	int i = 0;
	for (String file : files) {
%>
	<%=++i%>.															
	<a href="downloadTestAction?file=<%=URLEncoder.encode(file, "UTF-8")%>&patientIdx=${patientIdx}&dDay=${dDay}">
		<%=file%>
	</a><br/>
<%
	}
%>

</body>
</html>