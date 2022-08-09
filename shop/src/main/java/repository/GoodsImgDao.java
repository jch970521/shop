package repository;
import vo.*;
import java.util.*;
import java.sql.*;

public class GoodsImgDao {
	public int insertGoodsImg(Connection conn, GoodsImg goodsImg) throws Exception {
		int result = 0;
		String sql = "INSERT INTO goods_img (goods_no, filename, origin_filename, content_type, create_date) VALUES (?,?,?,?,NOW())";
		
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsImg.getGoodsNo());
			stmt.setString(2, goodsImg.getFileName());
			stmt.setString(3, goodsImg.getOriginFileName());
			stmt.setString(4, goodsImg.getContentType());
			
			result = stmt.executeUpdate();
			
		}finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		System.out.println("result 확인 " + result);
		return result;
	}
}
