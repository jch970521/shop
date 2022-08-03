package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.*;

public class EmployeeDao {
	public Employee login(Employee employee) throws Exception{
		Employee loginEmployee = null;
		Connection conn = null;
		String sql ="SELECT employee_id , employee_name FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?);";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			DBUtil dbUtil = new DBUtil();
			conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employee_id"));
				loginEmployee.setEmployeeName(rs.getString("employee_name"));
			}
		}finally {
			rs.close();
			stmt.close();
			conn.close();
		}
		return loginEmployee;
	}
}
