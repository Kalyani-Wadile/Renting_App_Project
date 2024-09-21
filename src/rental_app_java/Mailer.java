package rental_app_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class Mailer {

    public static String readHTMLContentFromURL(String urlString) throws IOException {
        StringBuilder contentBuilder = new StringBuilder();
        URL url = new URL(urlString);
        try (BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()))) {
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                contentBuilder.append(inputLine);
            }
        }
        return contentBuilder.toString();
    }

    public static void send(String from, String password, String to, String sub, String htmlContent) {
        // Get properties object
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        // Get Session
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            // Compose message
            MimeMessage message = new MimeMessage(session);
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(sub);
            message.setContent(htmlContent, "text/html");

            // Send message
            Transport.send(message);
            System.out.println("HTML message sent successfully");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

//    public static void main(String[] args) {
//        // Fetch credentials from environment variables
//        String from = System.getenv("EMAIL");
//        String password = System.getenv("EMAIL_PASSWORD");
//        String to = "recipient@example.com";
//        String subject = "HTML Email Test";
//        String jspURL = "http://localhost:8081/Renting_Project/email_send.jsp"; // Modify with your actual URL
//        
//        try {
//            // Read HTML content from URL
//            String htmlContent = readHTMLContentFromURL(jspURL);
//            // Send email
//            send(from, password, to, subject, htmlContent);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
}