package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Notice;

public class NoticeDao {
		public int deleteNotice(Connection conn, int noticeNo) {
			String sql = "DELETE FROM notice WHERE notice_no = ? ";
			
			PreparedStatement stmt = null;
			
			int row = 0;
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, noticeNo);
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
	
		//�� �ۼ�
		public int insertNotice(Connection conn, Notice notice) {
			String sql = "INSERT INTO notice(notice_title,notice_content,update_date,create_date) VALUES ( ? , ? , now() , now() )";
			PreparedStatement stmt = null;
			int row =0;
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, notice.getNoticeTitle());
				stmt.setString(2, notice.getNoticeContent());
				
				row = stmt.executeUpdate();
				System.out.println("notice Insert stmt " + stmt);
				
			}catch(Exception e) {
				try {
					stmt.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
			System.out.println("insert row Ȯ�� : " + row);
			return row;
		}
	
		//�� �����ϱ�
		public int updateNotice(Connection conn, Notice notice) throws Exception {
			String sql = "UPDATE notice SET notice_title = ? , notice_content = ? , update_date = now() WHERE notice_no = ?";
			PreparedStatement stmt = null;
			int row =0;
			try{
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, notice.getNoticeTitle());
				stmt.setString(2, notice.getNoticeContent());
				stmt.setInt(3, notice.getNoticeNo());
				
				row = stmt.executeUpdate();
				System.out.println("update notice stmt Ȯ�� "  + stmt);

			}catch(Exception e) {
				try {
					stmt.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
				
			return row;
		}
	
		//�󼼺���
		public Notice selectNoticeOne(Connection conn, int noticeNo) throws Exception{
			Notice notice = null;
			String sql ="SELECT notice_no , notice_title , notice_content , update_date , create_date FROM notice WHERE notice_no = ?";
			
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1,noticeNo);
				rs = stmt.executeQuery();
				if(rs.next()) {
					notice = new Notice();
					notice.setNoticeNo(rs.getInt("notice_no"));
					notice.setNoticeTitle(rs.getString("notice_title"));
					notice.setNoticeContent(rs.getString("notice_content"));
					notice.setUpdateDate(rs.getString("update_date"));
					notice.setCreateDate(rs.getString("create_date"));
				}
			}finally {
				if(rs!= null) {rs.close();}
				if(stmt!= null) {stmt.close();}
			}
			return notice;
		}
	
	public List<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		List<Notice> list = new ArrayList<Notice>();
		Notice notice = null;
		String sql = "SELECT notice_no , notice_title , notice_content , update_date , create_date FROM notice ORDER BY notice_no DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("notice stmt " + stmt );
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				notice = new Notice();
				//���ֱ�
				notice.setNoticeNo(rs.getInt("notice_no"));
				notice.setNoticeTitle(rs.getString("notice_title"));
				notice.setUpdateDate(rs.getString("update_date"));
				notice.setCreateDate(rs.getString("create_date"));
				
				//list�� �ֱ�
				list.add(notice);
			}
		}finally {
			if(rs !=null) {rs.close();}
			if(stmt != null) {stmt.close();}
		}
		return list;
	}
	
	//�������� ���� ����
	public int NoticeCount(Connection conn) throws Exception {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) count FROM notice"; 
		
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





}
