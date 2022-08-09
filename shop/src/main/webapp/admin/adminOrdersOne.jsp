<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="service.GoodsService"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee")) &&session.getAttribute("active")=="Y"){
		response.sendRedirect(request.getContextPath() + "/admin.index.jsp");
		return;
	}// 정보가 맞지않으면 admin.index로
	
	
	int orderNo = Integer.parseInt(request.getParameter("order_no")); 
	OrdersService service = new OrdersService();
	Map<String, Object> map = service.getOrdersOne(orderNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주문정보 상세보기</h1>
		<table border="1">
			<tr>
				<th>주문번호</th>
				<td><%=map.get("orderNo")%></td>
			</tr>
			<tr>
				<th>주문수량</th>
				<td><%=map.get("orderQuantity")%></td>
			</tr>	
			<tr>
				<th>배송주소</th>
				<td><%=map.get("orderAddress")%></td>
			</tr>
			<tr>
				<th>수정날짜</th>
				<td><%=map.get("updateDate")%></td>
			</tr>
			<tr>
				<th>주문날짜</th>
				<td><%=map.get("createDate")%></td>
			</tr>
			<tr>
				<th>상품번호</th>
				<td><%=map.get("goodsNo")%></td>
			</tr>
			<tr>
				<th>상품이름</th>
				<td><%=map.get("goodsName")%></td>
			</tr>
			<tr>
				<th>상품가격</th>
				<td><%=map.get("goodsPrice")%></td>
			</tr>
			<tr>
				<th>고객ID</th>
				<td><%=map.get("customerId")%></td>
			</tr>
			<tr>
				<th>고객이름</th>
				<td><%=map.get("customerName")%></td>
			</tr>
			<tr>
				<th>고객주소</th>
				<td><%=map.get("customerAddress")%></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><%=map.get("customerTelephone")%></td>
			</tr>			
		</table>
	<a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">돌아가기</a>
</body>
</html>