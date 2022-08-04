<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="<%=request.getContextPath()%>/<%=session.getAttribute("user")%>outIdAction.jsp">
		<table class="table table-bordered table-sm" >
			<tr>
			<td>id</td>
			<td> <input type="text" name="id" value="<%=session.getAttribute("id")%>" readonly> 	<!--  로그인 아이디-->
			</td>
		
			<tr>
			<td>pw</td>
			<td> <input type="password" name="pw">
			</td>
		</table>
	<button type="submit">회원 탈퇴하기</button>
	</form>
</body>
</html>