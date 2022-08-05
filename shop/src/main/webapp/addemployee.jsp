<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!--  id ck form -->
	<form action="<%=request.getContextPath()%>/employeeCheckAction.jsp" method="post">
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
	<form action="<%=request.getContextPath()%>/employeeInsertAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>employeeId</td>
				<td><input type="text" name="employeeId" id="employeeId" readonly="readonly" value="<%=ckId%>">
			</tr>
			<tr>
				<td>employeePw</td>
				<td><input type="password" name="employeePw" id="employeePw"></td>
			</tr>
			<tr>
				<td>employeeName</td>
				<td><input type="text" name="employeeName" id="employeeName"></td>
			</tr>
		</table>
		<button type="submit">회원가입하기</button>
	</form>
</body>
</html>