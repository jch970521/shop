package repository;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	public static Connection getConnection() throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/shop";
		String user = "root";
		String dbpw = "1234";
	
		Connection conn = DriverManager.getConnection(url,user,dbpw);
		return conn;
		

	}
}
