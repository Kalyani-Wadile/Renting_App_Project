<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
	<!-- Include CSS files -->
	<jsp:include page="./forAll/cssIncludes.jsp" />
	<!-- Custom CSS if any -->
    <link href="./css/pages-css/index.css" rel="stylesheet">
</head>
<body>

<div class="background-image">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="login-form">
                    <h2 class="text-center mb-4">Update Password</h2>
                    <p id="unique" class="text-center mb-4">Please enter your credentials to change Password.</p>
                    <form action="ForgotPass" method="post">
                        <div class="form-group mb-4">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" name="name" class="form-control" id="name" placeholder="Enter your name" required>
                            </div>
                        </div>
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
                            <button type="submit" class="btn btn-outline-primary btn-block b">Submit</button>
                        </div>
                    </form>
                    <div class="text-center">
                        <a href="index.jsp"> Back to Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%
	String msg = (String) session.getAttribute("message");
	if(msg != null) {
%>
    <script>
		 const element = document.getElementById('unique');
		 element.innerHTML = "<%=msg%>";
		 element.style["color"] = "red";
    </script>
<%
}
	session.removeAttribute("message");
%>


<!-- Include JavaScript files -->
<jsp:include page="./forAll/jsIncludes.jsp" />

</body>
</html>