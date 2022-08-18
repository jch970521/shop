<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%

	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}//로그인체크
	
	request.setCharacterEncoding("UTF-8");
	
	int boardNo = Integer.parseInt(request.getParameter("board_no"));
	String boardTitle = request.getParameter("board_title");
	String boardContent = request.getParameter("board_content");
	
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	
	BoardService service = new BoardService();
	service.updateBoard(board);
	
	response.sendRedirect(request.getContextPath() + "/Board/EmployeeBoardList.jsp");
%>