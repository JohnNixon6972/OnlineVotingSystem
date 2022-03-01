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
String election_name,election_type,election_start_date,election_constituency;
int duration;

election_name = request.getParameter("e_name");
election_constituency = request.getParameter("e_constituency");
election_type = request.getParameter("e_type");
election_start_date = request.getParameter("e_date");
duration = Integer.parseInt(request.getParameter("e_duration"));

int min_val = 1000;
int max_val = 9999;
double randomNum = Math.random() * ( max_val - min_val );
int election_id = (int)randomNum;

out.println(election_name+" "+election_type+" "+election_start_date+" "+duration+" "+election_constituency);
out.println("Election Id for above election is :: "+election_id);

String database_user = "uhzci14vwfvrompx";
String database_password = "UrNhWEKwSchauVtObk0x";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
    Statement stmt = con.createStatement();
    String query = String.format("insert into election values(%d,\"%s\",\"%s\",\"%s\",%d,\"%s\",\"%s\");",election_id,election_name,election_type,election_start_date,duration,election_constituency,"Not Published");
    // System.out.println(query);
    stmt.executeUpdate(query);

    con.close();
} catch (Exception e) {
    System.out.println(e);
}
out.println("<script type=\"text/javascript\">");
out.println("alert('Election Event Created Sucessfully Election ID Generated is : : "+election_id+"');");
out.println("location='admin_index.jsp';");
out.println("</script>");

%>

</body>
</html>