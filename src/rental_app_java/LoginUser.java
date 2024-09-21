package rental_app_java;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connection.Dbconnection;


/**
 * Servlet implementation class LoginUser
 */
public class LoginUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	String pass,email;
	int rid ;
	
	
    public LoginUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		email = request.getParameter("email");
		pass =  request.getParameter("password");
		
		Connection ct = Dbconnection.connect();
		
		try {
			
			// Hash the password to compare with the hashed password in the database
            
            System.out.println(pass);
			
			PreparedStatement stmt = ct.prepareStatement("select * from user_login where Email = ? and Password = ?");
			stmt.setString(1, email);
			stmt.setString(2, pass);
			
			ResultSet r = stmt.executeQuery();
			
			if(r.next()) {
//		    	PrintWriter out = response.getWriter();
//				out.println("\nSuccessfully Saved");
				ReqConstants.setEmail(email);
				ReqConstants.setPass(pass);
				ReqConstants.setContact(r.getString(4));
				ReqConstants.setUname(r.getString(2));
				
				PreparedStatement sn = ct.prepareStatement("select Ename, Estart_date , Eend_date from equipment_data where Eend_date < ?;");

				
				// Check for products with expired end dates and delete them
			    PreparedStatement deleteStmt = ct.prepareStatement("DELETE FROM equipment_data WHERE Eend_date < ?");
			    // Get current date and time
			    LocalDateTime now = LocalDateTime.now();
			    // Convert to string in the format expected by the database
			    String formattedNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			    
			    sn.setString(1, formattedNow);
			    ResultSet rn = sn.executeQuery();
			    rn.next();
			    
			    // Set parameter for deletion query
			    deleteStmt.setString(1, formattedNow);
			    // Execute deletion query
			    int deletedRows = deleteStmt.executeUpdate();
			    
			    

                // Check if cookies exist, if not, create them
                Cookie[] cookies = request.getCookies();
                boolean cookieExists = false;
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("kalyani_rental")) {
                            cookieExists = true;
                            break;
                        }
                    }
                }

                if (!cookieExists) {
                    // Create a cookie with user email and hashed password
                    Cookie cookie = new Cookie("kalyani_rental", email + ":" + pass);
                    cookie.setMaxAge(3600); // Cookie will expire in 1 hour (in seconds)
                    cookie.setPath("/");    // Cookie is accessible to all paths
                    response.addCookie(cookie);
                }


			    
			    
			    if(deletedRows > 0){
				    // Print number of deleted rows for debugging
				    System.out.println(deletedRows + " rows deleted.");
				    // Print number of deleted rows for debugging
				    System.out.println(deletedRows + " rows deleted.");
				    
				    String str = "Your Product "+rn.getString(1)+" exceed the end date therefore removed from database Start Date: "+rn.getString(2)+" End Date: "+rn.getString(3);
				    
					PreparedStatement sp = ct.prepareStatement("INSERT INTO user_messages VALUES(?,?,?,?);");
					sp.setInt(1,0);
					sp.setString(2,ReqConstants.getEmail());
					sp.setString(3,ReqConstants.getEmail());
					sp.setString(4, str);
					int ip = sp.executeUpdate();
					
					if(ip > 0){
						System.out.println("message is successfully send");
					}
				    
				    }
				
		        response.sendRedirect("home_1.jsp");
		   
		    }else {
		    	request.getSession().setAttribute("message", "Invalid user name or password");
				response.sendRedirect("index.jsp");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
	}
	
	

}
