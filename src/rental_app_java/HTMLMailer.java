package rental_app_java;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import connection.Dbconnection;

public class HTMLMailer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HTMLMailer() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());

        int id = Integer.parseInt(request.getParameter("ID"));
        String remail = request.getParameter("remail");
        String ename = request.getParameter("ename");
        String email = ReqConstants.getEmail();
        String str = "Your Request of " + ename + " is 'Approved' by " + ReqConstants.getEmail();

        Connection co = Dbconnection.connect();

        if (remail != null && email != null) {
            try {
                // Get the absolute path to the image

            	String logoPath = "D:\\workplace\\Renting_Project\\WebContent\\images\\rental_logo.jpeg";
            	String logoBase64 = encodeImage(logoPath);
            	
            	System.out.println("Encoded logo image: " + logoBase64);


                PreparedStatement stmt = co.prepareStatement("update equipment_data set Approvement = 'Approve' where EID = ?");
                stmt.setInt(1, id);
                int i = stmt.executeUpdate();

                PreparedStatement sp = co.prepareStatement("INSERT INTO user_messages VALUES(?,?,?,?);");
                sp.setInt(1, 0);
                sp.setString(2, email);
                sp.setString(3, remail);
                sp.setString(4, str);
                int ip = sp.executeUpdate();

                PreparedStatement spn = co.prepareStatement("select * from equipment_data where EID = ?");
                spn.setInt(1, id);
                ResultSet r = spn.executeQuery();
                r.next();

                PreparedStatement st = co.prepareStatement("select * from user_login where Email = ?");
                st.setString(1, email);
                ResultSet rs = st.executeQuery();
                rs.next();

                String uname = rs.getString(2);
                String aname = r.getString(15);
                String totalamount = r.getString(4);
                String rdate = r.getString(6);

                String from = System.getenv("EMAIL");
                String password = System.getenv("EMAIL_PASSWORD");
                System.out.println(from + password + remail);
                String to = remail;
                String subject = "HTML Email Test";
                String htmlContent = "<html><head><style>"
                        + "body {font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0;}"
                        + ".container {max-width: 600px; margin: 0 auto; padding: 20px; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);}"
                        + ".header {background-color: #28a745; color: #ffffff; padding: 20px; text-align: center; border-top-left-radius: 8px; border-top-right-radius: 8px;}"
                        + ".content {padding: 20px;}"
                        + ".footer {background-color: #f4f4f4; color: #666666; padding: 20px; text-align: center; border-bottom-left-radius: 8px; border-bottom-right-radius: 8px;}"
                        + ".logo {display: block; margin: 0 auto; width: 80px; height: 80px; border-radius: 50%;}"
                        + "</style></head><body>"
                        + "<div class=\"container\"><div class=\"header\"><img src=\"data:image/jpeg;base64," + logoBase64 + "\" alt=\"RentUp\" class=\"logo\"><h2 style=\"margin-bottom: 0;\">Order Confirmation</h2></div>"
                        + "<div class=\"content\"><h3>Dear " + uname + ",</h3>"
                        + "<p>Your order has been confirmed:</p>"
                        + "<ul>"
                        + "<li>Equipment: " + ename + "</li>"
                        + "<li>Owner: " + aname + "</li>"
                        + "<li>Total Amount: " + totalamount + "</li>"
                        + "<li>Rental Date: " + rdate + "</li>"
                        + "</ul>"
                        + "<p>Thank you for choosing our service!</p>"
                        + "<img src=\"https://cdn1.iconfinder.com/data/icons/shipping-30/124/booking-confirm-reservation-authorize-purchase-512.png\" alt=\"Thank You\" style=\"width: 200px; display: block; margin: 20px auto;\">"
                        + "<img src=\"https://image.shutterstock.com/image-vector/thank-you-handwritten-isolated-on-260nw-2267689749.jpg\" alt=\"Thank You\" style=\"width: 200px; display: block; margin: 20px auto;\"></div>"
                        + "<div class=\"footer\"><p>&copy; RentUp2024. All rights reserved.</p></div></div></body></html>";

                // Send email
                HTMLMailer.send(from, password, to, subject, htmlContent);

                response.sendRedirect("request_message.jsp");

            } catch (SQLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error reading the image file.");
            }
        } else {
            System.out.println("email is null");
            response.sendRedirect("request_message.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    public static String encodeImage(String imagePath) throws IOException {
        Path path = Paths.get(imagePath);
        byte[] bytes = Files.readAllBytes(path);
        System.out.println("Image bytes length: " + bytes.length);
        return Base64.getEncoder().encodeToString(bytes);
    }

    public static void send(String from, String password, String to, String sub, String htmlContent) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(sub);
            message.setContent(htmlContent, "text/html");

            Transport.send(message);
            System.out.println("HTML message sent successfully");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
