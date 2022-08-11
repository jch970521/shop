package repository;

import java.sql.*;
import java.util.*;
import vo.*;

public class OrdersDao {
	//배송현황 수정
	public int updateOrderState(Connection conn, Orders orderState) {
		String sql = "UPDATE orders SET order_state = ? WHERE order_no = ?";
		PreparedStatement stmt = null;
		int row = 0;
		
		try {
			stmt =conn.prepareStatement(sql);
			stmt.setString(1, orderState.getOrderState());
			stmt.setInt(2, orderState.getOrderNo());
			
			row = stmt.executeUpdate();
			System.out.println("stmt 확인:" + stmt);
		}catch(Exception e) {
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
		System.out.println("row확인 : " + row);
		return row;
	}
	
	
	// 5-2 주문 상세 보기
	public Map<String,Object> selectOrdersOne(Connection conn, int ordersNo) throws SQLException {
		Map<String,Object> map = new HashMap<String,Object>();
		
		String sql = "SELECT o.order_no , o.order_quantity , o.order_address , o.order_state , o.update_date , o.create_date , g.goods_no , g.goods_name , g.goods_price , c.customer_id , c.customer_name , c.customer_address , c.customer_telephone FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_id = c.customer_id WHERE o.order_no = ? " ;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		stmt = conn.prepareStatement(sql);	
		stmt.setInt(1, ordersNo);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			map.put("orderNo", rs.getInt("o.order_no"));
			map.put("orderQuantity", rs.getInt("o.order_quantity"));
			map.put("orderAddress", rs.getString("o.order_address"));
			map.put("updateDate", rs.getString("o.update_date"));
			map.put("createDate", rs.getString("o.create_date"));
			map.put("goodsNo", rs.getInt("g.goods_no"));
			map.put("goodsName" , rs.getString("g.goods_name"));
			map.put("goodsPrice", rs.getInt("g.goods_price"));
			map.put("customerId", rs.getString("c.customer_id"));
			map.put("customerName" , rs.getString("c.customer_name"));
			map.put("customerAddress", rs.getString("c.customer_address"));
			map.put("customerTelephone", rs.getString("c.customer_telephone"));
			
		}
		System.out.println("map 확인 " + map);
		/*
		  SELECT
		  	o. ,
		  	g. ,
		  	c. ,
		  FROM orders o INNER JOIN goods g
		  ON o.goods_no = g.goods_no
		  							INNER JOIN cutomer c
		  							ON o.customer_id = c.customer_id
		 WHERE o.orders_no = ?
		  
		 */
		
		return map;
	}
	
	// 5-1 전체 주문 목록 ( 관리자 )
	public List<Map<String,Object>> selectOrdersList(Connection conn, int rowPerPage , int beginRow ) throws Exception{
			List<Map<String,Object>> list = new ArrayList<>(); // 다형성 , 디커플링
			Map<String,Object> map = new HashMap<>();
			
			String sql = "SELECT o.order_no , o.customer_id , o.order_quantity , o.order_price , o.order_address , o.order_state , o.update_date , o.create_date , g.goods_no , g.goods_name , g.goods_price FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY create_date DESC LIMIT ? , ?";
			
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
				
				System.out.println("주문목록 stmt " + stmt); //확인
				
				rs = stmt.executeQuery();
				
				while(rs.next()) {
					map.put("orderNo", rs.getInt("o.order_no"));
					map.put("customerId", rs.getString("o.customer_id"));
					map.put("orderQuantity", rs.getInt("o.order_quantity"));
					map.put("orderPrice", rs.getInt("o.order_price"));
					map.put("orderAddress", rs.getString("o.order_address"));
					map.put("orderState", rs.getString("o.order_state"));
					map.put("updateDate", rs.getString("o.update_date"));
					map.put("createDate", rs.getString("o.create_date"));
					map.put("goodsNo", rs.getInt("g.goods_no"));
					map.put("goodsName", rs.getString("g.goods_name"));
					map.put("goodsPrice", rs.getInt("g.goods_price"));
					
					list.add(map);
				}
				System.out.println("리스트 확인 "+ list);
				System.out.println("맵 확인" + map);
			}finally {
				if(rs !=null) {rs.close();}
				if(stmt != null) {stmt.close();}
			}
			/*
			  SELECT 
			  o. ,
			  g. ,
			  FROM orders o INNER JOIN goods g
			  ON o.goods_no = g.goods_no
			  ORDER BY create_date DESC
			  LIMIT ? , ?
			 */
			
			return list;
	}
	
	// 2-1 ) 고객 한명의 주문 목록(관리자 , 고객)
	public List<Map<String,Object>> selectOrdersListByCustomer(Connection conn, String customerId , int rowPerPage , int beginRow) throws Exception{
		List<Map<String,Object>> list = new ArrayList<>(); // 다형성 , 디커플링
		Map<String,Object> map = new HashMap<String, Object>();
		
		String sql = "SELECT o.oredr_no , o.customer_id , o.order_quantity , o.order_price , o.order_address , o.order_state , o.update_date , o.create_date ,g.goods_no , g.goods_name , g.goods_price FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no  WHERE customer_id = ? ORDER BY create_date DESC LIMIT ? , ?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1,beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			
			map.put("orderNo", rs.getInt("o.order_no"));
			map.put("customerId", rs.getString("o.customer_id"));
			map.put("orderQuantity", rs.getInt("o.order_quantity"));
			map.put("orderPrice", rs.getInt("o.order_price"));
			map.put("orderAddress", rs.getString("o.order_address"));
			map.put("orderState", rs.getString("o.order_state"));
			map.put("updateDate", rs.getString("o.update_date"));
			map.put("createDate", rs.getString("o.create_date"));
			map.put("goodsNo", rs.getInt("g.goods_no"));
			map.put("goodsName", rs.getString("g.goods_name"));
			map.put("goodsPrice", rs.getInt("g.goods_price"));
			
			list.add(map);
		}finally {
			if(rs!=null) {rs.close();}
			if(stmt!=null) {stmt.close();}
		}
		
		/*
		  	
		/*
		  SELECT 
		  o.order_no , o.customer_id , o.order_quantity , o.order_price , o.order_address , o.order_state , o.update_date , o.create_date,
		  g.goods_no , g.goods_name, g.goods_price
		  FROM orders o INNER JOIN goods g
		  ON o.goods_no = g.goods_no
		  WHERE customer_id = ?
		  ORDER BY create_date DESC
		  LIMIT ? , ?
		 */
		
		return list;
	}

	//페이지
	public int OrdersCount(Connection conn) throws Exception {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM orders"; // 개수세기
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				totalCount = rs.getInt("COUNT(*)");
			}
		}finally {
			if(rs!= null) {rs.close();}
			if(stmt!= null) {stmt.close();}
		}
		return totalCount;
	}

	
}
