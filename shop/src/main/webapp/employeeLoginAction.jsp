<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%@ page import ="service.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String employeeId = request.getParameter("employeeId");
	String employeePw = request.getParameter("employeePass");
	
	System.out.println(employeeId);
	System.out.println(employeePw);
	
	if(employeeId==null || employeePw == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	EmployeeService loginEmployee = new EmployeeService();
	Employee paramEmployee = new Employee();
	
	
	paramEmployee.setEmployeeId(employeeId);
	paramEmployee.setEmployeePass(employeePw);
	
	System.out.println(paramEmployee.getEmployeeId());
	System.out.println(paramEmployee.getEmployeePass());
	
	
	System.out.println(paramEmployee.getActive());
	if ((paramEmployee = loginEmployee.login(paramEmployee))==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		
	}
	
	
	if(paramEmployee.getEmployeeId()!=null){
	// Object <-다형성 String 추상화,상속,다형성,캡슐화
	session.setAttribute("id", paramEmployee.getEmployeeId()); // Object <-다형성 Integer <-오토박싱 int
	session.setAttribute("name", paramEmployee.getEmployeeName());
	session.setAttribute("user", "Employee");
	response.sendRedirect(request.getContextPath()+"/index.jsp");
	
	}else{response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	
	}
%>