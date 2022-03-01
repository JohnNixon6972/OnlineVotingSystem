import java.util.*;
import java.sql.*;

public class publish_result {
    public void publish_result_main() {
        Scanner scan = new Scanner(System.in);

        System.out.println("-----------------------------Publish Result-------------------------");
        System.out.println("Available Elections :: ");
        String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
                    database_user, database_password);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from election where result =\"Not Published\";");
            System.out.println(
                    "Election ID\tElection Type\tElection_name\tElection start Date\tDuration\tElection Constituency\tResult");

            ArrayList<Integer> e_ids = new ArrayList<Integer>();

            while (rs.next()) {
                System.out.println(rs.getInt(1) + "\t\t" + rs.getString(2) + "\t\t" + rs.getString(3) + "\t\t"
                        + rs.getString(4) + "\t\t" + rs.getInt(5) + "\t\t" + rs.getString(6) + "\t\t"
                        + rs.getString(7));
                e_ids.add(rs.getInt(1));
            }

            System.out.print("Enter the ID of Election whose result has to be published :: ");
            int e_id = scan.nextInt();
            scan.nextLine();

            if (!e_ids.contains(e_id)) {
                System.out.println("Invalid Election ID!!");
                System.exit(0);
            }

            stmt.executeUpdate("update election set result = \"Published\" where e_id = " + e_id + ";");
            rs = stmt.executeQuery("select e_name,result from election where e_id = " + e_id + ";");
            rs.next();
            String e_name, result;
            e_name = rs.getString(1);
            result = rs.getString(2);
            System.out.println(result);

            if (result != "Published") {
                System.out.println("Published Result for " + e_name + " election successfully !!");
            } else {
                System.out.println("Result for " + e_name + " election is already published!!");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
