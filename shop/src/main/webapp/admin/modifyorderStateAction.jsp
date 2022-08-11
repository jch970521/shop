<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%@ page import = "service.*" %>
<%@ page import = "java.sql.*" %>
<%

	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("UTF-8");
	
	String state = request.getParameter("state");
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
	Orders order = new Orders();
	order.setOrderNo(orderNo);
	order.setOrderState(state);
	
	OrdersService service = new OrdersService();
	
	int row = service.modifyOrderState(order);
	
	if(row ==1){//수정이 성공
		System.out.println("주문현황 수정 성공");
		response.sendRedirect(request.getContextPath() + "/admin/adminOrdersList.jsp");

	}else{
		System.out.println("주문현황 수정 실패");
		response.sendRedirect(request.getContextPath() + "/admin/adminOrdersList.jsp");
	}
%>