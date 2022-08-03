<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	Employee loginEmployee = (Employee)session.getAttribute("loginEmployee");

	CustomerDao customerDao = new CustomerDao();
	EmployeeDao employeeDao = new EmployeeDao();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%=session.getAttribute("user")%> <!-- user는 고객(customer) or 스태프(employee) 의 정보 -->
	<br>
	<%=session.getAttribute("id")%>	<!--  로그인 아이디-->
	<br>
	<%=session.getAttribute("name") %> <!--  로그인 이름 -->
	<br>
	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
</body>
</html>