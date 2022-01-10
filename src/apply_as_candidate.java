import java.util.*;
import java.sql.*;

public class apply_as_candidate {
    public void apply_as_candidate_main() {
        Scanner scan = new Scanner(System.in);

        int u_id;
        System.out.println("----------- Apply as Candidate ------------");
        System.out.print("Enter your User ID :: ");
        u_id = scan.nextInt();
        scan.nextLine();

        ArrayList<Integer> u_ids = new ArrayList<Integer>();

        String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("select user_id from users;");

            while (rs.next()) {
                u_ids.add(rs.getInt(1));
            }

            if (u_ids.contains(u_id)) {
                String constituency;

                rs = stmt.executeQuery("select Constituency from users where user_id = " + u_id + ";");
                rs.next();
                constituency = rs.getString(1);

                String query = "select * from election where e_type = \"Open\" or e_constituency = \"" + constituency
                        + "\";";
                // System.out.println(query);
                rs = stmt.executeQuery(query);

                System.out.println("Elections that you are eligible to stand as a Candidate :: ");
                System.out.println(
                        "Election id\tElection name\tElection type\tElection strat date\tDuration in days\tElection Constituency");

                ArrayList<Integer> e_ids = new ArrayList<Integer>();
                while (rs.next()) {
                    System.out.println(rs.getInt(1) + "\t\t" + rs.getString(2) + "\t\t" + rs.getString(3) + "\t\t"
                            + rs.getString(4) + "\t\t" + rs.getInt(5) + "\t\t\t" + rs.getString(6));
                    e_ids.add(rs.getInt(1));
                }

                int e_id;
                System.out.println("Enter the ID of Election you want to apply as candidate :: ");
                e_id = scan.nextInt();
                scan.nextLine();

                if (!e_ids.contains(e_id)) {
                    System.out.println("Invalid Election ID!!");
                    System.exit(0);
                }

                rs = stmt.executeQuery("select * from election_positions where e_id =" + e_id + ";");
                System.out.println("Available positions for the Elections are");

                ArrayList<String> p_ids = new ArrayList<String>();
                System.out.println("Position ID\tPosition Name");
                while (rs.next()) {
                    System.out.println(rs.getString(1) + "\t\t" + rs.getString(3));
                    p_ids.add(rs.getString(1));
                }

                String p_id;
                System.out.print("Enter the Position ID you want to stand for :: ");
                p_id = scan.nextLine();

                if (!p_ids.contains(p_id)) {
                    System.out.println("Invalid Position ID!!");
                    System.exit(0);
                }

                query = "insert into candidates values(" + u_id + ",\"" + p_id + "\"," + e_id + ",0);";
                stmt.executeUpdate(query);
                System.out.println("You have Sucessfully registered as a candidiate!!");

            }

            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }

        System.out.println();
    }

}
