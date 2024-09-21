<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*, connection.Dbconnection, rental_app_java.ReqConstants"%>
<%@ page import="java.time.LocalDateTime, java.time.Duration, java.time.format.DateTimeFormatter"%>    
    
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
	String email = ReqConstants.getEmail();
	String searchValue = ReqConstants.getSearch();
	System.out.println("....................");
	System.out.println(email);
	System.out.println("....................");
	System.out.println(searchValue);
    Connection ct = Dbconnection.connect();
	
    
    PreparedStatement stmt;
    if (searchValue != null) {
        // If search value is not null, query with search condition
        stmt = ct.prepareStatement("SELECT * FROM user_messages WHERE Remail= ? AND Umessage LIKE ?");
        stmt.setString(1, email);
        stmt.setString(2, "%" + searchValue + "%");
        ReqConstants.setSearch(null);
    } else {
        // If search value is null, query without search condition
        stmt = ct.prepareStatement("SELECT * FROM user_messages WHERE Remail= ?");
        stmt.setString(1, email);
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


<div class="card-contain">

<% while (r.next()) {%>
   
    <!-- Individual card -->
    <div class="card border-success mb-3" style="max-width: 20rem;">
	  <div class="card-header bg-transparent border-success">Message To <%=r.getString(3)%></div>
	  <div class="card-body text-success">
	    <h5 class="card-title">From : <%=r.getString(2)%></h5>
	    <p class="card-text text-danger"><%=r.getString(4)%></p>
	  </div>
	  <div class="card-footer bg-transparent border-success">
	  	<a href="message_seen.jsp?ID=<%=r.getString(1)%>" class="btn btn-info">Seen</a>
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
