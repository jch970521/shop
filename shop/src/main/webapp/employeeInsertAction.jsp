<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%@ page import = "service.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String employeeId = request.getParameter("employeeId");
	String employeePw = request.getParameter("employeePw");
	String employeeName = request.getParameter("employeeName");
	String employeeAddress = request.getParameter("employeeAddress");
	String employeeDetail = request.getParameter("employeeDetail");
	
	//넘어오는 값확인
	System.out.println(employeeId);
	System.out.println(employeePw);
	System.out.println(employeeName);
	
	//값 입력
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePw);
	employee.setEmployeeName(employeeName);
	employee.setEmployeeAddress(employeeAddress);
	employee.setEmployeeDetail(employeeDetail);

	//값확인
	System.out.print(employee.getEmployeeId());
	System.out.print(employee.getEmployeePass());
	System.out.print(employee.getEmployeeName());
	
	
	EmployeeService service = new EmployeeService();
	service.insertEmployee(employee);
	
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	
%>