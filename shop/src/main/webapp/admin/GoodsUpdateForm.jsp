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
	<h1>상품 정보 수정하기</h1>
	<form action="<%=request.getContextPath()%>/GoodsUpdateAction.jsp" method="post">
	<table border="1">
		<tr>
			<th>상품이미지</th>
			<th><img src="<%=request.getContextPath()%>/upload/<%=map.get("fileName")%>"></th>
		</tr>
		<tr>
			<th>상품번호</th>
			<td><input type="text" name="goods_no" value="<%=map.get("goodsNo")%>" readonly></td>	
		</tr>
		<tr>
			<th>상품명</th>
			<td><input type="text" name="goods_name" value="<%=map.get("goodsName")%>"></td>	
		</tr>
		<tr>
			<th>상품가격</th>
			<td><input type="text" name="goods_price" value="<%=map.get("goodsPrice")%>"></td>	
		</tr>
		
		<tr>
			<th>상품품절여부</th>
			<td>
			<select name="sold_out">
			<%
				if(map.get("soldOut").equals("Y")){
			%>
				<option value="Y" selected="selected">Y</option>
				<option value="N">N</option>
			<%					
				}else{
			%>
				<option value="Y" >Y</option>
				<option value="N" selected="selected">N</option>
			<%		
				}
			%>
			</select>
			</td>
		</tr>
		<tr>	
			<td>상품 이미지 파일</td>
			<td><input type="file" name="imgFile"></td>
		</tr>
	</table>
	<button type="submit">수정하기</button>
	</form>
	<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">돌아가기</a>
</body>
</html>