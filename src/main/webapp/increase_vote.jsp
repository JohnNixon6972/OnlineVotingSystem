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
int u_id = Integer.parseInt(session.getAttribute("id_logged_in").toString());
String p_id = request.getParameter("p_id");
int c_id = Integer.parseInt(request.getParameter("c_id"));

String database_user = "uhzci14vwfvrompx";
String database_password = "UrNhWEKwSchauVtObk0x";

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
            database_user, database_password);
    Statement stmt = con.createStatement();
    ResultSet rs;
    String query = String.format("Select no_of_votes from candidates where c_id = \"%d\"", c_id);
    rs = stmt.executeQuery(query);
    int votes_gained;
    while (rs.next()) {
        System.out.println(rs.getInt(1));
        votes_gained = rs.getInt(1) + 1;

        String query7 = String.format(
                "update candidates set no_of_votes =  \"%d\" where c_id = \"%d\" and p_id = \"%s\";",
                votes_gained, c_id, p_id);
        stmt.executeUpdate(query7);
        System.out.print(query7);
        String query9 = String.format("Insert into votes_casted values(\"%d\",\"%d\",\"%d\");", 1, u_id,
                e_id);
        System.out.println(query9);
        stmt.executeUpdate(query9);
    }
    con.close();
} catch (Exception e) {
    System.out.println(e);
}

out.println("<script type=\"text/javascript\">");
out.println("alert('You have Successfully casted your vote!!');");
out.println("location='login.html';");
out.println("</script>");

%>

</body>
</html>