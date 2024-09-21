package rental_app_java;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import connection.Dbconnection;

/**
 * Servlet implementation class UserProfile
 */
@MultipartConfig(maxFileSize = 16177215)
public class UserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */

    public UserProfile() {
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
		
		Connection con = Dbconnection.connect();
		

		
		try {
			
			// input stream of the upload file
			InputStream inputStream = null;
	        // obtains the upload file part in this multipart request
	        Part filePart = request.getPart("profile");
	        
	        if (filePart != null) {
	            // prints out some information for debugging
	            System.out.println(filePart.getName());
	            System.out.println(filePart.getSize());
	            System.out.println(filePart.getContentType());
	             
	            // obtains input stream of the upload file
	            inputStream = filePart.getInputStream();
	        }
			
			
			PreparedStatement stn = con.prepareStatement("select Photo from user_profile where Uemail = ?");
			stn.setString(1, ReqConstants.getEmail());
			ResultSet r = stn.executeQuery();
			
			System.out.println("starting");
			if(r.next()){
				
				PreparedStatement st = con.prepareStatement("update user_profile set Photo = ? where Uemail = ?");
				if (inputStream != null) {
	                // fetches input stream of the upload file for the blob column
	                st.setBlob(1, inputStream);
	            }else {
	            	System.out.println("not updated");
	            	response.sendRedirect("home_1.jsp");
	            }
				st.setString(2, ReqConstants.getEmail());
				
				int p = st.executeUpdate();
				if(p>0){
					System.out.println("image updated successfully");
				}
				
			}else {
				
				PreparedStatement st = con.prepareStatement("INSERT INTO user_profile VALUES(?,?,?);");
				st.setInt(1, 0);
				st.setString(2, ReqConstants.getEmail());
				
				if (inputStream != null) {
	                // fetches input stream of the upload file for the blob column
	                st.setBlob(3, inputStream);
	            }else {
	            	System.out.println("not insert");
	            	response.sendRedirect("home_1.jsp");
	            }
				 
				int m =  st.executeUpdate();
				if(m>0){
					System.out.println("image is saved successfully");
				}
				
			}
			
			response.sendRedirect("home_1.jsp");
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		
	}

}
