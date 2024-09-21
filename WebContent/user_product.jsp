<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.sql.*, connection.Dbconnection, rental_app_java.ReqConstants" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<title>MY Products</title>
  <!-- Include CSS files -->
  <jsp:include page="./forAll/cssIncludes.jsp" />
  <!-- Custom CSS if any -->
  <link href="./css/custom.css" rel="stylesheet">
</head>
<body>

<%
//&& rp.getString(18).equals(todayDateString)


	int i=1;
	String email = ReqConstants.getEmail();
	String searchValue = ReqConstants.getSearch();
	Connection ct = Dbconnection.connect();
	
    PreparedStatement stmt;
    if (searchValue != null) {
        // If search value is not null, query with search condition
        stmt = ct.prepareStatement("SELECT * FROM equipment_data WHERE Eemail = ? AND Ename LIKE ?");
        stmt.setString(1, email);
        stmt.setString(2, "%" + searchValue + "%");
        ReqConstants.setSearch(null);
    } else {
        // If search value is null, query without search condition
        stmt = ct.prepareStatement("SELECT * FROM equipment_data WHERE Eemail = ?");
        stmt.setString(1, email);
    }
    ResultSet rp = stmt.executeQuery();
%>




	<!-- Navbar -->
	<jsp:include page="./forAll/navbar.jsp" />
	
	<!-- Container for sidebar, main content, and footer -->
	<div class="main">
	
	  <!-- Sidebar -->
	   <jsp:include page="./forAll/sidebar.jsp" />
	
	  <!-- Main content -->
	  <div class="shrinked p-3" id="data">
	    <h2 class="mb-5">My Products</h2>
	    	   <%
			    String msg = (String) session.getAttribute("message");
			    if(msg != null) {
			    	if(msg == "green"){
			   %>
				<h6 class="text-center mb-2" style="color :green;">The Product is Successfully Added</h6>
			   <%
			    }else {
			    	
			    %>
					<h6 class="text-center mb-2" style="color :red;">The Product get Failed to Add</h6>
				<%
			    }
			    	}
			    session.removeAttribute("message");
			   %>
                
	    <div class="table-responsive">
	      <h4 class="mb-2">All Products</h4>
		  <table class="table table-bordered" >
		  	<thead>
		  		<tr class="table-primary"> 
                <th>#</th>
                <th>Equipment Name</th>
                <th>Price</th>
                <th>Deposit</th>
                <th>Start-Date</th>
                <th>End-Date</th>
                <th>Area</th>
                <th>State</th>
                <th>Pin</th>
                <th>Email</th>
                <th>Status</th>
                <th>Details</th>
                <th>Ignore</th>
            </tr>
		  	</thead>
             <tbody>
	             <% while(rp.next()) {  %>
					<% if(email.equals(rp.getString(15))) { %>
						  
	                <!-- Example row -->
	                <tr>
	                    <td><%= i++ %></td>
	                    <td><%= rp.getString(2)%></td>
	                    <td><%= rp.getString(4)%></td>
	                    <td><%= rp.getString(5)%></td>
	                    <td><%= rp.getString(7)%></td>
	                    <td><%= rp.getString(8)%></td>
	        			<td><%= rp.getString(9)%></td>
	                    <td><%= rp.getString(10)%></td>
	                    <td><%= rp.getString(11)%></td>
	                    <td><%= rp.getString(15)%></td>
	                    <td><%= rp.getString(17)%></td>
	                    <td><a href="product_details.jsp?ID=<%=rp.getInt(1)%>" class="btn btn-outline-primary btn-sm active" role="button" aria-pressed="true">Details</a></td>
	                    <td>
						    <a href="product_delete.jsp?ID=<%=rp.getInt(1)%>&remail=<%=rp.getString(15)%>&ename=<%=rp.getString(2)%>" class="btn btn-outline-success btn-sm active" role="button" aria-pressed="true" onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
						</td> 
	                </tr>
	                <!-- Add more rows as needed -->
	                <% } %>
				<% } %> 
							
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

</body>
</html>