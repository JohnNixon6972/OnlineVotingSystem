<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!doctype html>
<html lang="en">
  <head>
  	<title>Vote In Election</title>
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
					<h2 class="heading-section">Ongoing Elections</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h4 class="text-center mb-4">Available Election Details</h4>
					<div class="table-wrap">
						<table class="table">
					    <thead class="thead-primary">
					      <tr>
					        <th>Election ID</th>
					        <th>Election Name</th>
					        <th>Vote</th>
					      </tr>
					    </thead>
					    <tbody>
					    <% 
					     int u_id = Integer.parseInt(session.getAttribute("id_logged_in").toString());
					    int e_id, confirm, vote_for_c_id, vote = 1;
				        String constituency, position_id;
				        String database_user = "uhzci14vwfvrompx";
				        String database_password = "UrNhWEKwSchauVtObk0x";

				        try {
				            Class.forName("com.mysql.cj.jdbc.Driver");
				            Connection con = DriverManager.getConnection(
				                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
				                    database_user, database_password);
				            Statement stmt = con.createStatement();
				            Statement stmt_c_names = con.createStatement();
				            Statement stmt_p_names = con.createStatement();
				            ResultSet rs;
				            String query1 = String.format("Select user_id from users where user_id = " + u_id + ";");
				            rs = stmt.executeQuery(query1);
				            rs.next();
				            // System.out.println("Your user_id is as follows :" + rs.getInt(1));

				            String query2 = String.format("Select voter_id from voter_id_list where user_id = " + u_id + ";");
				            rs = stmt.executeQuery(query2);
				            rs.next();
				            System.out.println("Your voter_id is as follows :" + rs.getLong(1));

				            String query3 = String.format("Select constituency from users where user_id = " + u_id + ";");
				            rs = stmt.executeQuery(query3);
				            rs.next();
				            constituency = rs.getString(1);
				            System.out.println("You belong to :" + rs.getString(1) + " Constituency");

				            String open_type = "Open";
				            System.out.println(open_type);
				            String query4 = String.format(
				                    "Select e_id, e_name from election where e_constituency = \"%s\" or e_type = \"%s\" ;",
				                    constituency, open_type);
				            rs = stmt.executeQuery(query4);
				            System.out.println(query4);

				            ArrayList<Integer> e_ids = new ArrayList<Integer>();
				            ArrayList<String> e_names = new ArrayList<String>();
				            while(rs.next()){
				                e_ids.add(rs.getInt(1));
				                
				                out.print("<tr>");
				                out.print("<th scope ='row' class='scope'>"+rs.getInt(1)+"</th>");
				                out.print("<td>"+rs.getString(2)+"</td>");
				                String e_idstr = String.valueOf(rs.getInt(1));
				                
				                out.print("<td><a href='voteredirect.jsp?e_id="+e_idstr+"' class='btn btn-primary'>Vote</a></td>");
				            }
				            
	
					      
					      con.close();
				        } catch (Exception e) {
				            System.out.println(e);
				        }
					      %>
					    </tbody>
					  </table>
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
