import java.util.*;
import java.sql.*;

public class electioncancel {
    public static void main(String args[]) {

        String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
                    database_user, database_password);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from election");
            System.out.println(
                    "Election ID\tElection Type\tElection_name\tElection start Date\tDuration\tElection Constituency");

            ArrayList<Integer> e_ids = new ArrayList<Integer>();

            while (rs.next()) {
                System.out.println(rs.getInt(1) + "\t\t" + rs.getString(2) + "\t\t" + rs.getString(3) + "\t\t"
                        + rs.getString(4) + "\t\t" + rs.getInt(5) + "\t\t" + rs.getString(6));
                e_ids.add(rs.getInt(1));
            }

            System.out.print("Enter the ID of Election that has to be cancelled :: ");
            Scanner scan = new Scanner(System.in);
            int e_id = scan.nextInt();

            scan.close();
            if (e_ids.contains(e_id)) {
                stmt.executeUpdate("delete from election where e_id = " + e_id);
                System.out.println("Election with ID " + e_id + " deleted Successfully!!");
            } else {
                System.out.println("Invalid Election ID!!");
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }

    }
}
