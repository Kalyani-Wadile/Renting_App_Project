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
	String str = "Your Request of "+ename+" is 'Ignored' by "+ReqConstants.getEmail();
	
	Connection co = Dbconnection.connect();
	
	
	PreparedStatement stmt = co.prepareStatement("update equipment_data set Approvement = 'Ignored', Status = 'Not_Rent' where EID = ?");
	stmt.setInt(1,id);
	int i = stmt.executeUpdate();
	
	PreparedStatement sp = co.prepareStatement("INSERT INTO user_messages VALUES(?,?,?,?);");
	sp.setInt(1,0);
	sp.setString(2,ReqConstants.getEmail());
	sp.setString(3, remail);
	sp.setString(4, str);
	int ip = sp.executeUpdate();
	
	
	PreparedStatement stm = co.prepareStatement("update equipment_data set Remail= 'NULL' where EID = ?");
	stm.setInt(1,id);
	int p = stm.executeUpdate();
	
	
	response.sendRedirect("request_message.jsp");


%>

</body>
</html>