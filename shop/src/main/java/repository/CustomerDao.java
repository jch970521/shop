package repository;
import java.sql.*;
import vo.*;

public class CustomerDao {
		// 탈퇴
		// CustomerService.removeCustomer(Customer paramCustomer)가 호출 
	
	public int deleteCustomer(Connection conn, Customer paramCustomer) {
		// 동일한 conn
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM customer WHERE customer_id =? AND customer_pass =password(?)";
		int row = 0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			row = stmt.executeUpdate();
		} catch(Exception e){
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		// conn.close() X
		return row;
		
	}
	
	//CustomerService가 호출해줄것.
	public Customer selectCustomerByIdAndPw(Connection conn , Customer customer) throws Exception{
		Customer loginCustomer = null;
		String sql ="SELECT customer_id , customer_name FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?);";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
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
			if(rs!= null) {rs.close();}
			if(stmt!= null) {stmt.close();}
		}
		return loginCustomer;
	}
	
}
