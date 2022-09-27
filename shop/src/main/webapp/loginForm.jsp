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

<nav class="navbar navbar-expand-sm bg-light navbar-light">
  <ul class="navbar-nav">
    <li class="nav-item active">
      <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">메인페이지</a>
    </li>
  </ul>
</nav>
<div class="row" style="background-color:lavenderblush;">
	<div class="col">
		<form id="customerForm" method="post" action="<%=request.getContextPath()%>/customerLoginAction.jsp">
			<fieldset>
				<legend>고객 로그인</legend>
				<table border="1">
					<tr>
						<td>ID</td>
						<td><input type="text" name="customerId" id="customerId" value="geust"></td>
					</tr>
					<tr>
						<td>pw</td>
						<td><input type="password" name="customerPass" id="customerPass" value="1234"></td>
					</tr>
				</table>
				<button type="button" class="btn btn-info" id="customerBtn">고객 로그인</button>
			</fieldset>
		</form>
	</div>
	<div class="col" >
		<form id="employeeForm" method="post" action="<%=request.getContextPath()%>/employeeLoginAction.jsp">
			<fieldset>
				<legend>스태프 로그인</legend>
				<table border="1">
					<tr>
						<td>ID</td>
						<td>
						<input type="text" name="employeeId" id="employeeId" value="admin">
						</td>
					</tr>
					<tr>
						<td>pw</td>
						<td><input type="password" name="employeePass" id="employeePass" value="1234"></td>
					</tr>
				</table>
				<button type="button" class="btn btn-info" id="employeeBtn">스태프 로그인</button>
			</fieldset>
		</form>
	</div>
</div>
<a href="<%=request.getContextPath()%>/addCustomer.jsp">고객 회원가입</a>
<a href="<%=request.getContextPath()%>/addemployee.jsp">스태프 회원가입</a>
	

</body>
<script>

	$('#customerBtn').click(function(){
		if($('#customerId').val() == '') {
			alert('고객 ID를 입력하세요');
		}else if($('#customerPass').val() == ''){
			alert('고객 PASSWORD를 입력하세요');
		} else{
			customerForm.submit();
		}
	});
	
	
	$('#employeeBtn').click(function(){
		if($('#employeeId').val() == '') {
			alert('스태프 ID를 입력하세요');
		}else if($('#employeePass').val() == ''){
			alert('스태프 PASSWORD를 입력하세요');
		} else{
			employeeForm.submit();
		}
	});
</script>

</html>