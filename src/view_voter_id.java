import java.util.*;
import java.sql.*;

public class view_voter_id {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        int u_id;
        String database_user = "Hrutuja Patnekar";
        String database_password = "root";

        System.out.println("Enter your user ID : ");
        u_id = sc.nextInt();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/online_voting_system", database_user, database_password);
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

            sc.close();
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

}
