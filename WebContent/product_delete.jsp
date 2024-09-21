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
	int id = Integer.parseInt(request.getParameter("ID"));
	String remail = request.getParameter("remail");
	String ename = request.getParameter("ename");
	String str = "Your Product "+ename+" is 'Deleted' by "+remail;
	
	
	Connection co = Dbconnection.connect();
	PreparedStatement stmt =co.prepareStatement("delete from equipment_data where EID = ?");
	stmt.setInt(1,id);
	int i = stmt.executeUpdate();
	
	
	PreparedStatement sp = co.prepareStatement("INSERT INTO user_messages VALUES(?,?,?,?);");
	sp.setInt(1,0);
	sp.setString(2,ReqConstants.getEmail());
	sp.setString(3, remail);
	sp.setString(4, str);
	int ip = sp.executeUpdate();
	
	
	response.sendRedirect("user_product.jsp");

%>
</html>