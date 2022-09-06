<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}// 정보가 맞지않으면 로그인창으로

	int goodsNo = Integer.parseInt(request.getParameter("goods_no"));
	int goodsPrice = Integer.parseInt(request.getParameter("goods_price"));
	String customerId = (String)session.getAttribute("id");
	int orderQuantity = Integer.parseInt(request.getParameter("order_quantity"));
	String orderAddress = request.getParameter("orders_address");
	OrdersDao ordersDao = new OrdersDao();
	Orders orders = new Orders();
	
	orders.setGoodsNo(goodsNo);
	orders.setOrderPrice(goodsPrice*orderQuantity);
	orders.setCustomerId(customerId);
	orders.setOrderQuantity(orderQuantity);
	orders.setOrderAddress(orderAddress);

	//값 확인용		
	System.out.println(goodsNo);
	System.out.println(goodsPrice);
	System.out.println(customerId);
	System.out.println(orderQuantity);
	System.out.println(orderAddress);

	OrdersService service = new OrdersService();
	service.insertOrder(orders);

	response.sendRedirect(request.getContextPath() + "/OrdersList.jsp");
%>
