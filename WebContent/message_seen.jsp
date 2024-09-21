<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import = "java.sql.*, connection.Dbconnection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	int id = Integer.parseInt(request.getParameter("ID"));
	Connection co = Dbconnection.connect();
	PreparedStatement stmt =co.prepareStatement("delete from user_messages where UID = ?");
	stmt.setInt(1,id);
	int i = stmt.executeUpdate();
	
	response.sendRedirect("user_messages.jsp");

%>