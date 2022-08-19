<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	//작성자와 , 수정하는사람ID 가 동일하지않으면 list로 보내줌. 본인의 문의는 본인만수정 o
	if(session.getAttribute("id") == null || !(session.getAttribute("id").equals(request.getParameter("board_writer")))){
		if(session.getAttribute("user").equals("Employee")){
			response.sendRedirect(request.getContextPath() + "/Board/EmployeeBoardList.jsp");

			}else{
			response.sendRedirect(request.getContextPath() + "/Board/BoardList.jsp");
			
			}
		return;
	}
	
	int boardNo = Integer.parseInt(request.getParameter("board_no"));
	String boardTitle = request.getParameter("board_title");
	String boardContent = request.getParameter("board_content");
	
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	
	BoardService service = new BoardService();
	service.updateBoard(board);
	
	// 접속한 session을 판단해서 고객 / 관리자 나누기
	
	if(session.getAttribute("user").equals("Employee")){
	response.sendRedirect(request.getContextPath() + "/Board/EmployeeBoardList.jsp");

	}else{
	response.sendRedirect(request.getContextPath() + "/Board/BoardList.jsp");
	
	}
	
	
%>