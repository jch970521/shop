package service;
import java.sql.*;
import repository.*;
import vo.*;

public class EmployeeService {
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
