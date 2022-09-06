<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
		request.setCharacterEncoding("UTF-8");

		if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee")) &&session.getAttribute("active")=="Y"){
			response.sendRedirect(request.getContextPath() + "/admin.index.jsp");
			return;
		} // 로그인 체크
		int currentPage = 1 ;
		int rowPerPage = 5; // 한페이지에 보여줄 갯수
		int lastPage = 0;
		
		//notice 페이징
		int NrowPerPage = 3; //최대 공지사항 갯수
		int NlastPage = 0;
				
		if(request.getParameter("currentPage") !=null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
	
		BoardService service = new BoardService();
		
		lastPage = service.lastPage(rowPerPage);
		
		List<Board> list = new ArrayList<Board>();
		list = service.getBoardList(rowPerPage, currentPage);
		
		//공지사항
		NoticeService Nservice = new NoticeService();
		NlastPage = Nservice.lastPage(NrowPerPage);
				
		List<Notice> Nlist = new ArrayList<Notice>();
		Nlist = Nservice.getNoticeList(rowPerPage, currentPage);
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
      <a class="nav-link" href="<%=request.getContextPath()%>/admin.index.jsp">메인페이지</a>
    </li>
  </ul>
</nav>
<ul class="list-group list-group-horizontal"> <!-- 상단메뉴 -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원 리스트</a></li>			<!--  -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리 리스트</a></li>	<!-- 상품목록/등록/수정/삭제(주문이없는경우) -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리 리스트</a></li> 	<!-- 주문목록/수정  -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리 리스트</a></li> <!-- 고객목록/고객강제탈퇴/비밀번호수정(전달구현x) -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/Board/EmployeeBoardList.jsp">문의 게시판</a></li> <!-- 공지 CRUD -->
</ul>
<% if(currentPage == 1){
	
%>
	<h1>공지사항</h1>
		<table class="table table-striped">
			<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성날짜</td>
					<td>삭제</td>
			</thead>
				<tbody>
				<%
					for(Notice n : Nlist){
				%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td><a href="<%=request.getContextPath()%>/Board/NoticeOne.jsp?notice_no=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
						<td><%=n.getCreateDate()%></td>
						<td>
						<form action="<%=request.getContextPath()%>/Board/deleteNoticeAction.jsp" method="post">
						<input type="hidden" name="notice_no" value="<%=n.getNoticeNo()%>">
						<button type="submit">삭제</button>
						</form>
						</td>	
				<%	
					}
				%>
				</tbody>
		</table>
		<%
}
		%>
		
	<h3>문의 게시판</h3>
		<table class="table table-striped">
			<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성날짜</td>
					<td>게시글 삭제</td>
				</tr>
			</thead>
		<tbody>
		<%
			for(Board b : list){
		%>
			<tr>
				<td><%=b.getBoardNo()%></td>
				<td><a href="<%=request.getContextPath()%>/Board/BoardOne.jsp?board_no=<%=b.getBoardNo()%>"><%=b.getBoardTitle() %></a></td>
				<td><%=b.getBoardWriter() %></td>
				<td><%=b.getCreateDate() %></td>
				<td>
				<form action="<%=request.getContextPath()%>/Board/deleteBoardAction.jsp" method="post">
				<input type="hidden" name="board_no" value="<%=b.getBoardNo()%>">
				<button type="submit">삭제</button>
				</form>
				</td>
			</tr>
		<%
			}
		%>
		</tbody>	
		</table>
<div>
		<%
			if(currentPage > 1){ 
		%>
			<a href="<%=request.getContextPath()%>/Board/EmployeeBoardList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			
			if(currentPage < lastPage){ 
		%>
			<a href="<%=request.getContextPath()%>/Board/EmployeeBoardList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}

		%>
</div>
<a href="<%=request.getContextPath()%>/Board/insertNoticeForm.jsp">공지사항 작성</a>
<a href="<%=request.getContextPath()%>/Board/insertBoardForm.jsp">글 작성하기</a>
<a href="<%=request.getContextPath()%>/admin.index.jsp">돌아가기</a>	
</body>
</html>