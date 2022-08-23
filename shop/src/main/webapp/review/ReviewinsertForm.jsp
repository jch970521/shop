<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="service.GoodsService"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("id") == null ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}// 정보가 맞지않으면 로그인폼으로
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h2> 리뷰 작성하기 </h2>
			<form action="<%=request.getContextPath()%>/review/ReviewinsertAction.jsp">
			<textarea rows="5" cols="80" name="review_content"></textarea>
			<br>
			<button type="submit">리뷰 작성</button>
			</form>
	</div>

<a href="<%=request.getContextPath()%>/OrdersList.jsp">돌아가기</a>

</body>
</html>