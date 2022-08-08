<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/addGoodsAction.jsp" method="post" enctype="multipart/form-data">
	<table border="1">
		<tr>
			<td>상품 이름</td>
			<td><input type="text" name="goodsName"></td>
		</tr>
		<tr>
			<td>상품 가격</td>
			<td><input type="text" name="goodsPrice"></td>
		</tr>	
		<tr>
			<td>상품 이미지 제목</td>
			<td><input type="text" name="goodsImgName"></td>	
		</tr>				
		<tr>
			<td>상품 이미지 파일</td>
			<td><input type="file" name="goodsImgFile"></td>
		</tr>
	</table>
		<button type="submit">상품 등록하기</button>
		<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">돌아가기</a>
	</form>
</body>
</html>