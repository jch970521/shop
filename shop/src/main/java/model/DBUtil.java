package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	public static Connection getConnection() throws Exception {
		// try - catch 사용해도되고 안해도되는데 finally 쓰려면 try - catch 써야함.
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/shop";
		String user = "root";
		String dbpw = "1234";
	
		Connection conn = DriverManager.getConnection(url,user,dbpw);
		return conn;
		

	}
}
