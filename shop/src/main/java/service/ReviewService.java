package service;

import repository.*;
import vo.*;
import java.sql.*;

public class ReviewService {
	private ReviewDao reviewDao;
	private DBUtil dbUtil;
	//∏Æ∫‰ ¿€º∫
	public int insertReview(Review review) {
		Connection conn = null;
		int row = 0;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.insertReview(conn, review);
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
		return row;
	}
}
