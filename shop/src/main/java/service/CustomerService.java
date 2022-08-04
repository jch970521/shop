package service;

import java.sql.*;
import repository.*;
import vo.*;

public class CustomerService {
	public Customer login(Customer paramCustomer) {
		Connection conn = null;
		Customer customer= new Customer();
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			CustomerDao customerDao = new CustomerDao();
			customer = customerDao.selectCustomerByIdAndPw(conn, paramCustomer);
			
			conn.commit();
		}catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
			try {
				conn.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return customer;
	}
		public void removeCustomer(Customer paramCustomer){
			Connection conn = null;
			try {
				conn = new DBUtil().getConnection();
				conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음.
				
				CustomerDao customerDao = new CustomerDao();
				customerDao.deleteCustomer(conn, paramCustomer);
				
				OutIdDao OutIdDao = new OutIdDao();
				OutIdDao.insertOutId(conn, paramCustomer.getCustomerId());
				
				conn.commit();
			} catch(Exception e) {
				e.printStackTrace(); // 콘솔에 예외메세지 출력해주는거(무슨예외인지 알 수 있음)
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
}
