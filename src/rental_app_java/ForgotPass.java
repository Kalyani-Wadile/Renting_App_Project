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
 * Servlet implementation class ForgotPass
 */
public class ForgotPass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	String name,pass,email;
	
    public ForgotPass() {
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
		pass =  request.getParameter("password");
		
		System.out.println(name+pass+email);
		
		Connection co = Dbconnection.connect();
		try {
			
			String hashedPassword = hashPassword(pass);
			System.out.println(hashedPassword);
			
			PreparedStatement stmt = co.prepareStatement("update user_login set Name = ? where Email = ? ;");
			stmt.setString(1,name);
		    stmt.setString(2,email);
		    
		    int i = stmt.executeUpdate();
		    
		    if(i>0){
				PreparedStatement st = co.prepareStatement("update user_login set Password = ? where Email = ? ;");
			    st.setString(1,hashedPassword);
			    st.setString(2,email);
			    int p = st.executeUpdate();
			    
			    if(p>0){
			    	request.getSession().setAttribute("message", "Successfully Modify");
			    	response.sendRedirect("index.jsp");
			    }
			}else {
				
		    	 request.getSession().setAttribute("message", "Failed to modify. Invalid Email");
			     response.sendRedirect("forgot_pass.jsp");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
