package rental_app_java;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReqConstants
 */
public class ReqConstants extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	static String Pass,Uname,Email,Search,Contact;
	
    public ReqConstants() {
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
		
		 String searchValue = request.getParameter("search");

	        // Update the search value in ReqConstants or perform any other desired action
	        ReqConstants.setSearch(searchValue);

	        // Get the referring page URL from the request
	        String referringPage = request.getParameter("referringPage");
	        
	        System.out.println(searchValue);
	        System.out.println(referringPage);
	        // Redirect the user back to the referring page
	        response.sendRedirect(referringPage);
		

	}
	
	public static String getPass() {
		return Pass;
	}

	public static void setPass(String pass) {
		Pass = pass;
	}

	public static String getEmail() {
		return Email;
	}

	public static void setEmail(String email) {
		Email = email;
	}

	public static String getUname() {
		return Uname;
	}

	public static void setUname(String name) {
		Uname = name;
	}

	public static String getSearch() {
		return Search;
	}

	public static void setSearch(String search) {
		Search = search;
	}

	public static String getContact() {
		return Contact;
	}

	public static void setContact(String contact) {
		Contact = contact;
	}


}
