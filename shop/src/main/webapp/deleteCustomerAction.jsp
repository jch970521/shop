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

	String customerId = request.getParameter("customer_id");
	System.out.println(customerId);
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	
	System.out.println(customer.getCustomerId());
	
	CustomerService customerService = new CustomerService();
	customerService.deleteCustomerId(customer);

	response.sendRedirect(request.getContextPath() + "/admin/adminCustomerList.jsp");
%>