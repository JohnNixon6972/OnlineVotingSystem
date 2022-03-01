<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%


int e_id = Integer.parseInt(request.getParameter("e_id"));

String database_user = "uhzci14vwfvrompx";
String database_password = "UrNhWEKwSchauVtObk0x";

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
            database_user, database_password);
    Statement stmt = con.createStatement();
    ResultSet rs;
    stmt.executeUpdate("update election set result = \"Published\" where e_id = " + e_id + ";");
    rs = stmt.executeQuery("select e_name,result from election where e_id = " + e_id + ";");
    rs.next();
  	
if(rs.getString(2) != "Published"){
	out.println("<script type=\"text/javascript\">");
	out.println("alert('Results for "+rs.getString(1)+" election has been Published Sucessfully!!');");
	out.println("location='publishresult.jsp';");
	out.println("</script>");
}else{
	out.println("<script type=\"text/javascript\">");
	out.println("alert('Results for "+rs.getString(1)+" election has already Published!!');");
	out.println("location='publishresult.jsp';");
	out.println("</script>");
}
 
    con.close();
} catch (Exception e) {
    System.out.println(e);
}


%>

</body>
</html>