<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="rental_app_java.ReqConstants" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="./forAll/cssIncludes.jsp" />
    <!-- Custom CSS if any -->
    <link href="./css/pages-css/index.css" rel="stylesheet">
    <!-- Include the crypto-js and js-base64 libraries -->
    <script src="https://cdn.jsdelivr.net/npm/crypto-js@4.1.1/crypto-js.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/js-base64@3.7.2/base64.min.js"></script>
</head>
<body>

<%
    // Check if cookies exist containing the username
    String username = null;
    String password = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("kalyani_rental")) {
                String[] values = cookie.getValue().split(":");
                if (values.length == 2) {
                    username = values[0];
                    password = values[1];
                    System.out.println(username + password);
                    break;
                }
            }
            System.out.println(username + password);
        }
    }

    // If cookies exist, redirect to home page
    if (username != null && !username.isEmpty() && password != null && !password.isEmpty()) {
        %><form id="cookieForm" action="LoginUser" method="post"><%
        %><input type="hidden" name="email" value="<%= username %>" /><%
        %><input type="hidden" name="password" value="<%= password %>" /><%
        %></form><%
    } else {
%>

<div class="background-image">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="login-form">
                    <h2 class="text-center mb-4">Login</h2>
                    <%
                        String msg = (String) session.getAttribute("message");
                        if (msg != null) {
                    %>
                        <h6 class="text-center mb-4" style="color: red;"><%= msg %></h6>
                    <%
                        }
                        session.removeAttribute("message");
                    %>

                    <form id="loginForm" action="LoginUser" method="post" onsubmit="hashPassword()">
                        <div class="form-group mb-4">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email" required>
                            </div>
                        </div>
                        <div class="form-group mb-4">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" name="password" class="form-control" id="password" placeholder="Enter your password" required>
                            </div>
                        </div>
                        <div class="form-group mb-4">
                            <a href="forgot_pass.jsp">Forgot password?</a>
                        </div>
                        <div class="form-group mb-4">
                            <button type="submit" class="btn btn-outline-primary btn-block b">Submit</button>
                        </div>
                    </form>
                    <div class="text-center">
                        Don't have an account? <a href="register_user.jsp">Signup</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%
    }
%>

<!-- Include JavaScript files -->
<jsp:include page="./forAll/jsIncludes.jsp" />
<script>
    // Submit the form when the page loads if the cookie exists
    if(document.getElementById("cookieForm")){
        document.getElementById("cookieForm").submit();
    }

    function hashPassword() {
        var passwordField = document.getElementById("password");
        var saltedPassword = passwordField.value; // Add any salting mechanism if needed

        // Create MessageDigest instance for SHA-256
        var hash = CryptoJS.SHA256(saltedPassword);

        // Convert the hash to Base64
        var hashedPassword = CryptoJS.enc.Base64.stringify(hash);

        // Set the hashed password back to the password field
        passwordField.value = hashedPassword;
    }

</script>
</body>
</html>
