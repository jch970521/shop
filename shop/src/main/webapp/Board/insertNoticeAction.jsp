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

	String noticeTitle = request.getParameter("notice_title");
	String noticeContent = request.getParameter("notice_content");
	
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = new Notice();
	
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	NoticeService service = new NoticeService();
	service.insertNotice(notice);
	
	response.sendRedirect(request.getContextPath() + "/Board/EmployeeBoardList.jsp");
%>