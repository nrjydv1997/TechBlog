package com.tech.blog.helper;
import java.sql.*;
public class ConnectionProvider {
	
	private static Connection con;
	
	public static Connection getConnection() {
		
		try {
			
			if(con==null) {
				//Driver class load
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				 
				//Create a Connection
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","NrjYdv_07","Neeraj@1997");
			  }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
}
