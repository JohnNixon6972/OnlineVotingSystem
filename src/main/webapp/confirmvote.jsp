<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!doctype html>
<html lang="en">
  <head>
  	<title>Vote</title>
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
					<h2 class="heading-section">Vote in Election</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h4 class="text-center mb-4">Candidates Contesting in the Positions</h4>
					<div class="table-wrap">
						<table class="table">
					    <thead class="thead-primary">
					      <tr>
					        <th>Candidate Id</th>
					        <th>Candidate First Name</th>
					        <th>Candidate Last Name</th>
					        <th>Vote</th>
					      </tr>
					    </thead>
					    <tbody>
						<%
						int e_id = Integer.parseInt(request.getParameter("e_id"));
						int u_id = Integer.parseInt(session.getAttribute("id_logged_in").toString());
						String p_id = request.getParameter("p_id");
						String database_user = "uhzci14vwfvrompx";
						String database_password = "UrNhWEKwSchauVtObk0x";
						
						try {
							Class.forName("com.mysql.cj.jdbc.Driver");
				            Connection con = DriverManager.getConnection(
				                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
				                    database_user, database_password);
				            Statement stmt = con.createStatement();
				            Statement stmt1 = con.createStatement();
				            
				            ResultSet rs,rs2;
				            String query = String.format("Select c_id from candidates where p_id = \"%s\" ;", p_id);
				            rs = stmt.executeQuery(query);
				            ArrayList<Integer> u_ids = new ArrayList<Integer>();
				            while(rs.next()){
				            	int c_id = rs.getInt(1);
				            	if(c_id != u_id){
					            	String query1 = "select user_id,FirstName,LastName from users where user_id = "+c_id+";";
					            	rs2 = stmt.executeQuery(query1);
					            	rs2.next();
					            	out.print("<tr>");
					                out.print("<th scope ='row' class='scope'>"+rs2.getInt(1)+"</th>");
					                out.print("<td>"+rs2.getString(2)+"</td>");
					                out.print("<td>"+rs2.getString(3)+"</td>");
					                out.print("<td><a href='increasevote.jsp?p_id="+p_id+"&e_id="+e_id+"&c_id="+rs.getInt(1)+"' class='btn btn-primary'>Confirm Vote</a></td>");
				            	}
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