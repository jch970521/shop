<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPass");
	
	System.out.println(customerId);
	System.out.println(customerPw);
	
	if(customerId==null || customerPw == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPw);

	System.out.println(customer.getCustomerId());
	System.out.println(customer.getCustomerPass());
	
	CustomerDao customerDao = new CustomerDao();
	Customer loginCustomer = customerDao.login(customer);
	
	if(loginCustomer == null ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} else {
		session.setAttribute("id", loginCustomer.getCustomerId());
		session.setAttribute("name", loginCustomer.getCustomerName());
		session.setAttribute("user", "Customer");
	}
	
	session.setAttribute("loginCustomer", loginCustomer);
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>