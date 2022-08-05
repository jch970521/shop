package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.*;

public class EmployeeDao {
	//회원가입
	public int insertEmployee(Connection conn, Employee Employee) {
		PreparedStatement stmt = null;
		String sql = "INSERT INTO employee ( employee_id , employee_pass , employee_name , update_date , create_date) VALUES ( ? , password(?) , ? , now() , now() )";
	
		int row = 0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, Employee.getEmployeeId());
			stmt.setString(2, Employee.getEmployeePass());
			stmt.setString(3, Employee.getEmployeeName());
	
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
	
	public int deleteEmployee(Connection conn, Employee paramEmployee) {
		// 동일한 conn
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM employee WHERE employee_id =? AND employee_pass =password(?)";
		int row = 0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
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
	
	
	public Employee selectEmployeeByIdAndPw(Connection conn , Employee employee) throws Exception{
		Employee loginEmployee = null;
		String sql ="SELECT employee_id , employee_name , active FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?) AND active = 'Y' ;";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			rs = stmt.executeQuery();
			
			loginEmployee = new Employee();

			if(rs.next()) {
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employee_id"));
				loginEmployee.setEmployeeName(rs.getString("employee_name"));
				loginEmployee.setActive(rs.getString("active"));
			}
		}finally {
			if(rs!= null) {rs.close();}
			if(stmt!= null) {stmt.close();}
		}
		return loginEmployee;
	}
}
