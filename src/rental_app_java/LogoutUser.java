package rental_app_java;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class LogoutUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LogoutUser() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

     // Clear user session attributes
        request.getSession().invalidate();
        
        System.out.println("cookies");

        // Remove cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("kalyani_rental")) {
                    cookie.setMaxAge(0); // Set cookie age to 0 to delete it
                    cookie.setPath("/"); // Set the correct path for the cookie
                    response.addCookie(cookie);
                    System.out.println("cookies are deleted");
                    System.out.println(cookies);
                    break; // Exit loop after deleting the cookie
                }
            }
        }
        
        System.out.println("cookies are deleted");
        
        ReqConstants.setContact(null);
        ReqConstants.setEmail(null);
        ReqConstants.setUname(null);
        ReqConstants.setPass(null);
        ReqConstants.setSearch(null);
        
        
        System.out.println("deleted");
        
        // Redirect to index.jsp after logout
        response.sendRedirect("index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
