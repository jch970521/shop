<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<div class="container">	    
	<!--  id ck form -->
	<form action="<%=request.getContextPath()%>/idCheckAction.jsp" method="post">
		<div>
			ID체크
			<input type="text" name="ckId">
			<button type="submit">아이디 중복검사</button>
		</div>
	</form>
	
	<!-- 고객가입form -->
	<%
		String ckId = "";
	
		if(request.getParameter("ckId") != null ){
			ckId = request.getParameter("ckId");
		}
	%>
	<form action="<%=request.getContextPath()%>/idInsertAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>customerId</td>
				<td><input type="text" name="customerId" id="customerId" readonly="readonly" value="<%=ckId%>">
			</tr>
			<tr>
				<td>customerPw</td>
				<td><input type="password" name="customerPw" id="customerPw"></td>
			</tr>
			<tr>
				<td>customerName</td>
				<td><input type="text" name="customerName" id="customerName"></td>
			</tr>
			<tr>
				<td>customerAddress</td>
				<td><input type="text" name="customerAddress" id="customerAddress"></td>
			</tr>
			<tr>
				<td>customerTelephone</td>
				<td><input type="text" name="customerTelephone" id="customerTelephone"></td>
			</tr>
		</table>
		<button type="submit">회원가입하기</button>
		<a href="<%=request.getContextPath()%>/admin.index.jsp">돌아가기</a>
	</form>
</div>

</body>
</html>