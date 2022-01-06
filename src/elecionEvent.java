import java.util.*;
import java.sql.*;

public class elecionEvent {
    public static void main(String args[]){
        Scanner scan = new Scanner(System.in);
        
        String election_name,election_type,election_start_date,election_constituency;
        int duration;

        System.out.println("----------------- Election Event Creation ------------------");
        
        System.out.print("Election Name :: ");
        election_name = scan.nextLine();
        System.out.print("Election Consitituency :: ");
        election_constituency = scan.nextLine();
        System.out.print("Election Type (Open/Restricted):: ");
        election_type = scan.nextLine();
        System.out.print("Election Start Date :: ");
        election_start_date = scan.nextLine();
        System.out.print("Election Duration in days :: ");
        duration = scan.nextInt();

        int min_val = 1000;
        int max_val = 9999;
        double randomNum = Math.random() * ( max_val - min_val );
        int election_id = (int)randomNum;
        
        System.out.println(election_name+" "+election_type+" "+election_start_date+" "+duration+" "+election_constituency);
        System.out.println("Election Id for above election is :: "+election_id);
        scan.close();

        String database_user = "john";
        String database_password = "password";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/online_voting_system", database_user, database_password);
            Statement stmt = con.createStatement();
            String query = String.format("insert into election values(%d,\"%s\",\"%s\",\"%s\",%d,\"%s\");",election_id,election_name,election_type,election_start_date,duration,election_constituency);
            System.out.println(query);
            stmt.executeUpdate(query);

            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
