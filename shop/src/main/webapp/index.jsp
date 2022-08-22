<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%
	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Customer"))){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	CustomerDao customerDao = new CustomerDao();	
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
<ul class="list-group list-group-horizontal"> <!-- 상단메뉴 -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/GoodsList.jsp">상품 리스트</a></li>	<!-- 상품목록/등록/수정/삭제(주문이없는경우) -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/OrdersList.jsp">내 주문 확인하기</a></li> 	<!-- 주문목록/수정  -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/Board/BoardList.jsp">문의 게시판</a></li> <!-- 공지 CRUD -->
</ul>
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
	<td><%=session.getAttribute("name") %> <!--  로그인 이름 --></td>
	</tr>
</table>
</fieldset>
	<h1 style="text-align:center" ><%=session.getAttribute("name")%>님 환영합니다.</h1>
</form>

<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
<a href="<%=request.getContextPath()%>/<%=session.getAttribute("user")%>outIdForm.jsp">회원탈퇴</a>
</div>
</body>
</html>