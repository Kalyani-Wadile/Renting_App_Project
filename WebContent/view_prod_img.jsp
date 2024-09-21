<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="connection.Dbconnection"%>

<%  Blob image = null;
	Connection con = null;

	byte[ ] imgData = null ;
	Statement stmt = null;
	ResultSet rs = null;

	try {

		con =Dbconnection.connect();
		stmt = con.createStatement();
		int id = Integer.parseInt(request.getParameter("ID"));
		String sp = "select Image from equipment_data where EID = "+id ;
		
		System.out.println(sp);

		rs = stmt.executeQuery(sp);
		if (rs.next()) {
		image = rs.getBlob(1);

		imgData = image.getBytes(1,(int)image.length());
		
	} else {

			out.println("Display Blob Example");
			out.println("image not found for given id>");

			return;
	}


	// display the image
	
	response.setContentType("image/gif");
	OutputStream o = response.getOutputStream();
	o.write(imgData);
	o.flush();
	o.close();
	
	} catch (Exception e) {

	out.println("Unable To Display image");
	
	return;

	} finally {

	}

%>