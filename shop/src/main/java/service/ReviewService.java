package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.BoardDao;
import repository.DBUtil;
import repository.ReviewDao;
import vo.Review;

public class ReviewService {
	private ReviewDao reviewDao;
	private DBUtil dbUtil;
	//리뷰 리스트
	public List<Map<String, Object>> getReviewList(int rowPerPage, int currentPage){
		List<Map<String, Object>> list = null;
		Connection conn = null;
		
		this.reviewDao = new ReviewDao();
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try{
			conn = this.dbUtil.getConnection();
			
			System.out.println("reviewService conn 확인 " + conn);
			
			list = this.reviewDao.selectReviewList(conn, rowPerPage, beginRow);
			
			System.out.println("reviewList 확인 " + list);
		}catch(Exception e){
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
	
	//lastPage
	public int lastPage(int rowPerPage){
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		
		this.reviewDao = new ReviewDao();
		try {
			conn = new DBUtil().getConnection();
			totalCount = reviewDao.ReviewCount(conn);
			lastPage = totalCount / rowPerPage; 
			
			if(totalCount % rowPerPage != 0) {
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
	
	//리뷰 작성
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
