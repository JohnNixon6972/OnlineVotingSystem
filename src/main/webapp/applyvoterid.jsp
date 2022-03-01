<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
String  para4;
List<String> para2;
String voter_id;
String database_user = "uhzci14vwfvrompx";
String database_password = "UrNhWEKwSchauVtObk0x";
String user_id_str = session.getAttribute("id_logged_in").toString();
int user_id = Integer.parseInt(user_id_str);

ArrayList<Integer> u_ids = new ArrayList<Integer>();
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
            database_user, database_password);
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("Select user_id from voter_id_list;");
    ResultSet ps;

    while (rs.next()) {
        u_ids.add(rs.getInt(1));
    }

    if (!u_ids.contains(user_id)) {
        // ArrayList<String> DOB = new ArrayList<String>();

        rs = stmt.executeQuery("Select DOB from users where user_id = "+user_id+";");
        while (rs.next()) {
            Date DOB = rs.getDate(1);
            String pattern = "yyyy-mm-dd";
            DateFormat df = new SimpleDateFormat(pattern);

            String date = df.format(DOB);

            // para1 = date.substring(0, 4);
            // para3 = date.substring(5, 7);
            para4 = date.substring(8, 9);

            ArrayList<String> adhaar_card = new ArrayList<String>();
            ps = stmt.executeQuery("Select Adhaar_Card_No from users where user_id = "+user_id+";");
            while (ps.next()) {
                System.out.println(ps.getString(1));
                adhaar_card.add(ps.getString(1));
                para2 = adhaar_card.subList(0, 1);
                System.out.print(para2);
                StringBuilder parameter = new StringBuilder();
                int i = 0;
                while (i < para2.size() - 1) {
                    parameter.append(para2.get(i));
                
                    i++;
                }
                parameter.append(para2.get(i));

                voter_id =  parameter.toString() + para4.toString();

                System.out.println("Your Voter_ID is follows : " + voter_id);
                String query = String.format("Insert into voter_id_list values(\"%s\",\"%d\");", voter_id,
                        user_id);
                System.out.println(query);
                stmt.executeUpdate(query);
                out.println("<script type=\"text/javascript\">");
            	out.println("alert('Your voter_id  : : " + voter_id + " has been successfully added to voter id list');");
            	out.println("location='login.html';");
            	out.println("</script>");
            }

        }

    }
    else{
        out.println("<script type=\"text/javascript\">");
    	out.println("alert('User Already has Voter ID!!');");
    	out.println("location='user_index.jsp';");
    	out.println("</script>");
    }

} catch (Exception e) {
    System.out.println(e);
}

%>
</body>
</html>