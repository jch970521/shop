package service;

import java.util.*;
import repository.*;
import vo.*;
import java.sql.*;

public class OrdersService {
	
	
	//배송현황수정
	public int modifyOrderState(Orders orderState) {
		Connection conn = null;
		int state = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			OrdersDao ordersDao = new OrdersDao();
			state = ordersDao.updateOrderState(conn,orderState);
		
			System.out.println("state" + state);
		
			if(state == 0) { // 
				throw new Exception();
			}
			conn.commit();
		}catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return state;
	}
	
	
	//상세보기
	public Map<String , Object> getOrdersOne(int orderNo){
		Map<String , Object> map =null;
		Connection conn = null;
		OrdersDao ordersDao = new OrdersDao();
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			map = ordersDao.selectOrdersOne(conn, orderNo);
			
			if(map==null) {
				throw new Exception(); // 
			}
			conn.commit();
		}catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return map;
	}
	
	public int lastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		
		OrdersDao ordersDao = new OrdersDao();
		
		try {
			conn = DBUtil.getConnection();
			totalCount = ordersDao.OrdersCount(conn);
			lastPage = totalCount / rowPerPage;
			
			if(totalCount % rowPerPage !=0 ) {
				lastPage +=1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return lastPage;
	}
	
	//고객이 보는 주문페이지
	public List<Map<String,Object>> getOrdersCustomerListByPage(String customerId, int rowPerPage , int currentPage) {
		List<Map<String,Object>> list = null;
		
		Connection conn = null;
		
		OrdersDao ordersDao = new OrdersDao();
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = DBUtil.getConnection();
			
			System.out.println("conn" + conn);
			list = ordersDao.selectOrdersListByCustomer(conn, customerId, rowPerPage, beginRow);
			
			System.out.println("list" + list);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
		
	}
	
	//관리자페이지에서 체크하는 페이지
	public List<Map<String,Object>> getOrdersListByPage(int rowPerPage , int currentPage) {
		List<Map<String,Object>> list = null;
		Connection conn = null;
		
		OrdersDao ordersDao = new OrdersDao();
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = DBUtil.getConnection();
			
			System.out.println("conn" + conn);
			list = ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
			
			System.out.println("list" + list);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
		
	}
}
