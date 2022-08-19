<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%@ page import = "service.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String customerName = request.getParameter("customerName");
	String customerAddress = request.getParameter("customerAddress");
	String customerDetail = request.getParameter("customerDetail");
	String customerTelephone = request.getParameter("customerTelephone");
	
	System.out.println(customerId);
	System.out.println(customerPw);
	System.out.println(customerName);
	System.out.println(customerAddress);
	System.out.println(customerTelephone);
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPw);
	customer.setCustomerName(customerName);
	customer.setCustomerAddress(customerAddress);
	customer.setCustomerDetail(customerDetail);
	customer.setCustomerTelephone(customerTelephone);
	
	//값확인
	System.out.print(customer.getCustomerId());
	System.out.print(customer.getCustomerPass());
	System.out.print(customer.getCustomerName());
	System.out.print(customer.getCustomerAddress());
	System.out.print(customer.getCustomerTelephone());
	
	CustomerService service = new CustomerService();
	service.insertCustomer(customer);
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	
%>