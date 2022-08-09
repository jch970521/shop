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
	int rowPerPage = 1; // 한페이지에 보여줄 갯수
	int lastPage = 0;
	
	if(request.getParameter("currentPage") !=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	OrdersService service = new OrdersService();
	
	lastPage = service.lastPage(rowPerPage);
	
	//리스트 호출
	List<Map<String,Object>> list = new ArrayList<>();
	list = service.getOrdersListByPage(rowPerPage, currentPage);
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
	<h1>고객 관리</h1>
		<table border="1">
			<thead>
				<tr>
					<td>주문 번호</td>
					<td>상품 번호</td>
					<td>고객 ID</td>
					<td>주문 수량</td>
					<td>주문 가격</td>
					<td>배송 주소</td>
					<td>배송 현황</td>
					<td>수정 날짜</td>
					<td>주문 날짜</td>
				</tr>
			</thead>
			<tbody>
				<%
					for(Map<String,Object> map : list){
				%>
					<tr>
						<td><%=map.get("orderNo")%></td>
						<td><%=map.get("goodsNo")%></td>
						<td><a href="<%=request.getContextPath()%>/admin/adminOrdersOne.jsp?order_no=<%=map.get("orderNo")%>"><%=map.get("customerId") %></a></td>
						<td><%=map.get("orderQuantity")%></td>
						<td><%=map.get("orderPrice")%></td>
						<td><%=map.get("orderAddress")%></td>
						<td><%=map.get("orderState")%></td>
						<td><%=map.get("updateDate")%></td>
						<td><%=map.get("createDate")%></td>
					</tr>
				<%		
					}
				%>
			</tbody>

		</table>
		<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%		
			}
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
%>
</body>
</html>