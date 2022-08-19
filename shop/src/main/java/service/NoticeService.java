package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import repository.BoardDao;
import repository.DBUtil;
import repository.NoticeDao;
import vo.Board;
import vo.Notice;

public class NoticeService {
	private NoticeDao noticeDao;
	private DBUtil dbUtil;
	
	//글 작성
		public int insertNotice(Notice notice) {
			Connection conn = null;
			int row = 0;
			try {
				conn = new DBUtil().getConnection();
				conn.setAutoCommit(false);
				
				NoticeDao noticeDao = new NoticeDao();
				noticeDao.insertNotice(conn, notice);
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
	
	//글 수정
	public int updateNotice(Notice notice) {
		Connection conn = null;
		int row=0;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			NoticeDao noticeDao = new NoticeDao();
			noticeDao.updateNotice(conn, notice);
			
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
	
	//상세보기
		public Notice getNoticeOne(int noticeno) {
			Notice notice = null;
			Connection conn = null;
			this.noticeDao = new NoticeDao();
			try {
				conn = new DBUtil().getConnection();
				conn.setAutoCommit(false);
				
				notice = noticeDao.selectNoticeOne(conn, noticeno);
				
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
			
			return notice;
		}
	
	//lastPage
		public int lastPage(int rowPerPage){
			int lastPage = 0;
			int totalCount = 0;
			Connection conn = null;
			
			this.noticeDao = new NoticeDao();
			
			try {
				conn = new DBUtil().getConnection();
				totalCount = noticeDao.NoticeCount(conn);
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
		
		
		public List<Notice> getNoticeList(int rowPerPage , int currentPage){
			List<Notice> list = null;
			Connection conn = null;
			
			this.noticeDao = new NoticeDao();
			
			int beginRow = (currentPage - 1) * rowPerPage;
			
			try {
				conn = this.dbUtil.getConnection();
				
				System.out.println("boardService conn 확인 " + conn);
				
				list = this.noticeDao.selectNoticeList(conn, rowPerPage, beginRow);
				
				System.out.println("boardList 확인 " + list);
				
				
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
