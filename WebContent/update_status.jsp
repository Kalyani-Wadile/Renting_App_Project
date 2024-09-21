<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*, connection.Dbconnection, rental_app_java.ReqConstants, java.text.SimpleDateFormat,java.util.Date"%>    

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
String str = "You have a Request for "+ename+" from "+ReqConstants.getEmail();
		
if(ReqConstants.getEmail() != null && remail != null){
	
	Date currentDate = new Date();		
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
	String today = sdf.format(currentDate);


	Connection co = Dbconnection.connect();


	String email = ReqConstants.getEmail();
	System.out.println(id+email);

	PreparedStatement stmt = co.prepareStatement("update equipment_data set status = 'Rent',Edate=? where EID = ?");
	stmt.setString(1,today);
	stmt.setInt(2,id);
	int i = stmt.executeUpdate();

	PreparedStatement st = co.prepareStatement("update equipment_data set Remail = ? where EID = ?");
	st.setString(1,ReqConstants.getEmail());
	st.setInt(2,id);
	int p = st.executeUpdate();

	PreparedStatement s = co.prepareStatement("update equipment_data set Approvement = 'pending' where EID = ?");
	s.setInt(1,id);
	int n = s.executeUpdate();

	PreparedStatement sp = co.prepareStatement("INSERT INTO user_messages VALUES(?,?,?,?);");
	sp.setInt(1,0);
	sp.setString(2,ReqConstants.getEmail());
	sp.setString(3, remail);
	sp.setString(4, str);
	int ip = sp.executeUpdate();


	response.sendRedirect("order_list.jsp");

	
}else {
	System.out.println("email is null");
	response.sendRedirect("order_list.jsp");
}
		

%>

</body>
</html>