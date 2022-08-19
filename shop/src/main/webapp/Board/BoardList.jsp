<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
		request.setCharacterEncoding("UTF-8");

		if(session.getAttribute("id") == null ){
			response.sendRedirect(request.getContextPath() + "/admin.index.jsp");
			return;
		} // 로그인 체크
		
		//board 페이징
		int currentPage = 1 ;
		int rowPerPage = 5; // 한페이지에 보여줄 갯수
		int lastPage = 0;
		
		//notice 페이징
		int NrowPerPage = 3; //최대 공지사항 갯수
		int NlastPage = 0;
		if(request.getParameter("currentPage") !=null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
	
		//문의사항
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
<ul class="list-group list-group-horizontal"> <!-- 상단메뉴 -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/GoodsList.jsp">상품 리스트</a></li>	<!-- 상품목록/등록/수정/삭제(주문이없는경우) -->
<li class="list-group-item"><a href="<%=request.getContextPath()%>/Board/BoardList.jsp">문의 게시판</a></li> <!-- 공지 CRUD -->
</ul>
	<h1>공지사항</h1>
		<table class="table table-striped">
			<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성날짜</td>
			</thead>
				<tbody>
				<%
					for(Notice n : Nlist){
				%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td><a href="<%=request.getContextPath()%>/Board/NoticeOne.jsp?notice_no=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
						<td><%=n.getCreateDate()%></td>		
				<%	
					}
				%>
				</tbody>
		</table>
	<h3>문의 게시판</h3>
		<table class="table table-striped">
			<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성날짜</td>
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
			<a href="<%=request.getContextPath()%>/Board/BoardList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			
			if(currentPage < lastPage){ 
		%>
			<a href="<%=request.getContextPath()%>/Board/BoardList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}

		%>
</div>
<a href="<%=request.getContextPath()%>/Board/insertBoardForm.jsp">글 작성하기</a>
<a href="<%=request.getContextPath()%>/index.jsp">돌아가기</a>	
</body>
</html>