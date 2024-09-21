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
  <link href="./css/custom.css" rel="stylesheet">
</head>
<body>

	<!-- Navbar -->
	<jsp:include page="./forAll/navbar.jsp" />
	
	<!-- Container for sidebar, main content, and footer -->
	<div class="main">
	
	  <!-- Sidebar -->
	   <jsp:include page="./forAll/sidebar.jsp" />
	
	  <!-- Main content -->
	  <div class="shrinked p-3" id="data">
	    <h2>Offers Table</h2>
	    <div class="table-responsive">
	        <table class="table table-striped table-bordered table-hover">
	            <thead class="thead-dark">
	                <tr>
	                    <th>#</th>
	                    <th>Name</th>
	                    <th>City</th>
	                    <th>Taluka</th>
	                    <th>District</th>
	                    <th>Price</th>
	                    <th>Deposit</th>
	                    <th>Duration</th>
	                    <th>Start Date</th>
	                    <th>End Date</th>
	                    <th>Contact</th>
	                    <th>Status</th>
	                    <th>Image</th>
	                    <th>Rent</th>
	                </tr>
	            </thead>
	            <tbody>
	                <!-- Example row -->
	                <tr>
	                    <td>1</td>
	                    <td>Equipment Name</td>
	                    <td>City</td>
	                    <td>Taluka</td>
	                    <td>District</td>
	                    <td>Price</td>
	                    <td>Deposit</td>
	                    <td>Duration</td>
	                    <td>Start Date</td>
	                    <td>End Date</td>
	                    <td>Contact</td>
	                    <td>Status</td>
	                    <td><a href="viewimage.jsp?ID=123" class="btn btn-outline-primary btn-sm active" role="button" aria-pressed="true">View</a></td>
	                    <td><a href="update.jsp?ID=123" class="btn btn-outline-success btn-sm active" role="button" aria-pressed="true">Rent</a></td>
	                </tr>
	                <!-- Add more rows as needed -->
	            </tbody>
	        </table>
	    </div>
	</div>
	
<!-- Footer -->
  <jsp:include page="./forAll/footer.jsp" />

</div>


<!-- Include JavaScript files -->
<jsp:include page="./forAll/jsIncludes.jsp" />
<!-- Your custom JS if any -->
<script src="./js/custom.js"></script>

</head>
<body>

</body>
</html>