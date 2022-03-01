<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!doctype html>
<html lang="en">
  <head>
  	<title>Apply As A Candidate</title>
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
					<h2 class="heading-section">Apply as A Candidate</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h4 class="text-center mb-4">Positions available in Election</h4>
					<div class="table-wrap">
						<table class="table">
					    <thead class="thead-primary">
					      <tr>
					        <th>Position Id</th>
					        <th>Position Name</th>
					        <th>Apply</th>
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
				                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
				                    database_user, database_password);
				            Statement stmt = con.createStatement();
				            ResultSet rs = stmt.executeQuery("select * from election_positions where e_id =" + e_id + ";");

				            while(rs.next()){					
				                out.print("<tr>");
				                out.print("<th scope ='row' class='scope'>"+rs.getString(1)+"</th>");
				                out.print("<td>"+rs.getString(3)+"</td>");
				                out.print("<td><a href='confirmpos.jsp?p_id="+rs.getString(1)+"&e_id="+e_id+"' class='btn btn-primary'>Apply</a></td>");
				            }

				            con.close();
				        } catch (Exception e) {
				            System.out.println(e);
				        }

						
						%>
					    </tbody>
					  </table>
					<a href="user_index.jsp"><input type="button" value="Close" name="cancel"></a>
					</div>
				</div>
			</div>
		</div>
	</section>


</body>
	<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
</html>