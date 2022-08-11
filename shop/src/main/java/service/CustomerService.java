package service;

import java.sql.*;
import java.util.*;

import repository.*;
import vo.*;

public class CustomerService {
	private CustomerDao customerDao;
	private DBUtil dbUtil;
	
	public int lastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount =0;
		
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.customerDao = new CustomerDao();
		
		try {
			conn = this.dbUtil.getConnection();
			
			totalCount = this.customerDao.CountCustomer(conn);
			
			lastPage = totalCount / rowPerPage ; //마지막페이지 구하기
			
			if(totalCount % rowPerPage !=0) {//나머지가 0이아닐떄 페이지1장추가
				lastPage +=1;
			}
		}catch(Exception e) { // 오류잡기
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
	
	//리스트
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
	
	//페이징
	public List<Map<String, Object>> getCustomerGoodsListByPage(int rowPerPage, int currentPage){
		
		//customerDao 호출
		
		return null;
	}
	
	////고객 추가
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
