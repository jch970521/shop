<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%@ page import = "service.*" %>
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
	CustomerService loginCustomer = new CustomerService();
	Customer paramCustomer = new Customer();
	
	paramCustomer.setCustomerId(customerId);
	paramCustomer.setCustomerPass(customerPw); // 값담기

	
	System.out.println(paramCustomer.getCustomerId());
	System.out.println(paramCustomer.getCustomerPass()); //값 확인
	
	if ((paramCustomer = loginCustomer.login(paramCustomer))==null){
		response.sendRedirect(request.getContextPath()+"/loginForm,jsp");
	}
	
	if(paramCustomer.getCustomerId()!=null){
		session.setAttribute("id", paramCustomer.getCustomerId());
		session.setAttribute("name", paramCustomer.getCustomerName());
		session.setAttribute("user", "Customer");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		
	}else {
		response.sendRedirect(request.getContextPath()+"/loginForm,jsp");
	}
	
	
%>