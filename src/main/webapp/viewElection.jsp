<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!doctype html>
<html lang="en">
  <head>
  	<title>Election Stats</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="css/view_result_style.css">

	</head>
	<body>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">Ongoing Election Details</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h4 class="text-center mb-4">Candidates Applied for the Election</h4>
					<div class="table-wrap">
						<table class="table">
					    <thead class="thead-primary">
					      <tr>
					        <th>Candidate ID</th>
					        <th>First Name</th>
					        <th>Last Name</th>
					        <th>Position Name</th>
					        <th>Votes Received</th>
					        
					      </tr>
					    </thead>
					    <tbody>
					    <% 
					    int e_id = Integer.parseInt(request.getParameter("e_id"));
				        String database_user = "uhzci14vwfvrompx";
				        String database_password = "UrNhWEKwSchauVtObk0x";

				        try {
				        	Class.forName("com.mysql.cj.jdbc.Driver");
				            Connection con = DriverManager.getConnection(
				                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
				            Statement stmt = con.createStatement();
				            Statement stmt1 = con.createStatement();
				            Statement stmt2 = con.createStatement();

				            ResultSet rs, tmp1, tmp2;
				            rs = stmt.executeQuery("select * from candidates where e_id = " + e_id + ";");
				            
				            while(rs.next()){	
				            	tmp1 = stmt1.executeQuery("select FirstName,LastName from users where user_id = " + rs.getInt(1) + ";");
				                tmp2 = stmt2.executeQuery(
				                        "select position_name from election_positions where p_id = \"" + rs.getString(2) + "\";");
				                tmp1.next();
				                tmp2.next();
				                
				                String f_name, l_name, pos_name;
				                f_name = tmp1.getString(1);
				                l_name = tmp1.getString(2);
				                pos_name = tmp2.getString(1);				                
				                
				                out.print("<tr>");
				                out.print("<th scope ='row' class='scope'>"+rs.getInt(1)+"</th>");
				                out.print("<td>"+f_name+"</td>");
				                out.print("<td>"+l_name+"</td>");
				                out.print("<td>"+pos_name+"</td>");
				                out.print("<td>"+rs.getInt(4)+"</td>");
				        
				            }
				            
	
					      
					      con.close();
				        } catch (Exception e) {
				            System.out.println(e);
				        }
					      %>
					    </tbody>
					  </table>
					  <a href="admin_index.jsp"><input type="button" value="Close" name="cancel"></a>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>

	</body>
</html>
