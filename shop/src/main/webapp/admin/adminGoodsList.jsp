<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee")) &&session.getAttribute("active")=="Y"){
		response.sendRedirect(request.getContextPath() + "/admin.index.jsp");
		return;
	}
	int currentPage = 1;
	int rowPerPage = 5; // 한페이지에 보여줄 갯수
	int lastPage = 0;
	
	if(request.getParameter("currentPage") !=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	GoodsService service = new GoodsService(); //서비스 호출
	
	lastPage = service.lastPage(rowPerPage);//마지막 페이지
	
	//리스트 불러오기
	List<Goods> list = new ArrayList<Goods>();
	list = service.getGoodsListByPage(rowPerPage, currentPage);
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
<h1>상품 관리</h1>
	<table border="1">
		<thead>
			<tr>
				<td>물건 번호</td>
				<td>물건 이름</td>
				<td>물건 가격</td>
				<td>등록된 날짜</td>				
				<td>수정된 날짜</td>
				<td>SOLD OUT</td>
				<td>상품 수정하기</td>
			</tr>
		</thead>
	<tbody>
		  <%
		  		for(Goods g : list){
		   %>
				  <tr>
						<td><%=g.getGoodsNo()%></td>
				        <td><a href="<%=request.getContextPath()%>/admin/adminGoodsOne.jsp?goods_no=<%=g.getGoodsNo()%>"><%=g.getGoodsName()%></a></td>
				        <td><%=g.getGoodsPrice()%></td>
				        <td><%=g.getCreateDate()%></td>
				        <td><%=g.getUpdateDate()%></td>
				        <td><%=g.getSoldOut()%></td>
				        <td><a href="<%=request.getContextPath()%>/admin/GoodsUpdateForm.jsp?goods_no=<%=g.getGoodsNo()%>">상품수정하기</a></td>
				  </tr>
		<%
				}
		%>
	</tbody>
</table>
<%
	if(currentPage > 1){
%>
	<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage-1%>">이전</a>
<%		
	}
	if(currentPage < lastPage){
%>
	<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage+1%>">다음</a>
<%		
	}
%>

<a href="<%=request.getContextPath()%>/admin/addGoodsForm.jsp">상품추가</a>
<a href="<%=request.getContextPath()%>/admin.index.jsp">돌아가기</a>

</body>
</html>