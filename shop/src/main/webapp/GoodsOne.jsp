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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
			<th>상품등록날짜</th>
			<td><%=map.get("createDate")%></td>	
		</tr>
		<tr>
			<th>상품수정날짜</th>
			<td><%=map.get("updateDate")%></td>	
		</tr>
		<tr>
			<th>상품품절여부</th>
			<td><%=map.get("soldOut")%></td>	
		</tr>
		<tr>
			<th>이미지 이름</th>
			<td><%=map.get("fileName")%></td>	
		</tr>
		<tr>
			<th>원본 이미지</th>
			<td><%=map.get("originFilename")%></td>	
		</tr>
		<tr>
			<th>이미지 타입</th>
			<td><%=map.get("contentType")%></td>	
		</tr>		
	</table>
	<a href="<%=request.getContextPath()%>/GoodsList.jsp">돌아가기</a>
</body>
</html>