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
		
		int boardNo = Integer.parseInt(request.getParameter("board_no"));
		BoardService service = new BoardService();
		Board board = service.getBoardOne(boardNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<td>번호</td>
			<td><%=board.getBoardNo()%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=board.getBoardTitle()%></td>
		</tr>
		<tr>
			<td>ID</td>
			<td><%=board.getBoardWriter()%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=board.getBoardContent()%></td>
		</tr>
		<tr>
			<td>작성날짜</td>
			<td><%=board.getCreateDate()%></td>
		</tr>
	</table>
<div>
<form action="<%=request.getContextPath()%>/Board/updateBoardForm.jsp?board_no=<%=board.getBoardNo()%>" method="post">
	<button type="submit">글 수정하기</button>
</form>

</div>
<a href="<%=request.getContextPath()%>/Board/EmployeeBoardList.jsp">돌아가기</a>

</body>
</html>