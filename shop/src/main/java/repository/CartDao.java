package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Cart;

public class CartDao {
	//상품 담기
	public int insertCart(Connection conn, Cart cart) throws Exception{
		
		int row = 0;
		String sql = "INSERT INTO CART (goods_no , customer_id, cart_quantity , update_date ,  create_date ) VALUES ( ? , ? , ? , now() , now() ) ";
		
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1,cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			stmt.setInt(3, cart.getCartQuantity());
			
			System.out.println("insertCart stmt 확인 : " + stmt);
			
			row = stmt.executeUpdate();
		}finally {
			stmt.close();
		}
		return row;
	}

	//카트 리스트
	public List<Map<String, Object>> selectCartListById(Connection conn, Cart cart) throws Exception {
		List<Map<String,Object>> list = new ArrayList<>();
		Map<String,Object> map = new HashMap<>();
		
		String sql = "SELECT goods_no , goods_name , cart_quantity , goods_price FROM cart INNER JOIN goods USING(goods_no) WHERE customer_id = ?";
		
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cart.getCustomerId());
			
			System.out.println("CartList stmt " + stmt);
			
			rs=stmt.executeQuery();
			
			while(rs.next()) {
				map.put("goodsNo", rs.getInt("goods_no"));
				map.put("goodsName" , rs.getString("goods_name"));
				map.put("cartQuantity", rs.getInt("cart_quantity"));
				map.put("goodsPrice", rs.getInt("goods_price"));
				
				list.add(map);
			}
		}finally {
			if(rs !=null) {rs.close();}
			if(stmt != null) {stmt.close();}
		}
		return list;
	}
}
