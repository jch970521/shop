package service;

import java.sql.*;
import java.util.*;

import repository.*;
import vo.*;

public class CustomerService {
	private CustomerDao customerDao;
	private DBUtil dbUtil;
	//ºñ¹Ð¹øÈ£ ¼öÁ¤
	public int updateCustomerPw(Customer customer) {
		Connection conn = null;
		int row = 0;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			CustomerDao customerDao = new CustomerDao();
			customerDao.updateCustomerPw(conn, customer);
			
			conn.commit();
		}catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}finally {
				try {
					conn.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
		}
		return row;
	}
	
	//°­Á¦Å»Åð
	public void deleteCustomerId(Customer customer) {
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			CustomerDao customerDao = new CustomerDao();
			customerDao.deleteCustomerId(conn, customer);
			
			OutIdDao OutIdDao = new OutIdDao();
			OutIdDao.insertOutId(conn, customer.getCustomerId());
			
			System.out.println("customer " + customer);
			
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
	public int lastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount =0;
		
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.customerDao = new CustomerDao();
		
		try {
			conn = this.dbUtil.getConnection();
			
			totalCount = this.customerDao.CountCustomer(conn);
			
			lastPage = totalCount / rowPerPage ;
			
			if(totalCount % rowPerPage !=0) {
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
	

	public List<Customer> getCustomerList(int rowPerPage , int currentPage){
		Connection conn = null;
		List<Customer> list = null;
		
		int beginRow = (currentPage-1) * rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			
			conn.setAutoCommit(false);
			
			CustomerDao customerDao = new CustomerDao();
			
			list = customerDao.selectCustomerList(conn, rowPerPage, beginRow);
			
			conn.commit();
		}catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}finally {
				try {
					conn.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
		}
		
		return list;
	}
	

	public List<Map<String, Object>> getCustomerGoodsListByPage(int rowPerPage, int currentPage){
		

		
		return null;
	}
	

	public void insertCustomer(Customer paramCustomer) {
		Connection conn = null;
				
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			CustomerDao customerDao = new CustomerDao();
			customerDao.insertCustomer(conn, paramCustomer);
			
			conn.commit();
		}catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
	}
	
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
				conn.setAutoCommit(false); 
				
				CustomerDao customerDao = new CustomerDao();
				customerDao.deleteCustomer(conn, paramCustomer);
				
				OutIdDao OutIdDao = new OutIdDao();
				OutIdDao.insertOutId(conn, paramCustomer.getCustomerId());
				
				conn.commit();
			} catch(Exception e) {
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
}
