package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectDB {
	public static Connection con=null;
	public static Connection connect()
	{
		if(con==null)
		{
			try 
			{
				Class.forName("com.mysql.jdbc.Driver"); //load the driver
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalapp", "root", "");
				
			}
			catch (Exception e) 
			{
				e.printStackTrace();
			}
		}
		return con;
	}
}


