package repository;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.*;

public class OutIdDao {
	
	// CustomerService.removeCustomer(Customer paramCustomer)
	public int insertOutId(Connection conn, String customerId) {
		// conn
		conn = null;
		PreparedStatement stmt = null;
		int row =0;
		String sql = "INSERT INTO outid( out_id, out_date ) VALUES ( ? , now() )";
		try {
			conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			
			row = stmt.executeUpdate();
		} catch (Exception e){
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		// conn.close() X
		return 0;
	}
}

