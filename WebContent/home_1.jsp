<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*, connection.Dbconnection, rental_app_java.ReqConstants"%>
<%@ page import="java.time.LocalDateTime, java.time.Duration, java.time.format.DateTimeFormatter"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Column-Based Flexbox Layout</title>
  <!-- Include CSS files -->
  <jsp:include page="./forAll/cssIncludes.jsp" />
  <!-- Custom CSS if any -->
  <link href="./css/custom.css" rel="stylesheet">
</head>
<body>


<%
	String email = ReqConstants.getEmail();
	String name = ReqConstants.getUname();
	String searchValue = ReqConstants.getSearch();
	System.out.println("....................");
	System.out.println(email);
	System.out.println("....................");
	System.out.println(searchValue);
    Connection ct = Dbconnection.connect();
	
    
    PreparedStatement stmt;
    if (searchValue != null) {
        // If search value is not null, query with search condition
        stmt = ct.prepareStatement("SELECT * FROM equipment_data WHERE Status ='Not_Rent' AND Ename LIKE ?");
        stmt.setString(1, "%" + searchValue + "%");
        ReqConstants.setSearch(null);
    } else {
        // If search value is null, query without search condition
        stmt = ct.prepareStatement("SELECT * FROM equipment_data WHERE Status ='Not_Rent'");
    }
    ResultSet r = stmt.executeQuery();

 %>

<!-- Navbar -->
<jsp:include page="./forAll/navbar.jsp" />

<!-- Container for sidebar, main content, and footer -->
<div class="main">

  <!-- Sidebar -->
   <jsp:include page="./forAll/sidebar.jsp" />

  <!-- Main content -->
  <div class="shrinked p-3" id="data">
  <h1 class="mb-4 text-center text-secondary" ><mark>Welcome</mark> <u><%= name %></u></h1>
  
  
	  <div id="carouselExampleCaptions" class="carousel slide mb-5" style="height:300px;">
	  <div class="carousel-indicators">
	    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
	    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
	    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
	  </div>
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="/Renting_Project/images/shrink.png" class="d-block w-100" alt="image1">
	      <div class="carousel-caption d-none d-md-block">
	        <h5></h5>
	        <p></p>
	      </div>
	    </div>
	    <div class="carousel-item">
	      <img src="/Renting_Project/images/shrink2.png" class="d-block w-100" alt="image2" >
	      <div class="carousel-caption d-none d-md-block">
	        <h5></h5>
	        <p></p>
	      </div>
	    </div>
	  </div>
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
	</div>
  
  

<div class="card-contain">

	<% while (r.next()) {
        Blob blob = r.getBlob(19);
        // Convert the Blob data to a byte array
        byte[] byteArray = blob.getBytes(1, (int) blob.length());
        // Convert the byte array to a Base64 string
        String base64Image = javax.xml.bind.DatatypeConverter.printBase64Binary(byteArray);
        // Generate the data URL for the image
        String imageUrl = "data:image/jpeg;base64," + base64Image;
    %>
    <%
    // Example dates in string format
    String endDateStr = r.getString(8); // Format: yyyy-MM-dd HH:mm:ss.S

    // Parse string date into LocalDateTime object for end date
    LocalDateTime endDate = LocalDateTime.parse(endDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));

    // Get the current date and time
    LocalDateTime currentDate = LocalDateTime.now();

    // Calculate duration between the current date and end date
    Duration duration = Duration.between(currentDate, endDate);

    // Get the duration components (days, hours, minutes)
    long days = duration.toDays();
    long hours = duration.toHours() % 24;
    long minutes = duration.toMinutes() % 60;

    // Output the duration
    System.out.println("Duration: " + days + " days, " + hours + " hours, " + minutes + " minutes");

	 
   %>
  
  
          <!-- Individual card -->
      	<div class="card border-success mb-3" style="max-width: 20rem;">
	  <div class="card-header bg-transparent border-success">Remaining Time - <%=days+" days" + " : " + hours + " hrs" + " : " +minutes + " min"%></div>
	  <div class="card-body text-success" style="height: 380px;">
	  	<img class="card-img-top mb-2" src="<%=imageUrl%>" style="height: 150px; object-fit: contain;" alt="Card image cap">
	    <h5 class="card-title"><%=r.getString(2)%></h5>
            		<p class="card-text"><i>Price : </i><i class="fas fa-rupee-sign"></i> <%=r.getString(4) %><p class="card-text">
            		<p class="card-text"><i>Deposit : </i><i class="fas fa-rupee-sign"></i> <%=r.getString(5) %><p class="card-text">
            		<p class="card-text"><i>Start Date : </i><i class="fas fa-calendar-week"></i> <%=r.getString(7) %><p class="card-text">
            		<p class="card-text"><i>End Date : </i><i class="fas fa-calendar-week"></i> <%=r.getString(8) %><p class="card-text">
	  </div>
	  <div class="card-footer bg-transparent border-success">
	  <div class="linkbutton">
	  		<a href="product_details.jsp?ID=<%=r.getInt(1)%>" class="btn btn-sm btn-outline-info">Details</a>
	  	<!-- Check if the user is the owner, if yes, disable the rent button -->
           <%System.out.println(email.equals(r.getString(15))); 
           if (email.equals(r.getString(15))) {  %>
               <h6>My Product</h6>
           <% } else { %>
               <a href="update_status.jsp?ID=<%=r.getInt(1)%>&remail=<%=r.getString(15)%>&ename=<%=r.getString(2)%>" 
               onclick="return confirm('Are you sure you want to rent this product?');"
               class="btn btn-sm btn-outline-success">Rent</a>
           <% } %>
      </div>
	  </div>
	</div>
      <% } %>

</div>

 </div>

  <!-- Footer -->
    <jsp:include page="./forAll/footer.jsp" />

</div>


<!-- Include JavaScript files -->
<jsp:include page="./forAll/jsIncludes.jsp" />
<!-- Your custom JS if any -->
<script src="./js/custom.js"></script>
</body>
</html>
