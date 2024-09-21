<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import = "java.sql.*, connection.Dbconnection, rental_app_java.ReqConstants" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String email = ReqConstants.getEmail();
	Connection co = Dbconnection.connect();
	PreparedStatement stmt = co.prepareStatement("delete from user_login where Email = ?");
	stmt.setString(1,email);
	int i = stmt.executeUpdate();
	
	PreparedStatement st = co.prepareStatement("delete from equipment_data where Eemail = ?");
	stmt.setString(1,email);
	int n = st.executeUpdate();
	
	response.sendRedirect("index.jsp");

%>

</body>
</html>