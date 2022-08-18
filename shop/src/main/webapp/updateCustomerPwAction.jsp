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

	String customerId = request.getParameter("customer_id");
	String customerPw = request.getParameter("customer_pw");
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPw);
	
	CustomerService service = new CustomerService();
	
	service.updateCustomerPw(customer);
	
	response.sendRedirect(request.getContextPath() +"/admin/adminCustomerList.jsp");
	
%>