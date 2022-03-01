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
String f_name,l_name,address,city,password,dob,adhaar_card_no,constituency,state,rep_password;
long mob_num;
f_name = request.getParameter("fname");
l_name = request.getParameter("lname");
address = request.getParameter("address");
city = request.getParameter("city");
password = request.getParameter("pass");
dob = request.getParameter("dob");
adhaar_card_no = request.getParameter("aadhar_no");
rep_password = request.getParameter("re_pass");
constituency = request.getParameter("constituency");
state = request.getParameter("state");
city = request.getParameter("city");
mob_num = Long.parseLong(request.getParameter("mob_no"));

out.println(mob_num);

if(!password.equals(rep_password)){
	out.println("Password does not match");
	System.exit(0);
}

if(adhaar_card_no.length() != 12){
    out.println("Invalid Aadhar number :: ");
    System.exit(0);
 }


int min_val = 100000;
int max_val = 999999;
double randomNum = Math.random() * ( max_val - min_val );
int id = (int)randomNum;

out.println("Your User ID is :: "+id);

// System.out.print(f_name+" "+l_name+" "+address+" "+city+" "+mob_num);

String database_user = "uhzci14vwfvrompx";
String database_password = "UrNhWEKwSchauVtObk0x";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
    Statement stmt = con.createStatement();
    String query = String.format("insert into users values(%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%o,\"%s\",\"%s\",\"%s\",\"%s\");",id,password,f_name,l_name,address,city,mob_num,dob,adhaar_card_no,constituency,state);
    // System.out.println(query);
    stmt.executeUpdate(query);
    out.println("<br>User Created Sucessfully!!");

    con.close();
} catch (Exception e) {
   out.println(e);
}

out.println("<script type=\"text/javascript\">");
out.println("alert('Your id is "+id+"');");
out.println("location='login.html';");
out.println("</script>");
%>

</body>
</html>