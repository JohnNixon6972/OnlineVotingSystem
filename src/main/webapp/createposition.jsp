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

int e_id = Integer.parseInt(session.getAttribute("e_id").toString());
int u_id = Integer.parseInt(session.getAttribute("id_logged_in").toString());
String p_name = request.getParameter("pos_name");

String database_user = "uhzci14vwfvrompx";
String database_password = "UrNhWEKwSchauVtObk0x";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
    Statement stmt = con.createStatement();
    ResultSet rs;
    String pos_name,e_s_date,e_constituency,e_name;
    rs = stmt.executeQuery("select * from election where e_id ="+e_id+";"); 
    rs.next();
    e_s_date = rs.getString(4);
    e_constituency = rs.getString(6);
    e_name = rs.getString(2);
    String p_id = (Integer.toString(e_id)).substring(0,2)+e_constituency.substring(1,3)+e_name.substring(1,3)+e_s_date.substring(8)+p_name.substring(2,4);
    System.out.println("Generated Positon ID is :: "+p_id);
    
    String query = String.format("insert into election_positions values(\"%s\",%d,\"%s\");",p_id,e_id,p_name);
    // System.out.println(query);
    stmt.executeUpdate(query);
    
    out.println("<script type=\"text/javascript\">");
    out.println("alert('ID generated for Position is : : "+p_id+"');");
    out.println("location='admin_index.jsp';");
    out.println("</script>");
    
    con.close();
} catch (Exception e) {
    System.out.println(e);
}

%>

</body>
</html>