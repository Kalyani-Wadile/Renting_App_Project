<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*, connection.Dbconnection"%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Details</title>
<style>
  /* Inline CSS styles */
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
  }

  .container {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }

  /* Other styles */
  .image-column {
    text-align: center;
  }

  .image-column img {
    max-width: 100%;
    height: auto;
  }

  /* Add more styles as needed */
</style>
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






<div class="container">
  <div class="image-column">
    <img src="<%=imageUrl%>" alt="Product Image">
  </div>
  <div class="details-column">
    <h1><%=r.getString(2)%></h1>
    <p><%=r.getString(3)%></p>
    <p>Price: <%=r.getString(4)%></p>
    <p>Deposit: <%=r.getString(5)%></p>
    <p>Availability: <%=r.getString(7)%> - <%=r.getString(8)%></p>
    <!-- Add more details as needed -->
  </div>
</div>
</body>
</html>