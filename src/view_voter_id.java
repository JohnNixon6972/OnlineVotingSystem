import java.util.*;
import java.sql.*;

public class view_voter_id {
    public void view_voter_id_main(String ID) {
        Scanner sc = new Scanner(System.in);
        int u_id =Integer.parseInt(ID);
        String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
            Statement stmt = con.createStatement();
            ResultSet rs;
            String query1 = String.format("Select voter_id from voter_id_list where user_id = " + u_id + ";");
            rs = stmt.executeQuery(query1);
            rs.next();
            System.out.println(rs.getString(1));
            System.out.println(query1);
            stmt.executeQuery(query1);

            System.out.println("Your Voter id details are as follows : ");
            System.out.println("Frist Name\tLast Name\tAddress\tConstituency\tState");
            String query = String
                    .format("Select FirstName, LastName, Address,Constituency, State  from users where user_id = "
                            + u_id + ";");
            rs = stmt.executeQuery(query);
            rs.next();
            System.out.println(rs.getString(1) + "\t\t" + rs.getString(2) + "\t\t" + rs.getString(3) + "\t\t"
                    + rs.getString(4) + "\t\t" + rs.getString(5));
            System.out.println(query);
            stmt.executeQuery(query);
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

}
