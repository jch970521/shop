<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="service.GoodsService"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
		request.setCharacterEncoding("UTF-8");
		
		if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee")) &&session.getAttribute("active")=="Y"){
			response.sendRedirect(request.getContextPath() + "/admin.index.jsp");
			return;
		}// 정보가 맞지않으면 admin.index로
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/Board/insertBoardAction.jsp" method="post">
	<table border="1">
		<tr>
			<td>제목</td>
			<td><input type="text" name="board_title"></td>
		</tr>
		<tr>
			<td>ID</td>
			<td><input type="text" name="board_writer" value="<%=session.getAttribute("id")%>" readonly></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows="5" cols="80" name="board_content"></textarea></td>
		</tr>
	</table>
	<button type="submit"> 글 작성 </button>
	<a href="<%=request.getContextPath()%>/Board/EmployeeBoardList.jsp">돌아가기</a>	
</form>
</body>
</html>