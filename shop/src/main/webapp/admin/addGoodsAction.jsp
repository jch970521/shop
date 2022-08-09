<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.multipart.*"%>
<%@ page import = "com.oreilly.servlet.*"%>
<%@ page import = "service.*"%>
<%@ page import = "vo.*"%>
<%@ page import ="java.io.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String dir = request.getServletContext().getRealPath("/upload");

	int max = 10 * 1024 * 1024 ; // 크기제한
	
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	
	String goodsName = mRequest.getParameter("goodsName");
	int goodsPrice = Integer.parseInt(mRequest.getParameter("goodsPrice"));
	String soldOut = mRequest.getParameter("soldOut");
	
	String contentType = mRequest.getContentType("imgFile");
	String originFilename = mRequest.getOriginalFileName("imgFile");
	String filename = mRequest.getFilesystemName("imgFile");
	
	// 디버깅
	System.out.println(dir + " <-- dir");
	System.out.println(goodsName + " <-- goodsName");
	System.out.println(goodsPrice + " <-- goodsPrice");
	System.out.println(soldOut + " <-- soldOut");
	System.out.println(contentType + " <-- 마임타입");
	System.out.println(originFilename + " <-- 원본 파일이름");
	System.out.println(filename + " <-- 새로 만들어진 파일이름");
	
	//세팅
	Goods goods = new Goods();
	GoodsImg goodsImg = new GoodsImg();
	
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
	
	goodsImg.setContentType(contentType);
	goodsImg.setOriginFileName(originFilename);
	goodsImg.setFileName(filename);
	
	//이미지인지 검사 후 파일 삭제
	if(!(contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg"))){
		// 이미지가 아닌 파일 삭제
		File f = new File(dir + "/" + filename);
		
		if(f.exists()){
			f.delete(); // return boolean
		}
		
		response.sendRedirect(request.getContextPath() + "/admin/addGoodsForm.jsp");
		return;
	}
	
	//service 호출
	GoodsService goodsService = new GoodsService();
	int goodsNo = goodsService.addGoods(goods, goodsImg);
	
	if(goodsNo ==0){
		//실패 시 이미지 삭제
		File f = new File(dir + "\\" + filename);
		if(f.exists()){
			f.delete();
		}
		response.sendRedirect(request.getContextPath() + "/admin/addGoodsForm.jsp");
		
	}else{
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
	}
%>











