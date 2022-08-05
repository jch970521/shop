<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
	</form>
</body>
</html>