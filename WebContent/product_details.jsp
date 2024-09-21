<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*, connection.Dbconnection"%>


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

<%
	String imageUrl = null;
	String email =null;
	System.out.println(request.getParameter("ID"));
	int id = Integer.parseInt(request.getParameter("ID"));
	
	Connection ct = Dbconnection.connect();
	PreparedStatement stmt = ct.prepareStatement("select * from equipment_data where EID = ?");
	stmt.setInt(1, id);
	ResultSet r = stmt.executeQuery();
	
	if(r.next()){
		System.out.println( r.getString(2));
		email = r.getString(15);
		
		Blob blob = r.getBlob(19);
	    // Convert the Blob data to a byte array
	    byte[] byteArray = blob.getBytes(1, (int) blob.length());
	    // Convert the byte array to a Base64 string
	    String base64Image = javax.xml.bind.DatatypeConverter.printBase64Binary(byteArray);
	    // Generate the data URL for the image
	    imageUrl = "data:image/jpeg;base64," + base64Image;
	}
	
	
		PreparedStatement st = ct.prepareStatement("select * from user_login where Email = ?");
		st.setString(1, email);
		ResultSet rs = st.executeQuery();
		
		rs.next();

%>

<!-- Navbar -->
<jsp:include page="./forAll/navbar.jsp" />

<!-- Container for sidebar, main content, and footer -->
<div class="main">

  <!-- Sidebar -->
   <jsp:include page="./forAll/sidebar.jsp" />

  <!-- Main content -->
<div class="shrinked p-3" id="data">
  <div class="detailscard">
    <!-- Column for the image -->
    <div class="image-column">
      <img src="<%=imageUrl%>" alt="image" class="images">
    </div>
    <div>
    	<a href="view_prod_img.jsp?ID=<%=id%>" class="btn btn-sm btn-outline-info" style="font-size: 25px;"><i class="fa-regular fa-image fa-beat"></i></a>
    </div>
    <!-- Column for the description -->
    <div class="des-column omg mb-4">
    	<h1 class="mb-4"><%=r.getString(2)%></h1>
    	<div class="row mb-4">
            <div class="col input-group">
                <h3><i style="color: #7469B6;">Price : </i> <i class="fas fa-rupee-sign"></i> <%=r.getString(4) %></h3>
            </div>
            <div class="col input-group">
                <h3><i style="color: #7469B6;">Deposit : </i> <i class="fas fa-rupee-sign"></i> <%=r.getString(5) %></h3>
            </div>
        </div>
		<div class="row mb-4">
            <div class="col input-group">
                <h3><i class="fas fa-calendar-week"></i> <%=r.getString(7) %></h3>
            </div>
            <div class="col input-group">
                <h3><i class="fas fa-calendar-week"></i> <%=r.getString(8) %></h3>
            </div>
        </div>
        <div class="row mb-4">
            <div class="col input-group">
                <h4><i class="fa fa-map-marker"></i> <%=r.getString(9) %></h4>
            </div>
            <div class="col input-group">
                <h4><i class="fa fa-map-marker"></i> <%=r.getString(10) %></h4>
            </div>
            <div class="col input-group">
                <h4><i class="fa fa-map-marker"></i> <%=r.getString(11) %></h4>
            </div>
        </div>   
    </div>
  </div>
<hr class="mb-4">
<h2 class="mb-4">Description</h2>
<p><%=r.getString(3) %></p>
<hr class="mb-4">
 <div class="detailscard">
    <!-- Column for the description -->
    <div class="des-column mb-4">
    	<h2 class="mb-4"> Contact Details</h2>
    	<div class="row mb-2">
            <div class="col input-group">
                <h5><i class="fa fa-user"></i><%=rs.getString(2) %></h5>
            </div>
        </div>
		<div class="row mb-2">
            <div class="col input-group">
                <h5><i class="fa fa-envelope"></i></i> <%=rs.getString(4) %></h5>
            </div>
            <div class="col input-group">
                <h5><i class="fas fa-calendar-week"></i> <%=rs.getString(3) %></h5>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col input-group">
                <h5><i class="fa fa-map-marker"></i> <%=rs.getString(6) %></h5>
            </div>
            <div class="col input-group">
                <h5><i class="fa fa-map-marker"></i> <%=rs.getString(7) %></h5>
            </div>
            <div class="col input-group">
                <h5><i class="fa fa-map-marker"></i> <%=rs.getString(8) %></h5>
            </div>
        </div>   
        <div class="row mb-2">
            <div class="col input-group">
                <h5><i class="fa fa-map-marker"></i> <%=rs.getString(9) %></h5>
            </div>
        </div> 
    </div>

</div>
<%
	if(r.getString(17).equals("Rent")&& (r.getString(18).equals("pending")))
	{
		PreparedStatement s = ct.prepareStatement("select * from user_login where Email = ?");
		s.setString(1, r.getString(16));
		ResultSet rp = s.executeQuery();
		
		rp.next();

%>

	<hr class="mb-4">
	 <div class="detailscard">
	    <!-- Column for the description -->
	    <div class="des-column mb-4">
	    	<h2 class="mb-4"> Renter Contact Details</h2>
	    	<h5> Request in waiting state</h5>
	    	<div class="row mb-2">
	            <div class="col input-group">
	                <h5><i class="fa fa-user"></i><%=rp.getString(2) %></h5>
	            </div>
	        </div>
			<div class="row mb-2">
	            <div class="col input-group">
	                <h5><i class="fa fa-envelope"></i></i> <%=rp.getString(4) %></h5>
	            </div>
	            <div class="col input-group">
	                <h5><i class="fas fa-calendar-week"></i> <%=rp.getString(3) %></h5>
	            </div>
	        </div>
	        <div class="row mb-2">
	            <div class="col input-group">
	                <h5><i class="fa fa-map-marker"></i> <%=rp.getString(6) %></h5>
	            </div>
	            <div class="col input-group">
	                <h5><i class="fa fa-map-marker"></i> <%=rp.getString(7) %></h5>
	            </div>
	            <div class="col input-group">
	                <h5><i class="fa fa-map-marker"></i> <%=rp.getString(8) %></h5>
	            </div>
	        </div>   
	        <div class="row mb-2">
	            <div class="col input-group">
	                <h5><i class="fa fa-map-marker"></i> <%=rp.getString(9) %></h5>
	            </div>
	        </div> 
	    </div>
	
	</div>
		
<%
	}
%>

  <!-- Footer -->
    <jsp:include page="./forAll/footer.jsp" />

</div>
</div>

<!-- Include JavaScript files -->
<jsp:include page="./forAll/jsIncludes.jsp" />
<!-- Your custom JS if any -->
<script src="./js/custom.js"></script>
</body>
</html>
