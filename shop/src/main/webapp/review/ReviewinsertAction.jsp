<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="service.GoodsService"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	if(session.getAttribute("id") == null ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}// 정보가 맞지않으면 로그인폼으로

	String reviewContent = request.getParameter("review_content");
	
	ReviewDao reviewDao = new ReviewDao();
	Review review = new Review();
	
	review.setReviewContent(reviewContent);
	
	System.out.println(review.getReviewContent());
	
	ReviewService service = new ReviewService();
	service.insertReview(review);
	
	response.sendRedirect(request.getContextPath() + "/OrdersList.jsp");
%>
