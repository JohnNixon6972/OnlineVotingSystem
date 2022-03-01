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
		//session.invalidate();
		//response.sendRedirect("login.html");
		
		String id = request.getParameter("id");
		String password = request.getParameter("Input_p");
		String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";
		   try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection con = DriverManager.getConnection(
	                "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
	                Statement stmt = con.createStatement();
	                ResultSet rs ;
	                String role;
	                
	                if (id.length() == 4){
	                    rs = stmt.executeQuery("select * from admin");
	                    role = "admin";
	                }
	                else{
	                    rs = stmt.executeQuery("select * from users");
	                    role = "user";
	                }
	                int u_id;
	                String u_password;
	                Boolean is_correct;
	                is_correct = false;
	                
	                while (rs.next()) {
	                    u_id = rs.getInt(1);
	                    u_password = rs.getString(2);
	                    if (u_id == Integer.parseInt(id)) {
	                        if (u_password.equals(password)) {
	                            out.println(
	                                "Welcome back " + rs.getString(3) + " " + rs.getString(4));
	                                is_correct = true;
	                                session.setAttribute("id_logged_in",id);
	                                session.setAttribute("fname",rs.getString(3));
	                                session.setAttribute("lname",rs.getString(4));
	                                if(role == "user"){	                                	
	                                	response.sendRedirect("user_index.jsp");
	                                }
	                                else{
	                                	response.sendRedirect("admin_index.jsp");
	                                }
	                                break;
	                            } else {
	                            	out.println("<script type=\"text/javascript\">");
	    	                    	out.println("alert('InCorrect Password!!');");
	    	                    	out.println("location='login.html';");
	    	                    	out.println("</script>");
	    	              
	                                is_correct = true;
	                                break;
	                            }
	                        }
	                    }
	                    if (!is_correct) {
	                    	out.println("<script type=\"text/javascript\">");
	                    	out.println("alert('InCorrect ID!!');");
	                    	out.println("location='login.html';");
	                    	out.println("</script>");
	                    }
	                    
	                    con.close();
	                } catch (Exception e) {
	                   out.println(e);
	                }
	                // scan.close();
	           
	            
	%>
</body>
</html>