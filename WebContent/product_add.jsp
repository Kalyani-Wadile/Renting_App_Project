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
      <div class="login-form">
          <h2 class="text-center mb-5">Add Location of Product</h2>
          <form>
              <div class="input-boxes">
                  <div class="input-box mb-4">
                      <a href="location_product.jsp" class="btn btn-outline-info btn-lg active b" role="button" aria-pressed="true">Select Location</a>
                  </div>
              </div>
          </form>
          <div class="text-center">
                 <a href="home_1.jsp"> Back to Home</a>
          </div>
      </div>
   </div>
	
<!-- Include JavaScript files -->
<jsp:include page="./forAll/jsIncludes.jsp" />
</body>
</html>