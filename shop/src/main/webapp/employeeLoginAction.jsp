<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
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
	
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePw);

	System.out.println(employee.getEmployeeId());
	System.out.println(employee.getEmployeePass());
	
	EmployeeDao employeeDao = new EmployeeDao();
	Employee loginEmployee = employeeDao.login(employee);
	
	if(loginEmployee == null ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} else {
		session.setAttribute("id", loginEmployee.getEmployeeId());
		session.setAttribute("name", loginEmployee.getEmployeeName());
		session.setAttribute("user", "Employee");
	}
	
	session.setAttribute("loginEmployee", loginEmployee);
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>