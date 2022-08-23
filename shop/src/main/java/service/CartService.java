package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import repository.DBUtil;
import vo.Cart;

public class CartService {
	private CartDao cartDao;
	private DBUtil dbUtil;
	//카트 리스트
	public List<Map<String,Object>> getCartListById(Cart cart){
		List<Map<String,Object>> list = null;
		Connection conn = null;
		
		cartDao = new CartDao();
	

		try {
			conn = dbUtil.getConnection();
			
			System.out.println("CartList conn 확인 : " + conn);
			
			list = this.cartDao.selectCartListById(conn, cart);
			
			System.out.println("cartList 확인 : "  + list);
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
	
	//카트에 물건 넣기
	public int addCart(Cart cart) {
		int item = 0;
		
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			cartDao = new CartDao();
			
			item = cartDao.insertCart(conn, cart);
			
			System.out.println("item 확인 : "+ item);
			
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
		return item;
	}
}
