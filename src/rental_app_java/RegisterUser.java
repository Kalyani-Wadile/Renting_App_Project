package rental_app_java;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import connection.Dbconnection;

/**
 * Servlet implementation class RegisterUser
 */
public class RegisterUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	int pin;
	String name,pass,contact,email,state,taluka,location;
	double latitude ,longitude;
	
    public RegisterUser() {
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
		
		name = request.getParameter("name");
		email = request.getParameter("email");
		contact = request.getParameter("mob");
		pass =  request.getParameter("password");
		taluka = request.getParameter("taluka");
		state =  request.getParameter("state");
		pin = Integer.parseInt(request.getParameter("pin"));
		location = request.getParameter("loc");
		latitude = Double.parseDouble(request.getParameter("a1"));
		longitude = Double.parseDouble(request.getParameter("a2"));
		
		System.out.println(name+pass+contact+latitude+longitude);
		
        // Validate password
        if (!PasswordValidator.isValid(pass)) {
            request.getSession().setAttribute("message", "Password does not meet requirements.");
            response.sendRedirect("index.jsp");
            return;
        }
		
		
		if(contact.length()==10){
			System.out.println(name+pass+contact+latitude+longitude);
			
			 String hashedPassword = hashPassword(pass);
			 System.out.println(hashedPassword);
			
			Connection con = Dbconnection.connect();
			try {
				PreparedStatement stmt = con.prepareStatement("INSERT INTO user_login VALUES(?,?,?,?,?,?,?,?,?,?,?)");
				stmt.setInt(1, 0);
				stmt.setString(2, name);
				stmt.setString(3, email);
			    stmt.setString(4, contact);
			    stmt.setString(5, hashedPassword);
			    stmt.setString(6, taluka);
			    stmt.setString(7, state);
			    stmt.setInt(8, pin);
			    stmt.setString(9, location);
			    stmt.setDouble(10, latitude);
			    stmt.setDouble(11, longitude);
			    
			    int n = stmt.executeUpdate();
			    if(n>0){
			    	request.getSession().setAttribute("message", "Successfully Register");
			    	response.sendRedirect("index.jsp");
			    }
			    else{
			    	request.getSession().setAttribute("message", "Failed try again");
			    	response.sendRedirect("index.jsp");
			    }
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				request.getSession().setAttribute("message", "Failed try again");
		    	response.sendRedirect("index.jsp");
			}
		}
	}
	
    private String hashPassword(String password) {
        try {
            // Salt the password (if needed)
            String saltedPassword = password;

            // Create MessageDigest instance for SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");

            // Add salted password bytes to digest
            md.update(saltedPassword.getBytes());

            // Get the hash's bytes
            byte[] bytes = md.digest();

            // Convert byte[] to base64 representation
            return Base64.getEncoder().encodeToString(bytes);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

}
