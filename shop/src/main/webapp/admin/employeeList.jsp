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
	
	lastPage = service.lastPage(rowPerPage);// 마지막페이지
	
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
<ul> <!-- 상단메뉴 -->
<li><a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원 리스트</a></li>			<!--  -->
<li><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리 리스트</a></li>	<!-- 상품목록/등록/수정/삭제(주문이없는경우) -->
<li><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">고객관리 리스트</a></li> 	<!-- 주문목록/수정  -->
<li><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">주문관리 리스트</a></li> <!-- 고객목록/고객강제탈퇴/비밀번호수정(전달구현x) -->
<li><a href="<%=request.getContextPath()%>">공지사항 게시판</a></li> <!-- 공지 CRUD -->
</ul>
<h1>사원 관리</h1>
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
							<form action="<%=request.getContextPath()%>/modifyEmployeeActiveAction.jsp" method="post">
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
<!-- 데이터 5개이상일시 보여지는걸 페이지로 이전&다음.. -->
		<%
			if(currentPage > 1){ 
		%>
			<a href="<%=request.getContextPath()%>/admin/employeeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			
			if(currentPage < lastPage){ 
		%>
			<a href="<%=request.getContextPath()%>/admin/employeeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}

		%>
</div>
<a href="<%=request.getContextPath()%>/admin.index.jsp">돌아가기</a>
</body>
</html>