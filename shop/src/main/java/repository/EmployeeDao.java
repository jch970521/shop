package repository;

import java.sql.*;
import java.util.*;
import vo.*;

public class EmployeeDao {
	//업데이트Active
	public int updateEmployeeActive(Connection conn, Employee employee) throws Exception {
		String sql = "UPDATE employee SET active=? WHERE employee_id=?";
		PreparedStatement stmt = null;
		int row = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getActive());
			stmt.setString(2, employee.getEmployeeId());
			
			row = stmt.executeUpdate();
			
		}catch(Exception e){
			try {
				stmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
		System.out.print("row : " + row);

		return row;
	}
	
	
	//마지막페이지
	public int CountEmployee(Connection conn) throws Exception{
		int lastPage = 0;
		String sql = "SELECT COUNT(*) count FROM employee"; // 갯수세기
		
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
	
	//사원리스트 출력
	public List<Employee> selectEmployeeList(Connection conn ,final int rowPerPage , final int beginRow ) throws Exception {
		List<Employee> employeeList = new ArrayList<>();
		Employee employee = null;
		String sql = "SELECT employee_id , employee_name , update_date , create_date , active FROM employee ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			employeeList = new ArrayList<Employee>();
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);

			System.out.println("EmployeeDao selectEmployeeList stmt : " + stmt);
			
			rs= stmt.executeQuery();
			while(rs.next()) {
				employee = new Employee();
				employee.setEmployeeId(rs.getString("employee_id"));
				employee.setEmployeeName(rs.getString("employee_name"));
				employee.setUpdateDate(rs.getString("update_date"));
				employee.setCreateDate(rs.getString("create_date"));
				employee.setActive(rs.getString("active"));
				
				employeeList.add(employee);
				
			}
		}finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
				
		return employeeList;
	}
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
		String sql ="SELECT employee_id , employee_name , active FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?) AND active = 'Y' ";
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
