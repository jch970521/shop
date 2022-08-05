<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%

	Employee loginEmployee = (Employee)session.getAttribute("loginEmployee");
	
	EmployeeDao employeeDao = new EmployeeDao();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div>
<form>
<fieldset>
<table class="table table-dark">
	<tr>
	<td>유저 정보</td>
	<td><%=session.getAttribute("user")%> <!-- user는 고객(customer) or 스태프(employee) 의 정보 --></td>
	</tr>
	
	<tr>
	<td>유저 ID</td>
	<td><%=session.getAttribute("id")%>	<!--  로그인 아이디--></td>
	</tr>
	
	<tr>
	<td>유저 name</td>
	<td><input type="hidden" <%=session.getAttribute("active") %>>
	<%=session.getAttribute("name") %> <!--  로그인 이름 -->
	</td>
	</tr>
</table>
</fieldset>
	<h1 style="text-align:center" ><%=session.getAttribute("name")%>님 환영합니다.</h1>
</form>
<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
<a href="<%=request.getContextPath()%>/<%=session.getAttribute("user")%>outIdForm.jsp">회원탈퇴</a>
<a href="<%=request.getContextPath()%>/employeeList.jsp">사원 리스트</a>
<a href="<%=request.getContextPath()%>">상품관리 리스트</a>
<a href="<%=request.getContextPath()%>">고객관리 리스트</a>
<a href="<%=request.getContextPath()%>">주문관리 리스트</a>
<a href="<%=request.getContextPath()%>">공지사항 게시판</a>
</div>
</body>
</html>