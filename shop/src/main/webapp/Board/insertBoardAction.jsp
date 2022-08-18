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
	
	String boardWriter = request.getParameter("board_writer");
	String boardTitle = request.getParameter("board_title");
	String boardContent = request.getParameter("board_content");
	
	BoardDao boardDao = new BoardDao();
	Board board = new Board();
	
	board.setBoardWriter(boardWriter);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	
	System.out.println(board.getBoardContent());
	System.out.println(board.getBoardTitle());
	System.out.println(board.getBoardWriter());
	//확ㄱ인
	
	BoardService service = new BoardService();
	service.insertBoard(board);
	if(session.getAttribute("user").equals("Employee")){
		response.sendRedirect(request.getContextPath() + "/Board/EmployeeBoardList.jsp");
	}else{
		response.sendRedirect(request.getContextPath() + "/Board/BoardList.jsp");
	}
%>
