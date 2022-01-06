import java.util.*;
import java.sql.*;

public class apply_voter_id {
    public static void main(String args[]) {

        String constituency, state, voter_id;
        String address, dob;
        String para1, para2, para3;
        String adhaar_card_no;
        Scanner sc = new Scanner(System.in);
        String database_user = "Hrutuja Patnekar";
        String database_password = "root";
        System.out.print("Enter your adhaar card number :");
        adhaar_card_no = sc.nextLine();

        if (adhaar_card_no.length() != 12) {
            System.out.println("Invalid Adhaar Card number!");
            System.exit(0);
        }

        System.out.println("Enter your date of birth(YYYY-MM-DD) : ");
        dob = sc.nextLine();

        System.out.print("Select your constituency : ");
        constituency = sc.nextLine();

        System.out.print("Select your state : ");
        state = sc.nextLine();

        System.out.print("Enter Your address : ");
        address = sc.nextLine();

        para1 = dob.substring(0, 4);
        para2 = adhaar_card_no.substring(4, 8);
        para3 = dob.substring(5, 7)+dob.substring(8, 9);
        ;
        voter_id = para1 + para2 + para3;

        System.out.println(voter_id);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/online_voting_system", database_user, database_password);
            Statement stmt = con.createStatement();
                     

            String query = String.format("Insert into apply_voter_id values(\"%s\",\"%s\",\"%s\",\"%s\", \"%s\", \"%s\");", voter_id,adhaar_card_no, dob, address, constituency, state);
            System.out.println(query);
            stmt.executeUpdate(query);
        } catch (Exception e) {
            System.out.println(e);
            sc.close();

        }

    }

}
