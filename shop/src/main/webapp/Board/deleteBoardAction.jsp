<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%@ page import = "service.*" %>
<%@ page import = "java.sql.*" %>
<%

	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}//로그인체크

	request.setCharacterEncoding("UTF-8");

	int boardNo = Integer.parseInt(request.getParameter("board_no"));
	System.out.println(boardNo); // 게시글 번호 체크
	
	Board board = new Board();
	board.setBoardNo(boardNo);
		
	System.out.println(board.getBoardNo()); // 번호 확인
	
	BoardService service = new BoardService();
	service.deleteBoard(boardNo);
	
	response.sendRedirect(request.getContextPath() + "/Board/EmployeeBoardList.jsp");
%>