<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="service.GoodsService"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}// 정보가 맞지않으면 loginform으로

	int noticeNo = Integer.parseInt(request.getParameter("notice_no"));
	NoticeService service = new NoticeService();
	Notice notice = service.getNoticeOne(noticeNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<body>
	<table border="1">
		<tr>
			<td>번호</td>
			<td><%=notice.getNoticeNo()%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=notice.getNoticeTitle()%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=notice.getNoticeContent()%></td>
		</tr>
		<tr>
			<td>수정날짜</td>
			<td><%=notice.getUpdateDate()%></td>
		</tr>
		<tr>
			<td>작성날짜</td>
			<td><%=notice.getCreateDate()%></td>
		</tr>
	</table>
	
<!-- 접속한 session을 판단해서 고객 / 관리자 나누기  -->
<%
if(session.getAttribute("user").equals("Employee")){
%>
<form action="<%=request.getContextPath()%>/Board/updatNoticeForm.jsp?notice_no=<%=notice.getNoticeNo()%>" method="post">
<button type="submit">수정하기</button>
</form>
<a href="<%=request.getContextPath()%>/Board/EmployeeBoardList.jsp">돌아가기</a>
<% 
}else{
%>
<a href="<%=request.getContextPath()%>/Board/BoardList.jsp">돌아가기</a>
<%
}
%>	
</body>
</html>