<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="rental_app_java.ReqConstants" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
  <!-- Include CSS files -->
  <jsp:include page="./forAll/cssIncludes.jsp" />
  <!-- Custom CSS if any -->
  <link href="./css/custom.css" rel="stylesheet">
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

String email = ReqConstants.getEmail();
 
 %>

<!-- Navbar -->
<jsp:include page="./forAll/navbar.jsp" />

<!-- Container for sidebar, main content, and footer -->
<div class="main">

  <!-- Sidebar -->
   <jsp:include page="./forAll/sidebar.jsp" />

  <!-- Main content -->
	<div class="shrinked p-3" id="data">
	    <div class="container mt-4" style="background-color: #F5DAD2">    
	        <div mb-4>
	            <h5 class="card-title text-center mt-4 mb-4">Add Details of Product</h5>
	            <form action="ProductAdd" method="post" enctype="multipart/form-data" id="productForm">
	                <div class="row mb-3">
	                    <div class="col input-group">
	                        <span class="input-group-text"><i class="fa fa-user"></i></span>
	                        <input type="text" name="name" class="form-control form-control-lg" id="name" placeholder="Enter product name" maxlength="40" required>
	                    </div>
	                    <div class="col input-group">
	                        <span class="input-group-text"><i class="fa fa-envelope"></i></span>
	                        <input type="email" name="email" class="form-control form-control-lg" id="email" value="<%= email %>" disabled>
	                    </div>
	                </div>
	                <div class="row mb-3">
	                    <div class="col input-group">
	                        <span class="input-group-text"><i class="fa fa-info-circle"></i></span>
	                        <textarea name="details" class="form-control form-control-lg" id="details" placeholder="Product details" maxlength="400" required></textarea>
	                    </div>
	                </div>
	                <div class="row mb-3">
	                	<div class="col input-group">
	                        <span class="input-group-text"><i class="fa fa-money"></i></span>
	                        <input type="text" name="price" class="form-control form-control-lg" id="price" placeholder="Enter price" required>
	                    </div>
	                    <div class="col input-group">
	                        <span class="input-group-text"><i class="fa fa-money"></i></span>
	                        <input type="text" name="deposit" class="form-control form-control-lg" id="deposit" placeholder="Enter deposit amount" required>
	                    </div>
	                </div>
	                <div class="row mb-3">
	                    <div class="col input-group">
	                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
	                        <input type="datetime-local" name="start_date" class="form-control form-control-lg" id="start_date" placeholder="Start Date" required>
	                    </div>
	                    <div class="col input-group">
	                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
	                        <input type="datetime-local" name="end_date" class="form-control form-control-lg" id="end_date" placeholder="End Date" required>
	                    </div>
	                </div>
	                <div class="row mb-3">
	                	<div class="col input-group">
                            <span class="input-group-text"><i class="fa fa-map-marker"></i></span>
                            <input type="text" name="state" class="form-control form-control-lg" id="state" placeholder="State" value="<%=state%>" required>
                        </div>
                        <div class="col input-group">
                            <span class="input-group-text"><i class="fa fa-map-marker"></i></span>
                            <input type="text" name="taluka" class="form-control form-control-lg" id="taluka" placeholder="Area" value="<%=taluka%>" required>
                        </div>
                        <div class="col input-group">
                            <span class="input-group-text"><i class="fa fa-map-marker"></i></span>
                            <input type="text" name="pincode" class="form-control form-control-lg" id="pin" placeholder="PIN" value="<%=pin%>" required>
                        </div>
	                </div>
	                <div class="input-group mb-3">
	                    <span class="input-group-text"><i class="fa fa-map-marker"></i></span>
	                    <textarea name="loc" class="form-control form-control-lg" id="loc" placeholder="Location" required><%=loc%></textarea>
	                </div>
	                <div class="row mb-3">
	                    <div class="col input-group">
	                        <span class="input-group-text"><i class="fa fa-upload"></i></span>
	                        <input type="file" name="product_image" class="form-control form-control-lg" id="product_image" accept="image/*" required>
	                    </div>
	                </div>
	                <input type="hidden" name="a1" class="form-control" id="a1" value="<%=lat%>" required>
	                <input type="hidden" name="a2" class="form-control" id="a2" value="<%=lng%>" required>
	                <button type="submit" class="btn btn-primary btn-lg btn-block">Submit</button>
	            </form>
	        </div>
	    </div>
	</div>

  <!-- Footer -->
    <jsp:include page="./forAll/footer.jsp" />

</div>

<script>
document.getElementById('productForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent form submission

    // Get the current date
    var currentDate = new Date();
    currentDate.setHours(0, 0, 0, 0); // Set hours, minutes, seconds, and milliseconds to 0

    // Get the entered start and end dates
    var startDate = new Date(document.getElementById('start_date').value);
    var endDate = new Date(document.getElementById('end_date').value);

    // Check if the start date is before the current date
    if (startDate < currentDate) {
        alert('Start date must be after the current date.');
        return;
    }

    // Check if the end date is before the current date or before the start date
    if (endDate < currentDate || endDate < startDate) {
        alert('End date must be after the current date and after the start date.');
        return;
    }

    // Get the price and deposit amount
    var price = parseFloat(document.getElementById('price').value);
    var deposit = parseFloat(document.getElementById('deposit').value);

    // Check if parsing was successful
    if (isNaN(price) || isNaN(deposit)) {
        alert('Price and deposit amount must be numeric values.');
        return;
    }

    // Check if the deposit amount is less than the price
    if (deposit >= price) {
        alert('Deposit amount must be Less than or equal to the price.');
        return;
    }

    // If all validation passes, submit the form
    this.submit();
});

</script>



<!-- Include JavaScript files -->
<jsp:include page="./forAll/jsIncludes.jsp" />
<!-- Your custom JS if any -->
<script src="./js/custom.js"></script>
</html>