package repository;


import java.sql.*;
import java.util.*;

import vo.Review;

public class ReviewDao {
	//리뷰 작성
	public int insertReview(Connection conn, Review review ) {
		String sql = "INSERT INTO review( review_content , update_date , create_date) VALUES ( ? , now() , now() )";
		PreparedStatement stmt = null;
		int row = 0;
		
		try {
			conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, review.getReviewContent());
			
			row = stmt.executeUpdate();
			
			//System.out.println("review insert stmt : " + stmt);
			}catch(Exception e) {
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		System.out.println("insert row 확인 : " + row );
		return row;
	}
	
	
	//갯수 세기
	public int ReviewCount(Connection conn) throws Exception{
		int totalCount = 0;
		String sql = "SELECT COUNT(*) count FROM review"; 
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				totalCount = rs.getInt("count");
			}
		}finally {
			if(rs!= null) {rs.close();}
			if(stmt!= null) {stmt.close();}
		}
		
		return totalCount;
	}
	
	//리뷰 리스트 
	public List<Map<String, Object>> selectReviewList(Connection conn,int rowPerPage, int beginRow) throws Exception {
		List<Map<String, Object>> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();

		String sql = "SELECT goods_no , goods_name , customer_id , review_content , r.create_date FROM orders INNER JOIN review r USING(order_no) INNER JOIN goods USING(goods_no) ORDER BY goods_no LIMIT ?, ?;";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1,beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("review stmt : " + stmt);
			
			rs=stmt.executeQuery();
			while(rs.next()) {
				//map에담기
				map.put("goodsNo", rs.getInt("goods_no"));
				map.put("goodsName", rs.getString("goods_name"));
				map.put("customerId", rs.getString("customer_id"));
				map.put("reviewContent", rs.getString("review_content"));
				map.put("createDate", rs.getString("create_date"));

				// list에 담기
				list.add(map);
			}
		}finally {
			if(rs !=null) {rs.close();}
			if(stmt != null) {stmt.close();}
		}
		
		return list;
	}
}