<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	String customerId = request.getParameter("customer_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/updateCustomerPwAction.jsp" method="post">
	<table border="1">
		<thead>
			<tr>
				<td>회원ID</td>
				<td>비밀번호 수정</td>
			</tr>
		</thead>
		
	<tbody>
	<tr>
		<td><input type="text" name="customer_id" value="<%=request.getParameter("customer_id")%>" readonly></td>
		<td><input type="password" name="customer_pw"></td>
	</tr>
	</tbody>
	</table>
	
	<button type="submit">비밀번호 수정하기</button>
	</form>
	
</body>
</html>