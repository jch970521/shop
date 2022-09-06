<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}// 정보가 맞지않으면 로그인창으로


	//상품 상세보기
	int goodsNo = Integer.parseInt(request.getParameter("goods_no")); 
	GoodsService goodsService = new GoodsService();
	Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/GoodsBuyAction.jsp">
	<h1>상품 정보</h1>
	<table border="1">
		<tr>
			<th>상품이미지</th>
			<th><img src="<%=request.getContextPath()%>/upload/<%=map.get("fileName")%>"></th>
		</tr>
		<tr>
			<th>상품번호</th>
			<td><input type="hidden" name="goods_no" value=<%=map.get("goodsNo")%>><%=map.get("goodsNo")%></td>	
		</tr>
		<tr>
			<th>상품명</th>
			<td><input type="hidden" name="goods_name" value="<%=map.get("goodsName")%>">
			<%=map.get("goodsName")%></td>	
		</tr>
		<tr>
			<th>상품가격</th>
			<td><input type="hidden" name="goods_price" value="<%=map.get("goodsPrice")%>">
			<%=map.get("goodsPrice")%></td>	
		</tr>
		<tr>
			<th>상품 갯수</th>
			<td><input type="text" name="order_quantity"></td>
		</tr>
		<tr>
			<th>주소 입력</th>
			<td><input type="text" name="orders_address"></td>
		</tr>
		<tr>
			<th>상품품절여부</th>
			<td><%=map.get("soldOut")%></td>	
		</tr>
	</table>
	<button type="submit">상품 구매하기</button>
	<a href="<%=request.getContextPath()%>/GoodsList.jsp">돌아가기</a>
	</form>
</body>
</html>