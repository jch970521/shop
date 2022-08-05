package repository;
import java.sql.*;
import vo.*;
import service.*;

public class SignDao {
	
	
	public String idCheck(Connection conn , String id) throws Exception {//서비스에서 Connection 을 받아옴
		String ckId = null;
		
		PreparedStatement stmt = null;
		String sql="SELECT t.id FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ? ";
		ResultSet rs = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, id);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				ckId = id;
			}
		}finally {
			if(rs != null) {rs.close();}
			if(stmt !=null) {stmt.close();}
		}
		
		/*
		  SELECT t.id
		  FROM 	(SELECT customer_id id FROM customer
		  		UNION
		  		SELECT employee_id id FROM employee
		  		UNION
		  		SELECT out_id id FROM out_id) t	
		  WHERE t.id = ? 
		  
		  고객/직원/탈퇴한id 중 없을경우에만 ckId 가 가능.
		 */
		return ckId;
	}
}
