<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.*" %>

<%

	//Controller : java class <- Serlvet
	int rowPerPage = 20;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
	}
	
	CustomerService customerService = new CustomerService();
	List<Map<String,Object>> list = customerService.getCustomerGoodsListByPage(rowPerPage, currentPage);

	
	
%>
<!-- 분리하게되면 servlet 과 jsp로 분리 둘을 같이쓰려면 연결기술forword(request, response) 필요 -->
<!-- View 태그 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- for / if 대체기술 : 커스텀 태그(JSTL & EL)  JSP -->
	<div>
		<a href="">인기순</a>
		<a href="">판매량수</a>
		<a href="">낮은가격수</a>
		<a href="">높은가격수</a>
		<a href="">최신순</a>
	</div>
	<table border="1">
		<tr>
		<%
			int i = 1;
			for(Map<String,Object> m : list){
		%>
		
			<td>
				<div><a href=""> 
				<img src='<%=request.getContextPath()%>/upload/<%=m.get("filename")%>' width="200px" height="200px">
				</a>
				</div>
				<div><%=m.get("goodsNmae")%></div>
				<div><%=m.get("goodsPrice")%></div>
				<!-- 리뷰 갯수 -->
			</td>
		<%
			if(i%4==0){
		%>
				</tr><tr>
		<%		
					}
				i++;
			}
			
			int tdCnt = 4 - (list.size() % 4);
			if(tdCnt ==4 ){
				tdCnt = 0;
			}
			for(int j=0; j<tdCnt; j++){
		%>
			<td>&nbsp;</td>
		<%		
			}
		%>
			<th>
		</tr>
	</table>
	<!-- 페이징 + 상품검색 -->
</body>
</html>