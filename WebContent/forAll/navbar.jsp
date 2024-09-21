<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*,connection.Dbconnection, rental_app_java.ReqConstants" %>


<%
    Connection con = Dbconnection.connect();

	PreparedStatement stn = con.prepareStatement("select Photo from user_profile where Uemail = ?");
	stn.setString(1, ReqConstants.getEmail());
	ResultSet r = stn.executeQuery();

%>





<!-- Navbar -->
<div>
  <nav class="navbar">
        <div class="container-fluid">
          <div class="text-light">
            <button class="btn" id="navToggleButton"><i class="fa-solid fa-bars side-nav-button" style="color: #000000; cursor: pointer;"></i></button>
  		  </div>
  		  
  		  <form id="searchForm" class="d-flex" role="search" method="post" action="ReqConstants">
            <input id="searchInput" name="search" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success" type="submit" id="searchButton">Search</button>
            <input type="hidden" id="referringPage" name="referringPage" value="<%= request.getRequestURL() %>">
          </form>
          
          <a class="navbar-brand" href="home_1.jsp">
	      <i class="fa fa-tractor box"></i> 
	        	 Renting App
          </a>
        <ul class="nav nav-tabs">
        <li class="nav-item dropdown" style="padding-right: 30px;">
		    <a class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
		        Profile
		    </a>
		    <div class="dropdown-menu fixed-card" >
		        <div class="card text-center">
		        	
		        	<% if(r.next()) { 
		        	Blob blob = r.getBlob(1);
			        // Convert the Blob data to a byte array
			        byte[] byteArray = blob.getBytes(1, (int) blob.length());
			        // Convert the byte array to a Base64 string
			        String base64Image = javax.xml.bind.DatatypeConverter.printBase64Binary(byteArray);
			        // Generate the data URL for the image
			        String imageUrl = "data:image/jpeg;base64," + base64Image;
			        
			        %>
			        
		            <a href="UserProfile">
		            	<img src="<%=imageUrl%>"  class="card-img-top profile-picture mb-2" alt="User Profile Picture">
		            </a>
		            <% } %>
		              <form action="UserProfile" method="post" enctype="multipart/form-data" class="mt-2">
	                    <label for="fileInput" class="file-label">
	                        <i class="fa fa-upload"></i> Upload
	                    </label>
	                    <input type="file" id="fileInput" name="profile" class="form-control form-control-lg" accept="image/*" required style="display: none;">
	                    <button type="submit" class="btn btn-outline-info btn-sm btn-block">Submit</button>
		            </form>
		            <div class="card-body text-center">
		                <h5 class="card-title"><%= ReqConstants.getUname() %></h5>
		                <p class="card-text"><%= ReqConstants.getEmail() %></p>
		                <p class="card-text"><%= ReqConstants.getContact() %></p>
		            </div>
		        </div>
		    </div>
		</li>
        <li class="nav-item dropdown" style="padding-right: 25px;">
          <a class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a>
          <div class="dropdown-menu fixed-d">
	          <div class="card">
	            <a class="dropdown-item" href="index.jsp">
		            <i class="fa-solid fa-right-to-bracket"></i>
					<span>Login</span>
	            </a>
	            <a class="dropdown-item" href="LogoutUser">
	            	<i class="fa-solid fa-right-from-bracket"></i>
					<span>Logout</span>
	            </a>
	            <a class="dropdown-item" href="user_delete.jsp" onclick="return confirm('Are you sure you want to delete this account?');" >
		            <i class="fa-solid fa-trash"></i>
					<span>Delete Account</span>
				</a>
	            <hr class="mb-1">
	            <a class="dropdown-item" href="request_message.jsp">		            
	            	<i class="fa-solid fa-envelope"></i>
					<span>Prod Req Msg</span>
	            </a>
	            <a class="dropdown-item" href="user_messages.jsp">
		            <i class="fa-solid fa-message"></i>
					<span>User Messages</span>
	            </a>
	          </div>
          </div>
        </li>

      </ul>
        </div>
      </nav>
</div>

<!-- Include jQuery first, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<!-- <img src="/Renting_Project/images/shrink.png" class="card-img-top profile-picture mb-1" alt="User Profile Picture"> -->