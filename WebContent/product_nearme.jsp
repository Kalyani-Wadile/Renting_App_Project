<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*, connection.Dbconnection, rental_app_java.ReqConstants, java.lang.Math" %> 
<%@ page import="java.time.LocalDateTime, java.time.Duration, java.time.format.DateTimeFormatter"%>   
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Available Products</title>
<!-- Include CSS files -->
<jsp:include page="./forAll/cssIncludes.jsp" />
<!-- Custom CSS if any -->
<link href="./css/custom.css" rel="stylesheet">
</head>
<%!
    public static final double EARTH_RADIUS = 6371.0; // Earth's mean radius in km

    private static double toRadians(double degrees) {
        return degrees * Math.PI / 180.0;
    }

    public static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {

        double deltaLat = toRadians(lat2 - lat1);
        double deltaLon = toRadians(lon2 - lon1);

        double a = Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2)
                + Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2))
                * Math.sin(deltaLon / 2) * Math.sin(deltaLon / 2);

        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        return EARTH_RADIUS * c; // Distance in km
    }
%>

<%
    double latitude1, longitude1;
    double latitude2 = 0, longitude2 = 0;
    double distance;
    int i = 1;

    String email = ReqConstants.getEmail();
    String searchValue = ReqConstants.getSearch();
    
    Connection co = Dbconnection.connect();

    PreparedStatement sct = co.prepareStatement("select * from user_login where Email = ?");
    sct.setString(1, email);
    ResultSet r = sct.executeQuery();

    if (r.next()) {
        latitude2 = r.getDouble(10);
        longitude2 = r.getDouble(11);
    }
	
    PreparedStatement stmt;
    if (searchValue != null) {
        // If search value is not null, query with search condition
        stmt = co.prepareStatement("select * from equipment_data WHERE Status = 'Not_Rent' AND Ename LIKE ? ;");
        stmt.setString(1, "%" + searchValue + "%");
        ReqConstants.setSearch(null);
    } else {
        // If search value is null, query without search condition
        stmt = co.prepareStatement("select * from equipment_data WHERE Status = 'Not_Rent' ; ");
    }
    ResultSet rp = stmt.executeQuery();
    

%>

<body>
    <!-- Navbar -->
    <jsp:include page="./forAll/navbar.jsp" />

    <!-- Container for sidebar, main content, and footer -->
    <div class="main">

        <!-- Sidebar -->
        <jsp:include page="./forAll/sidebar.jsp" />

        <!-- Main content -->
        <div class="shrinked p-3" id="data">
            <h2 class="mb-5">Available Products Near Me</h2>
                <h4 class="mb-2">All Offers</h4>
				<div class="card-contain">
                        <%
                            while (rp.next()) {
                                if (!email.equals(rp.getString(15))) {
                                    latitude1 = rp.getDouble(12);
                                    longitude1 = rp.getDouble(13);
                                    distance = calculateDistance(latitude1, longitude1, latitude2, longitude2);

                                    if (distance < 500) {
                        %>

							    <%
							    Blob blob = rp.getBlob(19);
						        // Convert the Blob data to a byte array
						        byte[] byteArray = blob.getBytes(1, (int) blob.length());
						        // Convert the byte array to a Base64 string
						        String base64Image = javax.xml.bind.DatatypeConverter.printBase64Binary(byteArray);
						        // Generate the data URL for the image
						        String imageUrl = "data:image/jpeg;base64," + base64Image;
						        
						        
						        
							    // Example dates in string format
							    String endDateStr = rp.getString(8); // Format: yyyy-MM-dd HH:mm:ss.S
							
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
								  <div class="card-header bg-transparent border-success">
								  	Remaining Time - <%=days+" days" + " : " + hours + " hrs" + " : " +minutes + " min"%><br>
								  	Distance - <%= distance %>
								  </div>
								  
								  <div class="card-body text-success" style="height: 380px;">
								  	<img class="card-img-top mb-2" src="<%=imageUrl%>" style="height: 150px; object-fit: contain;" alt="Card image cap">
								    <h5 class="card-title"><%=rp.getString(2)%></h5>
							            		<p class="card-text"><i>Price : </i><i class="fas fa-rupee-sign"></i> <%=rp.getString(4) %><p class="card-text">
							            		<p class="card-text"><i>Deposit : </i><i class="fas fa-rupee-sign"></i> <%=rp.getString(5) %><p class="card-text">
							            		<p class="card-text"><i>Start Date : </i><i class="fas fa-calendar-week"></i> <%=rp.getString(7) %><p class="card-text">
							            		<p class="card-text"><i>End Date : </i><i class="fas fa-calendar-week"></i> <%=rp.getString(8) %><p class="card-text">
								  </div>
								  <div class="card-footer bg-transparent border-success">
								  <div class="linkbutton">
								  		<a href="product_details.jsp?ID=<%=rp.getInt(1)%>" class="btn btn-sm btn-outline-info">Details</a>
								  	<!-- Check if the user is the owner, if yes, disable the rent button -->
							           <%System.out.println(email.equals(rp.getString(15))); 
							           if (email.equals(rp.getString(15))) {  %>
							               <h6>My Product</h6>
							           <% } else { %>
							               <a href="update_status.jsp?ID=<%=rp.getInt(1)%>&remail=<%=rp.getString(15)%>&ename=<%=rp.getString(2)%>" 
							               onclick="return confirm('Are you sure you want to rent this product?');"
							               class="btn btn-sm btn-outline-success">Rent</a>
							           <% } %>
							      </div>
								  </div>
								</div>
							     
							
                        <% 
                                    } 
                                }
                            }
                        %>
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
