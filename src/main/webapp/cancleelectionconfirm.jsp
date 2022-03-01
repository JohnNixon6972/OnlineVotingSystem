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

int e_id = Integer.parseInt(request.getParameter("e_id").toString());


String database_user = "uhzci14vwfvrompx";
String database_password = "UrNhWEKwSchauVtObk0x";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
    Statement stmt = con.createStatement();
    ResultSet rs;
    
    stmt.executeUpdate("delete from votes_casted where e_id = " + e_id);
    stmt.executeUpdate("delete from candidates where e_id = " + e_id);
    stmt.executeUpdate("delete from election_positions where e_id = " + e_id);
    stmt.executeUpdate("delete from election where e_id = " + e_id);
    
    out.println("<script type=\"text/javascript\">");
    out.println("alert('Election Cancelled Successfully!!');");
    out.println("location='Cancelelection.jsp';");
    out.println("</script>");
    
    con.close();
} catch (Exception e) {
    System.out.println(e);
}

%>

</body>
</html>