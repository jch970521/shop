<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%

		if(session.getAttribute("id") == null ){
			response.sendRedirect(request.getContextPath() + "/admin.index.jsp");
			return;
		} // 로그인 체크		

		//리뷰 페이징
		int currentPage = 1;
		int rowPerPage = 1; // 한페이지에 보여줄 갯수
		int lastPage = 0;
		
		if(request.getParameter("currentPage") !=null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//리뷰
		ReviewService service = new ReviewService();
		lastPage = service.lastPage(rowPerPage);

		List<Map<String,Object>> list = new ArrayList<>();
		list = service.getReviewList(rowPerPage, currentPage);
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
<li class="list-group-item"><a href="<%=request.getContextPath()%>/GoodsList.jsp">상품 리스트</a></li>	<!-- 상품목록/등록/수정/삭제(주문이없는경우) -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/OrdersList.jsp">내 주문 확인하기</a></li> 	<!-- 주문목록/수정  -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/Board/BoardList.jsp">문의 게시판</a></li> <!-- 공지 CRUD -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/review/ReviewList.jsp">리뷰 게시판</a></li>
</ul>
	<table class="table table-striped">
		<thead>
			<tr>
				<td>상품 번호</td>
				<td>상품 이름</td>
				<td>리뷰작성자</td>
				<td>리뷰 내용</td>
				<td>등록 날짜</td>
			</tr>
		</thead>
		<tbody>
			<%
				for(Map<String,Object> map : list ){
			%>
				<tr>
				
					<td><a href="<%=request.getContextPath()%>/GoodsOne.jsp?goods_no=<%=map.get("goodsNo")%>"><%=map.get("goodsNo")%></a></td>
					<td><%=map.get("goodsName")%></td>
					<td><%=map.get("customerId")%></td>
					<td><%=map.get("reviewContent") %></td>
					<td><%=map.get("createDate") %></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath()%>/review/ReviewList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%		
			}
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath()%>/review/ReviewList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
%>
	<a href="<%=request.getContextPath()%>/index.jsp">돌아가기</a>
	
</body>
</html>