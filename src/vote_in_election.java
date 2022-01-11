import java.util.*;
import java.sql.*;

public class vote_in_election {
    public void vote_in_election_main(String ID) {

        int u_id, e_id, confirm, vote_for_c_id, vote = 1;
        String constituency, position_id;
        String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";

        Scanner sc = new Scanner(System.in);
        u_id = Integer.parseInt(ID);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
                    database_user, database_password);
            Statement stmt = con.createStatement();
            ResultSet rs;
            String query1 = String.format("Select user_id from users where user_id = " + u_id + ";");
            rs = stmt.executeQuery(query1);
            rs.next();
            // System.out.println("Your user_id is as follows :" + rs.getInt(1));

            String query2 = String.format("Select voter_id from voter_id_list where user_id = " + u_id + ";");
            rs = stmt.executeQuery(query2);
            rs.next();
            System.out.println("Your voter_id is as follows :" + rs.getLong(1));

            String query3 = String.format("Select constituency from users where user_id = " + u_id + ";");
            rs = stmt.executeQuery(query3);
            rs.next();
            constituency = rs.getString(1);
            System.out.println("You belong to :" + rs.getString(1) + " Constituency");

            String open_type = "Open";
            System.out.println(open_type);
            String query4 = String.format(
                    "Select e_id, e_name from election where e_constituency = \"%s\" or e_type = \"%s\" ;",
                    constituency, open_type);
            rs = stmt.executeQuery(query4);
            System.out.println(query4);

            ArrayList<Integer> e_ids = new ArrayList<Integer>();
            ArrayList<String> e_names = new ArrayList<String>();
            System.out.println("Election ID\tElection_name");
            while (rs.next()) {
                System.out.println(rs.getInt(1) + "\t\t" + rs.getString(2));
                e_ids.add(rs.getInt(1));
                e_names.add(rs.getString(2));
            }

            System.out.print("Select the election id u would like to vote in : ");
            e_id = sc.nextInt();

            String query = String.format(
                    "Select * from votes_casted where (user_voted = \"%d\" AND user_id = \"%d\" AND e_id = \"%d\")",
                    vote, u_id, e_id);
            rs = stmt.executeQuery(query);
            System.out.println(query);

            if (rs.next() == true) {
                System.out.print("You u have already voted");
                return;
            }

            String query5 = String.format("Select p_id , position_name from election_positions where e_id = %d", e_id);
            rs = stmt.executeQuery(query5);
            System.out.println(query5);
            ArrayList<String> p_ids = new ArrayList<String>();
            ArrayList<String> p_names = new ArrayList<String>();
            System.out.println("Election Position ID\tElection Position Name");
            while (rs.next()) {
                System.out.println(rs.getString(1) + "\t\t" + rs.getString(2));
                p_ids.add(rs.getString(1));
                p_names.add(rs.getString(2));
            }

            System.out.print("Select a position id : ");
            position_id = sc.next();

            String query6 = String.format("Select c_id from candidates where p_id = \"%s\" ;", position_id);
            rs = stmt.executeQuery(query6);
            System.out.println(query6);
            ArrayList<Integer> c_ids = new ArrayList<Integer>();
            System.out.println("Candidate ID ");
            while (rs.next()) {
                System.out.println(rs.getInt(1));
                c_ids.add(rs.getInt(1));
            }
            System.out.print("Select the the candidate id you would like to vote for : ");
            vote_for_c_id = sc.nextInt();

            System.out.print("Enter 1 to cast your vote and 0 to cancel : ");
            confirm = sc.nextInt();

            if (confirm == 1) {
                String query8 = String.format("Select no_of_votes from candidates where c_id = \"%d\"", vote_for_c_id);
                rs = stmt.executeQuery(query8);
                int votes_gained;
                while (rs.next()) {
                    System.out.println(rs.getInt(1));
                    votes_gained = rs.getInt(1) + 1;

                    String query7 = String.format(
                            "update candidates set no_of_votes =  \"%d\" where c_id = \"%d\" and p_id = \"%s\";",
                            votes_gained, vote_for_c_id, position_id);
                    stmt.executeUpdate(query7);
                    System.out.print(query7);
                    String query9 = String.format("Insert into votes_casted values(\"%d\",\"%d\",\"%d\");", vote, u_id,
                            e_id);
                    System.out.println(query9);
                    stmt.executeUpdate(query9);
                }

            } else {
                System.out.print("You cancelled your vote!");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

}
