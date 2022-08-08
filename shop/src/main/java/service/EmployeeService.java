package service;

import java.sql.*;
import repository.*;
import vo.*;
import java.util.*;

public class EmployeeService {
	private DBUtil dbUtil;
	private EmployeeDao employeeDao;

	//active값 수정하기
	public int modifyEmployeeActive(Employee employeeActive) {
		
		Connection conn = null;
		int active = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			EmployeeDao employeeDao = new EmployeeDao();
			active = employeeDao.updateEmployeeActive(conn,employeeActive);
			
			System.out.print("active" + active);
		
			if(active == 0) { // active가 0이면 예외처리 
				throw new Exception();
			}
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
		} try {
			conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return active;
	}
	
	
	
	public int lastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount =0;
		
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.employeeDao = new EmployeeDao();
		
		try {
			conn = this.dbUtil.getConnection();
			
			totalCount = this.employeeDao.CountEmployee(conn);
			
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
	
	public List<Employee> getEmployeeList(final int rowPerPage, final int currentPage) {
		Connection conn = null;
		List<Employee> list = null;
		
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			
			System.out.println("EmployeeService.java getEmployeeList conn : " + conn);

			conn.setAutoCommit(false);
			
			EmployeeDao employeeDao = new EmployeeDao();
			
			list = employeeDao.selectEmployeeList(conn ,rowPerPage ,beginRow ) ;
			
			conn.commit();
		}catch(Exception e){
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
		
		return list;
		
	}
	
	
	public void insertEmployee(Employee paramEmployee) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			EmployeeDao employeeDao = new EmployeeDao();
			employeeDao.insertEmployee(conn, paramEmployee);
			
			conn.commit();
		}catch(Exception e) {
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
	public Employee login(Employee paramEmployee) {
		Connection conn = null;
		Employee employee = new Employee();
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			EmployeeDao employeeDao = new EmployeeDao();
			employee = employeeDao.selectEmployeeByIdAndPw(conn, paramEmployee);
			
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
		return employee;
	}
	
	public void removeEmployee(Employee paramEmployee) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			EmployeeDao employeeDao = new EmployeeDao();
			employeeDao.deleteEmployee(conn, paramEmployee);
			
			OutIdDao OutIdDao = new OutIdDao();
			OutIdDao.insertOutId(conn, paramEmployee.getEmployeeId());
			
			conn.commit();
		} catch(Exception e) {
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
