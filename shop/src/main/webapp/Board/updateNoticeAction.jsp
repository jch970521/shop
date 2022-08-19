<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
		request.setCharacterEncoding("UTF-8");		

		if(session.getAttribute("id") == null  || !(session.getAttribute("user").equals("Employee")) &&session.getAttribute("active")=="Y"){
			response.sendRedirect(request.getContextPath() + "/Board/EmployeeBoardList.jsp");
			return;
		}// 정보가 맞지않으면 게시판 리스트로 권한있는 관리자면 누구든지 수정할것.
		
		
		int noticeNo = Integer.parseInt(request.getParameter("notice_no"));
		String noticeTitle = request.getParameter("notice_title");
		String noticeContent = request.getParameter("notice_content");
		
		Notice notice = new Notice();
		notice.setNoticeNo(noticeNo);
		notice.setNoticeTitle(noticeTitle);
		notice.setNoticeContent(noticeContent);
		
		NoticeService service = new NoticeService();
		service.updateNotice(notice);
		
		response.sendRedirect(request.getContextPath() + "/Board/EmployeeBoardList.jsp");
%>