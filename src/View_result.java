import java.util.*;
import java.sql.*;

public class View_result {
    public void view_result_main(String ID) {
        Scanner scan = new Scanner(System.in);
        int u_id = Integer.parseInt(ID);

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

            ArrayList<Integer> u_ids = new ArrayList<Integer>();

            ResultSet rs,c_name,p_name;
            rs = stmt.executeQuery("select user_id from users;");
            while (rs.next()) {
                u_ids.add(rs.getInt(1));
            }

            if (!u_ids.contains(u_id)){
                System.out.println("Invaild User ID!!");
                System.exit(0);
            }
            rs = stmt.executeQuery("select Constituency from users where user_id = "+u_id+";");
            rs.next();
            String constituency = rs.getString(1);

            rs = stmt.executeQuery("select e_id,e_name,e_constituency from election where e_type = \"Open\" or e_constituency = \""+constituency+"\" and result = \"Published\";");

            System.out.println("List of valid Elections ");
            System.out.println("Election ID\tElection Name\tElection Constituency");

            ArrayList<Integer> e_ids = new ArrayList<Integer>();
            while(rs.next()){
                System.out.println(rs.getInt(1)+"\t\t"+rs.getString(2)+"\t\t"+rs.getString(3));
                e_ids.add(rs.getInt(1));
            }
            System.out.print("Enter the ID of Election Whose Result you want to view :: ");
            int e_id = scan.nextInt();
            scan.nextLine();

            if(!e_ids.contains(e_id)){
                System.out.println("Invalid Election ID!!");
                System.exit(0);
            }

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

                System.out.println(rs.getInt(1)+"\t\t"+candidate_name+"\t\t"+position_name+"\t\t"+rs.getInt(3));

            }
            

            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }

    }
}
