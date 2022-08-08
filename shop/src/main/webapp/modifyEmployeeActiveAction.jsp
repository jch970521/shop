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
	
	String employeeId = request.getParameter("employeeId");
	String active = request.getParameter("active");
	
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setActive(active);
	
	EmployeeService employeeService = new EmployeeService();
	
	int row = employeeService.modifyEmployeeActive(employee);
	
	if(row ==1){//수정이 성공
		System.out.println("권한부여 성공");
		response.sendRedirect(request.getContextPath() + "/admin/employeeList.jsp");

	}else{
		System.out.println("권한부여 실패");
		response.sendRedirect(request.getContextPath() + "/admin/employeeList.jsp");
	}
%>