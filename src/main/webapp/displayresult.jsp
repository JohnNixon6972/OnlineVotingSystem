<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!doctype html>
<html lang="en">
  <head>
  	<title>Display Result</title>
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
					<h2 class="heading-section">Election Results</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h4 class="text-center mb-4">Currently Published Election Results</h4>
					<div class="table-wrap">
						<table class="table">
					    <thead class="thead-primary">
					      <tr>
					        <th>Candidate Id</th>
					        <th>Candidate Name</th>
					        <th>Position</th>
					        <th>No. of Votes</th>
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
				            Statement stmt_c_names = con.createStatement();
				            Statement stmt_p_names = con.createStatement();
				            ResultSet rs,c_name,p_name;
							rs = stmt.executeQuery("select e_name from election where e_id = "+e_id+";");
				            rs.next();

				            String e_name = rs.getString(1);

				            System.out.println("Results of "+e_name+" Election are ::");
				            System.out.println("Candidate ID\tCandidate Name\tPosition Name\tNo. Of Votes");

				            rs = stmt.executeQuery("select c_id,p_id,no_of_votes from candidates where e_id ="+e_id+" order by no_of_votes desc;");

				            while(rs.next()){
				                c_name = stmt_c_names.executeQuery("select FirstName from users where user_id = "+rs.getInt(1)+";");
				                c_name.next();
				                p_name = stmt_p_names.executeQuery("select position_name from election_positions where p_id = \""+rs.getString(2)+"\"");
				                p_name.next();
				                
				                String candidate_name,position_name;
				                candidate_name = c_name.getString(1);
				                position_name = p_name.getString(1);
									
				                out.print("<tr>");
				                out.print("<th scope ='row' class='scope'>"+rs.getInt(1)+"</th>");
				                out.print("<td>"+candidate_name+"</td>");
				                out.print("<td>"+position_name+"</td>");
				                out.print("<td>"+rs.getInt(3)+"</td>");

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