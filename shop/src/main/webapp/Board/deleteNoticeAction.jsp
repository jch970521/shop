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

	int noticeNo = Integer.parseInt(request.getParameter("notice_no"));
	System.out.println(noticeNo); // 게시글 번호 체크
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	System.out.println(notice.getNoticeNo()); // 번호 확인
	
	NoticeService service = new NoticeService();
	service.deleteNotice(noticeNo);
	
	response.sendRedirect(request.getContextPath() + "/Board/EmployeeBoardList.jsp");
%>