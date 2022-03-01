<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
<style type="text/css">
body{
    color: #6F8BA4;
    margin-top:20px;
}
.section {
    padding: 100px 0;
    position: relative;
}
.gray-bg {
    background-color: #f5f5f5;
}
img {
    max-width: 100%;
}
img {
    vertical-align: middle;
    border-style: none;
}
/* About Me 
---------------------*/
.about-text h3 {
  font-size: 45px;
  font-weight: 700;
  margin: 0 0 6px;
}
@media (max-width: 767px) {
  .about-text h3 {
    font-size: 35px;
  }
}
.about-text h6 {
  font-weight: 600;
  margin-bottom: 15px;
}
@media (max-width: 767px) {
  .about-text h6 {
    font-size: 18px;
  }
}
.about-text p {
  font-size: 18px;
  max-width: 450px;
}
.about-text p mark {
  font-weight: 600;
  color: #20247b;
}

.about-list {
  padding-top: 10px;
}
.about-list .media {
  padding: 5px 0;
}
.about-list label {
  color: #20247b;
  font-weight: 600;
  width: 88px;
  margin: 0;
  position: relative;
}
.about-list label:after {
  content: "";
  position: absolute;
  top: 0;
  bottom: 0;
  right: 11px;
  width: 1px;
  height: 12px;
  background: #20247b;
  -moz-transform: rotate(15deg);
  -o-transform: rotate(15deg);
  -ms-transform: rotate(15deg);
  -webkit-transform: rotate(15deg);
  transform: rotate(15deg);
  margin: auto;
  opacity: 0.5;
}
.about-list p {
  margin: 0;
  font-size: 15px;
}

@media (max-width: 991px) {
  .about-avatar {
    margin-top: 30px;
  }
}

.about-section .counter {
  padding: 22px 20px;
  background: #ffffff;
  border-radius: 10px;
  box-shadow: 0 0 30px rgba(31, 45, 61, 0.125);
}
.about-section .counter .count-data {
  margin-top: 10px;
  margin-bottom: 10px;
}
.about-section .counter .count {
  font-weight: 700;
  color: #20247b;
  margin: 0 0 5px;
}
.about-section .counter p {
  font-weight: 600;
  margin: 0;
}
mark {
    background-image: linear-gradient(rgba(252, 83, 86, 0.6), rgba(252, 83, 86, 0.6));
    background-size: 100% 3px;
    background-repeat: no-repeat;
    background-position: 0 bottom;
    background-color: transparent;
    padding: 0;
    color: currentColor;
}
.theme-color {
    color: #fc5356;
}
.dark-color {
    color: #20247b;
}


</style>
    <!--  This file has been downloaded from bootdey.com @bootdey on twitter -->
    <!--  All snippets are MIT license http://bootdey.com/license -->
    <title>about me - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<%

String database_user = "uhzci14vwfvrompx";
String database_password = "UrNhWEKwSchauVtObk0x";

try {
	
	String user_id_str = session.getAttribute("id_logged_in").toString();
	int u_id = Integer.parseInt(user_id_str);
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
    Statement stmt = con.createStatement();
    ResultSet rs;
    String query = String
            .format("Select FirstName, LastName, Address,Constituency, State,Adhaar_card_no,DOB  from users where user_id = "+ u_id + ";");
    rs = stmt.executeQuery(query);
    rs.next();
    
    String f_name,l_name,address,constituency,state,dob,aadhar_no;
    f_name = rs.getString(1);
    l_name = rs.getString(2);
    address = rs.getString(3);
    constituency = rs.getString(4);
    state = rs.getString(5);
    aadhar_no = rs.getString(6);
    dob = rs.getString(7);
    
    query = String.format("Select Voter_ID from voter_id_list where user_id = "+ u_id + ";");
    rs = stmt.executeQuery(query);
    rs.next();
    
    String voter_id = rs.getString(1);
    
    session.setAttribute("f_name",f_name);
    session.setAttribute("l_name",l_name);
    session.setAttribute("address",address);
    session.setAttribute("constituency",constituency);
    session.setAttribute("state",state);
    session.setAttribute("aadhar_no",aadhar_no);
    session.setAttribute("dob",dob);
    session.setAttribute("voter_id",voter_id);
    
    System.out.println(rs.getString(1) + "\t\t" + rs.getString(2) + "\t\t" + rs.getString(3) + "\t\t"
            + rs.getString(4) + "\t\t" + rs.getString(5));
    System.out.println(query);
    stmt.executeQuery(query);
    con.close();
} catch (Exception e) {
    System.out.println(e);
}

%>
<section class="section about-section gray-bg" id="about">
            <div class="container">
                <div class="row align-items-center flex-row-reverse">
                    <div class="col-lg-6">
                        <div class="about-text go-to">
                            <h3 class="dark-color">Voter ID</h3>
                            <div class="row about-list">
                                <div class="col-md-6">
                                    <div class="media">
                                        <label>First Name</label>
                                        <p><% out.print(session.getAttribute("f_name").toString());%></p>
                                    </div>
                                    <div class="media">
                                        <label>Last Name</label>
                                        <p><% out.print(session.getAttribute("l_name").toString());%></p>
                                    </div>
                                    <div class="media">
                                        <label>Voter ID</label>
                                        <p><% out.print(session.getAttribute("voter_id").toString());%></p>
                                    </div>
                                    <div class="media">
                                        <label>Address</label>
                                        <p><% out.print(session.getAttribute("address").toString());%></p>
                                    </div>
                                    <div class="media">
                                        <label>Constituency</label>
                                        <p><% out.print(session.getAttribute("constituency").toString());%></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="media">
                                        <label>Date of Birth</label>
                                        <p><% out.print(session.getAttribute("dob").toString());%></p>
                                    </div>
                                    <div class="media">
                                        <label>Aadhar Card Number</label>
                                        <p><% out.print(session.getAttribute("aadhar_no").toString());%></p>
                                    </div>
                                </div>
                            </div>
                            <button onclick="history.back()">Go Back</button>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="about-avatar">
                            <img src="https://bootdey.com/img/Content/avatar/avatar7.png" title="" alt="">
                        </div>
                    </div>
                </div>
              
            </div>
        </section>



</body>
	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
</html>