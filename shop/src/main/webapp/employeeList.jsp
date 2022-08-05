<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	int currentPage = 1;
	int rowPerPage = 5; // 한페이지에 보여줄 갯수
	int lastPage = 0;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	EmployeeService service = new EmployeeService(); // 서비스호출
	
	lastPage = service.lastPage();// 마지막페이지
	
	//리스트 불러오기
	List<Employee> list = new ArrayList<Employee>();
	list = service.getEmployeeList(rowPerPage,currentPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<thead>
			<tr>
				<td>ID</td>
				<td>NAME</td>
				<td>수정날짜</td>
				<td>입사날짜</td>
				<td>권한</td>
			</tr>
		</thead>
<tbody>
	<%
		for(Employee e : list) {
	%>
					<tr>
						<td><%=e.getEmployeeId()%></td>
						<td><%=e.getEmployeeName()%></td>
						<td><%=e.getUpdateDate()%></td>
						<td><%=e.getCreateDate()%></td>
						<td>
							<form action="<%=request.getContextPath()%>/updateEmployeeActiveAction.jsp" method="post">
								<input type="hidden" name="employeeId" value="<%=e.getEmployeeId()%>">
								<select name="active">
									<%
										if(e.getActive().equals("N")) {
									%>
											<option value="Y">Y</option>
											<option value="N" selected="selected">N</option>
									<%
										} else {
									%>
											<option value="Y" selected="selected">Y</option>
											<option value="N">N</option>
									<%
										}
									%>
								</select>
							<button type="submit">권한변경</button>
							</form>
						</td>
					</tr>
			<%	
				}
			%>
	</tbody>
</table>
<div>
<%
	if(currentPage <1){
%>
	<a href="<%=request.getContextPath()%>/employeeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
<%		
		}
	
	if(currentPage < lastPage ){
%>
	<a href="<%=request.getContextPath()%>/employeeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
<%		
		}
%>
</div>
</body>
</html>