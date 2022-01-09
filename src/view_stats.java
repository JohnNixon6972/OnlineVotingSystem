import java.util.*;
import java.sql.*;

public class view_stats {
    public static void main(String args[]) {
        Scanner scan = new Scanner(System.in);

        System.out.println("---------------------- Election Stats ----------------------");

        String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
                    database_user, database_password);
            Statement stmt = con.createStatement();
            Statement stmt1 = con.createStatement();
            Statement stmt2 = con.createStatement();

            System.out.println("Ongoing Elections :: ");
            System.out.println(
                    "Election ID\tElection Name\tElection Type\tElection start Date\tDuration\tElection Constituency");

            ArrayList<Integer> e_ids = new ArrayList<Integer>();
            ResultSet rs, tmp1, tmp2;
            rs = stmt.executeQuery("select * from election");

            while (rs.next()) {
                System.out.println(rs.getInt(1) + "\t\t" + rs.getString(2) + "\t\t" + rs.getString(3) + "\t\t"
                        + rs.getString(4) + "\t\t" + rs.getInt(5) + "\t\t" + rs.getString(6));
                e_ids.add(rs.getInt(1));
            }
            System.out.print("Enter the Election ID whose Status You want to View :: ");
            int e_id = scan.nextInt();
            scan.nextLine();

            if (!e_ids.contains(e_id)) {
                System.out.println("Invalid Election ID!!");
                System.exit(0);
            }
            rs = stmt.executeQuery("select * from election where e_id = " + e_id + ";");
            rs.next();

            System.out.println("Positions in " + rs.getString(2) + " Election :: ");

            rs = stmt.executeQuery("select * from election_positions where e_id =" + e_id + ";");
            System.out.println("Position ID\tPosition Name");

            while (rs.next()) {
                System.out.println(rs.getString(1) + "\t\t" + rs.getString(3));
            }

            System.out.println("Candidates Applied for the election ::");
            rs = stmt.executeQuery("select * from candidates where e_id = " + e_id + ";");
            System.out.println("Candidate Id\tFirst Name\tLast Name\tPosition Name\tVotes Received");
            while (rs.next()) {
                tmp1 = stmt1.executeQuery("select FirstName,LastName from users where user_id = " + rs.getInt(1) + ";");
                tmp2 = stmt2.executeQuery(
                        "select position_name from election_positions where p_id = \"" + rs.getString(2) + "\";");
                tmp1.next();
                tmp2.next();

                String f_name, l_name, pos_name;
                f_name = tmp1.getString(1);
                l_name = tmp1.getString(2);
                pos_name = tmp2.getString(1);

                System.out.println(
                        rs.getInt(1) + "\t\t" + f_name + "\t\t" + l_name + "\t\t" + pos_name + "\t\t" + rs.getInt(4));
            }

            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        scan.close();
    }
}
