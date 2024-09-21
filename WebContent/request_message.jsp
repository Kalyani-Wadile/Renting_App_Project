<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.sql.*, connection.Dbconnection, rental_app_java.ReqConstants" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Request Messages of Product</title>
  <!-- Include CSS files -->
  <jsp:include page="./forAll/cssIncludes.jsp" />
  <!-- Custom CSS if any -->
  <link href="./css/custom.css" rel="stylesheet">
  
</head>
<body>

<%
    int i = 1;
    String email = ReqConstants.getEmail();
    String searchValue = ReqConstants.getSearch();
    Connection ct = Dbconnection.connect();
    
    // Get the current date without time
    java.util.Date currentDate = new java.util.Date();
    java.sql.Date currentSqlDate = new java.sql.Date(currentDate.getTime());
    
    PreparedStatement today;
    PreparedStatement other;
    PreparedStatement approve;
    if (searchValue != null) {
        // If search value is not null, query with search condition
        today = ct.prepareStatement("SELECT * FROM equipment_data WHERE (Status ='Rent' AND Eemail = ? AND DATE(Edate) = DATE(?) AND Approvement = 'pending') AND (Ename LIKE ? OR Eemail LIKE ?);");
        today.setString(1, email);
        today.setDate(2, currentSqlDate);
        today.setString(3, "%" + searchValue + "%");
        today.setString(4, "%" + searchValue + "%");
        
        other = ct.prepareStatement("SELECT * FROM equipment_data WHERE (Status ='Rent' AND Eemail = ? AND DATE(Edate) < DATE(?) AND Approvement = 'pending') AND (Ename LIKE ? OR Eemail LIKE ?);");
        other.setString(1, email);
        other.setDate(2, currentSqlDate);
        other.setString(3, "%" + searchValue + "%");
        other.setString(4, "%" + searchValue + "%");
        
        approve = ct.prepareStatement("SELECT * FROM equipment_data WHERE (Status ='Rent' AND Eemail = ? AND Approvement = 'Approve') AND (Ename LIKE ? OR Eemail LIKE ?);");
        approve.setString(1, email);
        approve.setString(2, "%" + searchValue + "%");
        approve.setString(3, "%" + searchValue + "%");
        
        ReqConstants.setSearch(null);
        
    } else {
        // If search value is null, query without search condition
        today = ct.prepareStatement("SELECT * FROM equipment_data WHERE Status ='Rent' AND Eemail = ? AND DATE(Edate) = DATE(?) AND Approvement = 'pending';");
        today.setString(1, email);
        today.setDate(2, currentSqlDate);
        
        other = ct.prepareStatement("SELECT * FROM equipment_data WHERE Status ='Rent' AND Eemail = ? AND DATE(Edate) < DATE(?) AND Approvement = 'pending';");
        other.setString(1, email);
        other.setDate(2, currentSqlDate);
        
        approve = ct.prepareStatement("SELECT * FROM equipment_data WHERE Status ='Rent' AND Eemail = ? AND Approvement = 'Approve'");
        approve.setString(1, email);
      
    }
    ResultSet rt = today.executeQuery();
    ResultSet ro = other.executeQuery();
    ResultSet ra = approve.executeQuery();

    
%>

<!-- Navbar -->
<jsp:include page="./forAll/navbar.jsp" />

<!-- Container for sidebar, main content, and footer -->
<div class="main">

  <!-- Sidebar -->
   <jsp:include page="./forAll/sidebar.jsp" />

  <!-- Main content -->
  <div class="shrinked p-3" id="data">
    <h2 class="mb-5">Request Messages of Product</h2>
    <div class="table-responsive mb-5">
      <h4 class="mb-2">Today Messages</h4>
      <table class="table table-bordered" >
        <thead>
          <tr class="table-primary"> 
            <th>#</th>
            <th>Equipment Name</th>
            <th>Price</th>
            <th>Deposit</th>
            <th>Date</th>
            <th>Start-Date</th>
            <th>End-Date</th>
            <th>Area</th>
            <th>State</th>
            <th>Pin</th>
            <th>Renter Email</th>
            <th>Status</th>
            <th>Approve Status</th>
            <th>Renter Details</th>
            <th>Approve</th>
            <th>Ignore</th>
          </tr>
        </thead>
        <tbody>
          <% while (rt.next()) {
          %>
              <!-- Example row -->
              <tr>
                  <td><%= i++ %></td>
                  <td><%= rt.getString(2)%></td>
                  <td><%= rt.getString(4)%></td>
                  <td><%= rt.getString(5)%></td>
                  <td><%= rt.getString(6)%></td>
                  <td><%= rt.getString(7)%></td>
                  <td><%= rt.getString(8)%></td>
                  <td><%= rt.getString(9)%></td>
                  <td><%= rt.getString(10)%></td>
                  <td><%= rt.getString(11)%></td>
                  <td><%= rt.getString(16)%></td>
                  <td><span class="badge text-bg-warning"><%= rt.getString(17)%></span></td>
                  <td><span class="badge text-bg-secondary"><%= rt.getString(18)%></span></td>
                  <td><a href="product_details.jsp?ID=<%=rt.getInt(1)%>" class="btn btn-outline-primary btn-sm" role="button" aria-pressed="true">Details</a></td>
                  <td><a href="<%= request.getContextPath() %>/HTMLMailer?ID=<%=rt.getInt(1)%>&remail=<%=rt.getString(16)%>&ename=<%=rt.getString(2)%>" 
                      class="btn btn-outline-success btn-sm" 
                      onclick="return confirm('Are you sure you want to approve this request?');" 
                      role="button" aria-pressed="true">Approve</a></td>

                  <td><a href="request_reject.jsp?ID=<%=rt.getInt(1)%>&remail=<%=rt.getString(16)%>&ename=<%=rt.getString(2)%>" 
                      class="btn btn-outline-danger btn-sm" 
                      onclick="return confirm('Are you sure you want to ignore this request?');" 
                      role="button" aria-pressed="true">Ignore</a></td>
              </tr>
              <!-- Add more rows as needed -->
          <% 
              } // end while
          %> 
        </tbody>
      </table>
    </div>
    
    <div class="table-responsive mb-5">
      <h4 class="mb-2">All Messages</h4>
      <table class="table table-bordered" >
        <thead>
          <tr class="table-primary"> 
            <th>#</th>
            <th>Equipment Name</th>
            <th>Price</th>
            <th>Deposit</th>
            <th>Date</th>
            <th>Start-Date</th>
            <th>End-Date</th>
            <th>Area</th>
            <th>State</th>
            <th>Pin</th>
            <th>Renter Email</th>
            <th>Status</th>
            <th>Approve Status</th>
            <th>Renter Details</th>
            <th>Approve</th>
            <th>Ignore</th>
          </tr>
        </thead>
        <tbody>
          <% while (ro.next()) {
          %>
              <!-- Example row -->
              <tr>
                  <td><%= i++ %></td>
                  <td><%= ro.getString(2)%></td>
                  <td><%= ro.getString(4)%></td>
                  <td><%= ro.getString(5)%></td>
                  <td><%= ro.getString(6)%></td>
                  <td><%= ro.getString(7)%></td>
                  <td><%= ro.getString(8)%></td>
                  <td><%= ro.getString(9)%></td>
                  <td><%= ro.getString(10)%></td>
                  <td><%= ro.getString(11)%></td>
                  <td><%= ro.getString(16)%></td>
                  <td><span class="badge text-bg-warning"><%= ro.getString(17)%></span></td>
                  <td><span class="badge text-bg-secondary"><%= ro.getString(18)%></span></td>
                  <td><a href="product_details.jsp?ID=<%=ro.getInt(1)%>" class="btn btn-outline-primary btn-sm" role="button" aria-pressed="true">Details</a></td>
                  <td><a href="<%= request.getContextPath() %>/HTMLMailer?ID=<%=ro.getInt(1)%>&remail=<%=ro.getString(16)%>&ename=<%=ro.getString(2)%>" 
                      class="btn btn-outline-success btn-sm" 
                      onclick="return confirm('Are you sure you want to approve this request?');" 
                      role="button" aria-pressed="true">Approve</a></td>

                  <td><a href="request_reject.jsp?ID=<%=ro.getInt(1)%>&remail=<%=ro.getString(16)%>&ename=<%=ro.getString(2)%>" 
                      class="btn btn-outline-danger btn-sm" 
                      onclick="return confirm('Are you sure you want to ignore this request?');" 
                      role="button" aria-pressed="true">Ignore</a></td>
              </tr>
              <!-- Add more rows as needed -->
          <% 
              } // end while
          %> 
        </tbody>
      </table>
    </div>
    
      <div class="table-responsive mb-5">
      <h4 class="mb-2">Approved Messages</h4>
      <table class="table table-bordered" >
        <thead>
          <tr class="table-primary"> 
            <th>#</th>
            <th>Equipment Name</th>
            <th>Price</th>
            <th>Deposit</th>
            <th>Date</th>
            <th>Start-Date</th>
            <th>End-Date</th>
            <th>Area</th>
            <th>State</th>
            <th>Pin</th>
            <th>Renter Email</th>
            <th>Status</th>
            <th>Approve Status</th>
            <th>Renter Details</th>
            <th>Ignore</th>
          </tr>
        </thead>
        <tbody>
          <% while (ra.next()) {
          %>
              <!-- Example row -->
              <tr>
                  <td><%= i++ %></td>
                  <td><%= ra.getString(2)%></td>
                  <td><%= ra.getString(4)%></td>
                  <td><%= ra.getString(5)%></td>
                  <td><%= ra.getString(6)%></td>
                  <td><%= ra.getString(7)%></td>
                  <td><%= ra.getString(8)%></td>
                  <td><%= ra.getString(9)%></td>
                  <td><%= ra.getString(10)%></td>
                  <td><%= ra.getString(11)%></td>
                  <td><%= ra.getString(16)%></td>
                  <td><span class="badge text-bg-warning"><%= ra.getString(17)%></span></td>
                  <td><span class="badge text-bg-secondary"><%= ra.getString(18)%></span></td>
                  <td><a href="product_details.jsp?ID=<%=ra.getInt(1)%>" class="btn btn-outline-primary btn-sm" role="button" aria-pressed="true">Details</a></td>
                  <td><a href="request_reject.jsp?ID=<%=ra.getInt(1)%>&remail=<%=ra.getString(16)%>&ename=<%=ra.getString(2)%>" 
                      class="btn btn-outline-danger btn-sm" 
                      onclick="return confirm('Are you sure you want to ignore this request?');" 
                      role="button" aria-pressed="true">Ignore</a></td>
              </tr>
              <!-- Add more rows as needed -->
          <% 
              } // end while
          %> 
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
