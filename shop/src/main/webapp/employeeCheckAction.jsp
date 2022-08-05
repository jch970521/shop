<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%@ page import = "service.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String ckId = request.getParameter("ckId");

	System.out.println(ckId); // 값 넘어오는지 확인
	
	SignService ck = new SignService();

	System.out.println(ck.idCheck(ckId));
	
	SignService sign = new SignService();
	
	sign.idCheck(ckId);
	
	//service -> false
	if(sign.idCheck(ckId) == false){
	response.sendRedirect(request.getContextPath()+"/addemployee.jsp?errMsg=badId");
	} else {
	//service -> true
	response.sendRedirect(request.getContextPath()+"/addemployee.jsp?ckId="+ckId);
	}
%>