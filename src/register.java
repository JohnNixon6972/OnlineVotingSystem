import java.util.*;
import java.sql.*;

public class register {
    public static void main(String args[]){
        Scanner scan = new Scanner(System.in);
        System.out.println("------------------------------ Registration Page --------------------");
        String f_name,l_name,address,city,password,dob,adhaar_card_no,constituency,state;
        long mob_num;
        System.out.print("First Name :: ");
        f_name = scan.nextLine();
        System.out.print("Last Name :: ");
        l_name = scan.nextLine();
        System.out.print("Password :: ");
        password = scan.nextLine();
        System.out.print("Address :: ");
        address = scan.nextLine();
        System.out.print("City :: ");
        city = scan.nextLine();
        System.out.print("Mobile Number :: ");
        mob_num = scan.nextLong();
        scan.nextLine();
        System.out.print("Date of Brith (YYYY-MM-DD):: ");
        dob = scan.nextLine();
        System.out.print("Aadhar Card Number :: ");
        adhaar_card_no = scan.nextLine();
        System.out.print("Constituency :: ");
        constituency = scan.nextLine();
        System.out.print("State :: ");
        state = scan.nextLine();

        if(adhaar_card_no.length() != 12){
            System.out.println("Invalid Aadhar number :: ");
            System.exit(0);
        }

        int min_val = 100000;
        int max_val = 999999;
        double randomNum = Math.random() * ( max_val - min_val );
        int id = (int)randomNum;

        System.out.println("Your User ID is :: "+id);

        // System.out.print(f_name+" "+l_name+" "+address+" "+city+" "+mob_num);
        
        scan.close();
        String database_user = "root";
        String database_password = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://root@localhost:3307/online_voting_system", database_user, database_password);
            Statement stmt = con.createStatement();
            String query = String.format("insert into users values(%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%o,\"%s\",\"%s\",\"%s\",\"%s\");",id,password,f_name,l_name,address,city,mob_num,dob,adhaar_card_no,constituency,state);
            // System.out.println(query);
            stmt.executeUpdate(query);
            System.out.println("User Created Sucessfully!!");

            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }   
}
