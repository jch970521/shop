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
	String customerId = (String) session.getAttribute("id");
	
	lastPage = service.lastPage(rowPerPage);
	
	//리스트 호출
	List<Map<String,Object>> list = new ArrayList<>();
	list = service.getOrdersCustomerListByPage(customerId, rowPerPage, currentPage);
	
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
<nav class="navbar navbar-expand-sm bg-light navbar-light">
  <ul class="navbar-nav">
    <li class="nav-item active">
      <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">메인페이지</a>
    </li>
  </ul>
</nav>
<ul class="list-group list-group-horizontal"> <!-- 상단메뉴 -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/GoodsList.jsp">상품 리스트</a></li>	<!-- 상품목록/등록/수정/삭제(주문이없는경우) -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/OrdersList.jsp">내 주문 확인하기</a></li> 	<!-- 주문목록/수정  -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/Board/BoardList.jsp">문의 게시판</a></li> <!-- 공지 CRUD -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/review/ReviewList.jsp">리뷰 게시판</a></li>
</ul>
	<h1>주문 확인</h1>
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
					<td>리뷰 작성하기</td>
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
						<%
							if(map.get("orderState").equals("orderCom")){
						%>
							주문완료
						<%	
							} else if(map.get("orderState").equals("orderDelivery")){
						%>
							배송중
					
						<%	
							} else {
						%>
							배송완료
						<%
							}
						%>
						</td>
						<td><%=map.get("updateDate")%></td>
						<td><%=map.get("createDate")%></td>
						<td>		
						<form action="<%=request.getContextPath()%>/review/ReviewinsertForm.jsp" method="post">
						<button type="submit">리뷰 작성</button>
						</form>
						</td>
					</tr>
				<%		
					}
				%>
			</tbody>

		</table>
		<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath()%>/OrdersList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%		
			}
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath()%>/OrdersList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
%>
<a href="<%=request.getContextPath()%>/index.jsp">돌아가기</a>
</body>
</html>