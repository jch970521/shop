package model;
import java.sql.*;
import vo.*;

public class CustomerDao {
	public Customer login(Customer customer) throws Exception{
		Customer loginCustomer = null;
		Connection conn = null;
		String sql ="SELECT customer_id , customer_name FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?);";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			DBUtil dbUtil = new DBUtil();
			conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				loginCustomer = new Customer();
				loginCustomer.setCustomerId(rs.getString("customer_id"));
				loginCustomer.setCustomerName(rs.getString("customer_name"));
			}
		}finally {
			rs.close();
			stmt.close();
			conn.close();
		}
		return loginCustomer;
	}
	
}
