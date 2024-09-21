package rental_app_java;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import connection.Dbconnection;

/**
 * Servlet implementation class ProductAdd
 */
//@WebServlet("/uploadServlet")
@MultipartConfig(maxFileSize = 16177215) 
public class ProductAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	
	String name,email,details,stdate,endate;
	String location,area,state;
	
	int pin;
	float price,deposit;
	double latitude,longitude;
	
	String s = "Not_Rent";
	
    public ProductAdd() {
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
		
        Date currentDate = new Date();
        
        name = request.getParameter("name");
	    email = ReqConstants.getEmail();
		details = request.getParameter("details");
		area = request.getParameter("taluka");
		state = request.getParameter("state");	
		pin = Integer.parseInt(request.getParameter("pincode"));
		price = Float.parseFloat(request.getParameter("price"));
		deposit = Float.parseFloat(request.getParameter("deposit"));
		stdate = request.getParameter("start_date");
		endate = request.getParameter("end_date");
		location =request.getParameter("loc");
		latitude = Double.parseDouble(request.getParameter("a1"));
		longitude = Double.parseDouble(request.getParameter("a2"));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		String today = sdf.format(currentDate);
		System.out.println(name+details+email+location+latitude+longitude+area+state+pin+price+deposit+location+stdate+endate);
		
		try {
			String start = sdf.format(sdf.parse(stdate));
			String end = sdf.format(sdf.parse(endate));
			
			System.out.println(start+end);
			
	        Connection con = Dbconnection.connect();
	        try {
	        	
	    		// input stream of the upload file
	    		InputStream inputStream = null;
	            // obtains the upload file part in this multipart request
	            Part filePart = request.getPart("product_image");
	            if (filePart != null) {
	                // prints out some information for debugging
	                System.out.println(filePart.getName());
	                System.out.println(filePart.getSize());
	                System.out.println(filePart.getContentType());
	                 
	                // obtains input stream of the upload file
	                inputStream = filePart.getInputStream();
	            }
	        	
				PreparedStatement statement = con.prepareStatement("INSERT INTO equipment_data VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
				statement.setInt(1,0);
				statement.setString(2,name);
				statement.setString(3,details);
				statement.setDouble(4,price);
				statement.setDouble(5,deposit);
				statement.setString(6,today);
				statement.setString(7, start);
				statement.setString(8,end);
				statement.setString(9,area);
				statement.setString(10,state);
				statement.setInt(11,pin);
				statement.setDouble(12,latitude);
				statement.setDouble(13,longitude);
				statement.setString(14, location);
				statement.setString(15,email);
				statement.setString(16,"NULL");
				statement.setString(17,s);
				statement.setString(18,"Ignored");
	             
	            if (inputStream != null) {
	                // fetches input stream of the upload file for the blob column
	                statement.setBlob(19, inputStream);
	            }
	            
	            int row = statement.executeUpdate();
	            if (row > 0) {
	            	request.getSession().setAttribute("message", "green");
	            	response.sendRedirect("user_product.jsp");
		        }
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("failed to add product specifically due to insertion");
				request.getSession().setAttribute("message", "red");
            	response.sendRedirect("user_product.jsp");
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("failed to add product due to image ");
			request.getSession().setAttribute("message", "red");
        	response.sendRedirect("user_product.jsp");
		}
		

		
	}

}
