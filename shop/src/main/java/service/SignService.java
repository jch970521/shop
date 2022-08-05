package service;
import java.sql.*;
import repository.*;
import vo.*;

public class SignService {
	private SignDao signDao;
	// return
	// true -> 사용가능한 아이디 
	// false -> 사용불가 
	
	public boolean idCheck(String id) {
		boolean result = false;
		this.signDao = new SignDao();
		
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			
			if(signDao.idCheck(conn, id) == null) {
				result = true;
			};
			conn.commit();
			
		}catch (Exception e) {
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
	
		return result;
		
	}
}
