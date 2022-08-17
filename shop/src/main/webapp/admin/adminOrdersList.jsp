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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<ul class="list-group list-group-horizontal"> <!-- 상단메뉴 -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원 리스트</a></li>			<!--  -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리 리스트</a></li>	<!-- 상품목록/등록/수정/삭제(주문이없는경우) -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리 리스트</a></li> 	<!-- 주문목록/수정  -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리 리스트</a></li> <!-- 고객목록/고객강제탈퇴/비밀번호수정(전달구현x) -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>">공지사항 게시판</a></li> <!-- 공지 CRUD -->
</ul>
	<h1>주문 관리</h1>
	<table class="table table-striped">
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
						<td><a href="<%=request.getContextPath()%>/admin/adminOrdersOne.jsp?order_no=<%=map.get("orderNo")%>"><%=map.get("orderNo")%></a></td>
						<td><%=map.get("goodsNo")%></td>
						<td><%=map.get("customerId")%></td>
						<td><%=map.get("orderQuantity")%></td>
						<td><%=map.get("orderPrice")%></td>
						<td><%=map.get("orderAddress")%></td>
						<td>
						<form action="<%=request.getContextPath()%>/admin/modifyorderStateAction.jsp" method="post">
							<input type="hidden" name="orderNo" value="<%=map.get("orderNo")%>">
						<select name="state">
						<%
							if(map.get("orderState").equals("orderCom")){
						%>
							<option value="orderCom" selected="selected">주문완료</option>
							<option value="orderDelivery">배송중</option>
							<option value="orderDelCom">배송완료</option>
						<%	
							} else if(map.get("orderState").equals("orderDelivery")){
						%>
							<option value="orderCom">주문완료</option>
							<option value="orderDelivery" selected="selected" >배송중</option>
							<option value="orderDelCom">배송완료</option>
						<%	
							} else {
						%>
							<option value="orderCom">주문완료</option>
							<option value="orderDelivery">배송중</option>
							<option value="orderDelCom"  selected="selected" >배송완료</option>
						<%
							}
						%>
						</select>
						<button type="submit">주문상태 변경</button>
						</form>
						</td>
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
<a href="<%=request.getContextPath()%>/admin.index.jsp">돌아가기</a>
</body>
</html>