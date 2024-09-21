<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.sql.*, connection.Dbconnection, rental_app_java.ReqConstants" %>    

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
//&& rp.getString(18).equals(todayDateString)


	int i=1;
	String email = ReqConstants.getEmail();
	Connection ct = Dbconnection.connect();
	PreparedStatement stmt = ct.prepareStatement("select * from equipment_data where Remail = ?");
	stmt.setString(1, email);
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
	    <h2 class="mb-5">My Oders</h2>
	    <div class="table-responsive">
	      <h4 class="mb-2">All</h4>
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
                <th>Provider Email</th>
                <th>Status</th>
                <th>Approve</th>
                <th>Rent</th>
                <th>Cancel</th>
            </tr>
		  	</thead>
             <tbody>
	             <% while(rp.next()) {  %>
					<% if(!email.equals(rp.getString(15))) { %>
						  
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
	                    <td><%= rp.getString(18)%></td>
	                    <td><a href="update_status.jsp?ID=<%=rp.getInt(1)%>&remail=<%=rp.getString(15)%>&ename=<%=rp.getString(2)%>" class="btn btn-outline-success btn-sm active"
	                    onclick="return confirm('Are you sure you want to send the rent message again?');"  
	                    role="button" aria-pressed="true">Resend</a></td> 
	                    <td><a href="product_cancel.jsp?ID=<%=rp.getInt(1)%>&remail=<%=rp.getString(16)%>&ename=<%=rp.getString(2)%>" class="btn btn-outline-primary btn-sm active" 
	                    onclick="return confirm('Are you sure you want to cancel this request?');" 
	                    role="button" aria-pressed="true">Cancel</a></td>
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