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

 <%
 
String lat = request.getParameter("lat");
String lng = request.getParameter("lng");
String loc = request.getParameter("location");
String state = request.getParameter("state");
String taluka = request.getParameter("locality");
String pin = request.getParameter("pin");

System.out.println(lat+lng);
 
 %>

<div class="background-image">
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="login-form">
                    <h5 class="card-title text-center mb-4">Login</h5>
                    <form action="RegisterUser" method="post">
                        <div class="row mb-5">
                            <div class="col input-group">
                                <span class="input-group-text"><i class="fa fa-user"></i></span>
                                <input type="text" name="name" class="form-control" id="name" placeholder="Enter your name" required>
                            </div>
                            <div class="col input-group">
                                <span class="input-group-text"><i class="fa fa-envelope"></i></span>
                                <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email" required>
                            </div>
                        </div>
                        <div class="row mb-5">
                            <div class="col input-group">
                                <span class="input-group-text"><i class="fa fa-mobile"></i></span>
                                <input type="text" name="mob" class="form-control" id="mob" placeholder="Enter your mobile number" required>
                            </div>
                            <div class="col input-group">
                                <span class="input-group-text"><i class="fa fa-lock"></i></span>
                                <input type="password" name="password" class="form-control" id="password" placeholder="Enter your password" required>
                            </div>
                        </div>
                        <div class="row mb-5">
                            <div class="col input-group">
                                <span class="input-group-text"><i class="fa fa-map-marker"></i></span>
                                <input type="text" name="state" class="form-control" id="state" placeholder="State" value="<%=state%>" required>
                            </div>
                            <div class="col input-group">
                                <span class="input-group-text"><i class="fa fa-map-marker"></i></span>
                                <input type="text" name="taluka" class="form-control" id="taluka" placeholder="Taluka" value="<%=taluka%>" required>
                            </div>
                            <div class="col input-group">
                                <span class="input-group-text"><i class="fa fa-map-marker"></i></span>
                                <input type="text" name="pin" class="form-control" id="pin" placeholder="PIN" value="<%=pin%>" required>
                            </div>
                        </div>
                        <div class="row mb-5">
                            <div class="col input-group">
                                <span class="input-group-text"><i class="fa fa-map-marker"></i></span>
                                <textarea name="loc" class="form-control" id="loc" placeholder="Location" required><%=loc%></textarea>
                            </div>
                            <input type="hidden" name="a1" class="form-control" id="a1" value="<%=lat%>" required>
                            <input type="hidden" name="a2" class="form-control" id="a2" value="<%=lng%>" required>
                        </div>
                        <button type="submit" class="btn btn-primary b">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>




<!-- Include JavaScript files -->
<jsp:include page="./forAll/jsIncludes.jsp" />
</body>
</html>