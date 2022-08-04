<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%@ page import = "service.*" %>
<%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	String Id = request.getParameter("id");
	String Pw = request.getParameter("pw");

	//확인용
	System.out.println(Id);
	System.out.println(Pw);
	
	if(Id==null || Pw == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} // 로그인x면 로그인창으로 보내기
	
	Employee empolyee = new Employee();
	empolyee.setEmployeeId(Id);
	empolyee.setEmployeePass(Pw);

	
	//확인용
	System.out.print(empolyee.getEmployeeId());
	System.out.print(empolyee.getEmployeePass());
	
	EmployeeService service = new EmployeeService();
	service.removeEmployee(empolyee);

	// Serivce에 customer 담기 여기서 OutIdDao랑 CustomerDao가 같이 실행됨
	// 메서드를 따로 두번 out , delete를 해주지않아도 service에서 처리해주는 ..?
	
	
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	
	
%>