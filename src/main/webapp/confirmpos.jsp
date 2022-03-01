<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Confirm</title>
</head>
<body><%
int e_id = Integer.parseInt(request.getParameter("e_id"));
String p_id = request.getParameter("p_id");
int u_id = Integer.parseInt(session.getAttribute("id_logged_in").toString());

String database_user = "uhzci14vwfvrompx";
String database_password = "UrNhWEKwSchauVtObk0x";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
    Statement stmt = con.createStatement();
    
    String query = "insert into candidates values(" + u_id + ",\"" + p_id + "\"," + e_id + ",0);";
    stmt.executeUpdate(query);
    out.println("<script type=\"text/javascript\">");
    out.println("alert('Congratulations!! You have Successfully Applied as a Candidate');");
    out.println("location='user_index.jsp';");
    out.println("</script>");
    
    con.close();
} catch (Exception e) {
    System.out.println(e);
}
%>
</body>
</html>