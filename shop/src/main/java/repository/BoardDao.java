package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Board;

public class BoardDao {
	//글 작성
	public int insertBoard(Connection conn, Board board) {
		String sql = "INSERT INTO board(board_title,board_writer,board_content,create_date) VALUES (? , ? , ? , now() )";
		PreparedStatement stmt = null;
		int row =0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, board.getBoardTitle());
			stmt.setString(2, board.getBoardWriter());
			stmt.setString(3, board.getBoardContent());
			
			row = stmt.executeUpdate();
			System.out.println("board Insert stmt " + stmt);
			
		}catch(Exception e) {
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		System.out.println("insert row 확인 : " + row);
		return row;
	}
	
	//글 수정
	public int updateBoard(Connection conn, Board board) {
		String sql ="UPDATE board SET board_title = ? , board_content = ? WHERE board_no = ?";
		PreparedStatement stmt = null;
		int row = 0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, board.getBoardTitle());
			stmt.setString(2, board.getBoardContent());
			stmt.setInt(3, board.getBoardNo());
			
			row = stmt.executeUpdate();
			System.out.println("update board stmt 확인 : " + stmt);
		}catch(Exception e) {
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		System.out.println("update row 확인 : "  + row );
		return row;
	}
	
	//글 삭제
	public int deleteBoard(Connection conn, int boardNo) {
		String sql = "DELETE FROM board WHERE board_no = ? ";
		
		PreparedStatement stmt = null;
		
		int row = 0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, boardNo);
			row = stmt.executeUpdate();
			
		}catch(Exception e) {
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return row;
	}
	
	//상세보기
	public Board selectBoardOne(Connection conn, int boardNo) throws Exception{
		Board board = null;
		String sql ="SELECT board_no , board_title , board_writer , board_content , create_date FROM board WHERE board_no = ?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1,boardNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				board = new Board();
				board.setBoardNo(rs.getInt("board_no"));
				board.setBoardTitle(rs.getString("board_title"));
				board.setBoardWriter(rs.getString("board_writer"));
				board.setBoardContent(rs.getString("board_content"));
				board.setCreateDate(rs.getString("create_date"));
			}
		}finally {
			if(rs!= null) {rs.close();}
			if(stmt!= null) {stmt.close();}
		}
		return board;
	}
	
	//갯수세기
	public int BoardCount(Connection conn) throws Exception{
		int totalCount = 0;
		String sql = "SELECT COUNT(*) count FROM board"; 
		
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
	
	public List<Board> selectBoardList(Connection conn, int rowPerPage , int beginRow) throws Exception{
		List<Board> list = new ArrayList<Board>();
		Board board = null;
		String sql = "SELECT board_no , board_title , board_writer , create_date FROM board ORDER BY board_no DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1,beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("board stmt : " + stmt);
			rs=stmt.executeQuery();
			while(rs.next()) {
				board = new Board();
				board.setBoardNo(rs.getInt("board_no"));
				board.setBoardTitle(rs.getString("board_title"));
				board.setBoardWriter(rs.getString("board_writer"));
				board.setCreateDate(rs.getString("create_date"));
				
				list.add(board);
			}
		}finally {
			if(rs !=null) {rs.close();}
			if(stmt != null) {stmt.close();}
		}
		
		return list;
	}

	


	
	
}
