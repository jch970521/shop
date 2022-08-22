package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.Review;

public class ReviewDao {
	public int insertReview(Connection conn, Review review ) {
		
		conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		
		String sql = "INSERT INTO review( review_content , update_date , create_date) VALUES ( ? , now() , now() )";
		try {
			conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, review.getReviewContent());
		}catch(Exception e) {
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return row;
	}
}