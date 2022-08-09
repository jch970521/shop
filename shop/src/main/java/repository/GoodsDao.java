package repository;

import vo.*;
import java.util.*;
import java.sql.*;

public class GoodsDao {
	
	// 반환값 int : key값 (jdbc api)
	public int insertGoods(Connection conn, Goods goods) throws Exception {
		int keyId = 0;
		String sql = "INSERT INTO goods (goods_name , goods_price , sold_out , update_date , create_date) VALUES( ?, ? , ? ,now(),now() ) ";
		PreparedStatement stmt = null;
		// 1) insert가 실행
		// 2) select last_ai_key from .. 
		ResultSet rs =  null; 
		try {
			stmt = conn.prepareStatement(sql , Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			stmt.setString(3, goods.getSoldOut());
			
			stmt.executeUpdate(); // 성공한 수
			
			rs = stmt.getGeneratedKeys(); // select last_key
			
			if(rs.next()) {
				keyId = rs.getInt(1);
			}
		}finally {

		if(rs!=null) {
			rs.close();
		}
		if(stmt!=null) {
			stmt.close();
		}
		
	}
	System.out.println("keyId확인 " + keyId);
	return keyId;

}
	//
	public Map<String, Object> selectGoodsAndImageOne(Connection conn , int goodsNo) throws SQLException {
		Map<String,Object> map = new HashMap<String,Object>();
		
		String sql = "SELECT g.goods_no ,g.goods_name , g.goods_price , g.update_date , g.create_date ,g.sold_out , gi.filename , gi.origin_filename ,gi.content_type FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		rs = stmt.executeQuery();
	
		while(rs.next()) {
			map.put("goodsNo", rs.getInt("g.goods_no"));
			map.put("goodsName",rs.getString("g.goods_name"));
			map.put("goodsPrice", rs.getInt("g.goods_price"));
			map.put("updateDate",rs.getString("g.update_date") );
		    map.put("createDate", rs.getString("g.create_date"));
		    map.put("soldOut",rs.getString("g.sold_out") );
		    map.put("fileName",rs.getString("gi.filename") );
		    map.put("originFilename", rs.getString("gi.origin_filename"));
		    map.put("contentType",rs.getString("gi.content_type") );
		}
		System.out.println("map >> " + map);

		return map;
}	
	
	//마지막페이지
	public int GoodsCount(Connection conn) throws Exception{
		int totalCount = 0;
		String sql = "SELECT COUNT(*) count FROM goods"; // 갯수세기
		
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
	
	//물건리스트
	public List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage , int beginRow) throws Exception{
		List<Goods> list = new ArrayList<Goods>();
		Goods goods = null;
		
		String sql = "SELECT goods_no , goods_name , goods_price , update_date , create_date , sold_out FROM goods ORDER BY goods_no DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
	    
		try {	
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("stmt" + stmt );//stmt확인
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				goods = new Goods();
				goods.setGoodsNo(rs.getInt("goods_no"));
				goods.setGoodsName(rs.getString("goods_name"));
				goods.setGoodsPrice(rs.getInt("goods_price"));
				goods.setUpdateDate(rs.getString("update_date"));
				goods.setCreateDate(rs.getString("create_date"));
				goods.setSoldOut(rs.getString("sold_out"));
				
				list.add(goods); // list에 값 넣기
			}
		}finally {
			if(rs !=null) {rs.close();}
			if(stmt != null) {stmt.close();}
		}
		/*
		  SELECT goods_no GoodsNo
		  FROM goods
		  ORDER BY goods_no DESC
		  LIMIT ?,?
		 */
		
		return list;
	}

}
