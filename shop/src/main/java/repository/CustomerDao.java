package repository;
import java.sql.*;
import java.util.*;
import vo.*;

public class CustomerDao {
	
	// 비밀번호 수정(관리자 측에서 수정)
	public int updateCustomerPw(Connection conn, Customer customer) {
		String sql = "UPDATE customer SET customer_pass = password(?) WHERE customer_id = ?";
		PreparedStatement stmt = null;
		
		int row = 0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerPass());
			stmt.setString(2, customer.getCustomerId());
		
			row = stmt.executeUpdate();
			System.out.println("stmt 확인" + stmt);
		}catch(Exception e) {
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		System.out.println("row 확인" + row);
		return row;
	}
	// 강제탈퇴 (관리자측에서 탈퇴)
	public int deleteCustomerId(Connection conn, Customer customer) {
		String sql = "DELETE FROM customer WHERE customer_id = ?";
		
		PreparedStatement stmt = null;
		
		int row = 0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
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
	
	public List<Customer> selectCustomerList(Connection conn, int rowPerPage , int beginRow) throws Exception{
		List<Customer> customerList = new ArrayList<>();
		Customer customer = null;
		String sql = "SELECT customer_id , customer_name , customer_address , customer_telephone , update_date , create_date FROM customer ORDER BY create_date DESC LIMIT ?,? ";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			customerList = new ArrayList<Customer>();
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("CustomerDao selectCustomerList stmt " + stmt);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				customer = new Customer();
				customer.setCustomerId(rs.getString("customer_id"));
				customer.setCustomerName(rs.getString("customer_name"));
				customer.setCustomerAddress(rs.getString("customer_address"));
				customer.setCustomerTelephone(rs.getString("customer_telephone"));
				customer.setUpdateDate(rs.getString("update_date"));
				customer.setCreateDate(rs.getString("create_date"));
				
				customerList.add(customer);
			}
		}finally {
			if(rs !=null) { rs.close(); }
			if(stmt != null) {stmt.close();}
		}
		return customerList;
	}
	
	public int insertCustomer(Connection conn, Customer Customer) {
	
		PreparedStatement stmt = null;
		String sql ="INSERT INTO customer( customer_id , customer_pass , customer_name , customer_address , customer_telephone , update_date , create_date ) VALUES ( ? , password(?) , ? , ? , ? , now() , now() )";
		
		int row = 0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, Customer.getCustomerId());
			stmt.setString(2, Customer.getCustomerPass());
			stmt.setString(3, Customer.getCustomerName());
			stmt.setString(4, Customer.getCustomerAddress());
			stmt.setString(5, Customer.getCustomerTelephone());
			
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
	
	
	// CustomerService.removeCustomer(Customer paramCustomer)
		
	public int deleteCustomer(Connection conn, Customer paramCustomer) {
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

	public int CountCustomer(Connection conn) throws Exception {
		int lastPage = 0;
		String sql = "SELECT COUNT(*) count FROM customer"; 
		
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if(rs.next()) {
				lastPage = rs.getInt("count");
			}
		}finally {
			if(rs!= null) {rs.close();}
			if(stmt!= null) {stmt.close();}
		}
		
		return lastPage;
	}

	
	
}
