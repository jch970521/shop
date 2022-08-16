<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "repository.*" %>
<%@ page import = "service.*" %>
<%@ page import = "java.sql.*" %>
<%

	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}	//로그인체크
	
	request.setCharacterEncoding("UTF-8");
	
	int goodsNo = Integer.parseInt(request.getParameter("goods_no")); 
	String goodsName = request.getParameter("goods_name");
	int goodsPrice = Integer.parseInt(request.getParameter("goods_price"));
	String updateDate = request.getParameter("update_date");
	String createDate = request.getParameter("create_date");
	String soldOut = request.getParameter("sold_out");
	
	Goods goods = new Goods();
	goods.setGoodsNo(goodsNo);
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setUpdateDate(updateDate);
	goods.setCreateDate(createDate);
	goods.setSoldOut(soldOut);
	
	GoodsService service = new GoodsService();
	
	service.updateGoodsOne(goods);
	
	System.out.println(goods);
	
	response.sendRedirect(request.getContextPath()+ "/admin/adminGoodsList.jsp");
%>