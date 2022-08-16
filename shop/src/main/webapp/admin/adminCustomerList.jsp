<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee")) &&session.getAttribute("active")=="Y"){
		response.sendRedirect(request.getContextPath() + "/admin.index.jsp");
		return;
	} // 로그인 체크
	int currentPage = 1 ;
	int rowPerPage = 5; // 한페이지에 보여줄 갯수
	int lastPage = 0;
	
	if(request.getParameter("currentPage") !=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	CustomerService service = new CustomerService(); //서비스
	
	lastPage = service.lastPage(rowPerPage); // 마지막 페이지
		
	//리스트 호출
	List<Customer> list = new ArrayList<Customer>();
	list = service.getCustomerList(rowPerPage, currentPage);
	
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
<li><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리 리스트</a></li> 	<!-- 주문목록/수정  -->
<li><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리 리스트</a></li> <!-- 고객목록/고객강제탈퇴/비밀번호수정(전달구현x) -->
<li><a href="<%=request.getContextPath()%>">공지사항 게시판</a></li> <!-- 공지 CRUD -->
</ul>
	<h1>고객관리</h1>
		<table border="1">
			<thead>
				<tr>	
					<td>ID</td>
					<td>NAME</td>
					<td>ADDRESS</td>
					<td>TelePhone</td>
					<td>수정날짜</td>
					<td>가입날짜</td>
					<td>탈퇴</td>
					<td>비밀번호수정</td>
				</tr>
			</thead>
<tbody>
	<%
		for(Customer c : list ){
	%>
		<tr>
			<td><%=c.getCustomerId()%></td>
			<td><%=c.getCustomerName()%></td>
			<td><%=c.getCustomerAddress()%></td>
			<td><%=c.getCustomerTelephone()%></td>
			<td><%=c.getUpdateDate()%></td>
			<td><%=c.getCreateDate()%></td>	
			<td>
				<form action="<%=request.getContextPath()%>/deleteCustomerAction.jsp" method="post">
				<input type="hidden" name="customer_id" value="<%=c.getCustomerId()%>">
				<button type="submit">탈퇴</button>
				</form>
			</td>
			<td>
				<form action="<%=request.getContextPath()%>/updateCustomerPwForm.jsp" method="post">
				<input type="hidden" name="customer_id" value="<%=c.getCustomerId()%>">
				<button type="submit">비밀번호 수정</button>
				</form>
			</td>
	<%
		}
	%>
	</tr>
</tbody>
		</table>
		<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%		
			}
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
%>
</body>
</html>



















