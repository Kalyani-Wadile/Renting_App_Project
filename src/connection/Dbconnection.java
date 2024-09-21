package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Dbconnection {

	public static Connection connect()
	{
		Connection con = null;
		try {
		
		
		Class.forName("com.mysql.jdbc.Driver");
//		System.out.println("Driver registered");
		
		con = DriverManager.getConnection("jdbc:mysql://Localhost:3306/rentalapp","root","");
//		System.out.println("connection established");
		
		
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return(con);
	}

}



