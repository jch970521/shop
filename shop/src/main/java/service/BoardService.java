package service;

import java.util.*;
import repository.*;
import vo.*;
import java.sql.*;

public class BoardService {
	private BoardDao boardDao;
	private DBUtil dbUtil;
	//글삭제
	public void deleteBoard(int boardNo) {
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			BoardDao boardDao = new BoardDao();
			boardDao.deleteBoard(conn, boardNo);
			
			System.out.println("boardNo 값 확인 " + boardNo);
			
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
	}
	
	//상세보기
	public Board getBoardOne(int boardno) {
		Board board = null;
		Connection conn = null;
		this.boardDao = new BoardDao();
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			board = boardDao.selectBoardOne(conn, boardno);
			
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
		
		return board;
	}
	//lastPage
	public int lastPage(int rowPerPage){
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		
		this.boardDao = new BoardDao();
		
		try {
			conn = new DBUtil().getConnection();
			totalCount = boardDao.BoardCount(conn);
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
	
	
	public List<Board> getBoardList(int rowPerPage , int currentPage){
		List<Board> list = null;
		Connection conn = null;
		
		this.boardDao = new BoardDao();
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = this.dbUtil.getConnection();
			
			System.out.println("boardService conn 확인 " + conn);
			
			list = this.boardDao.selectBoardList(conn, rowPerPage, beginRow);
			
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
