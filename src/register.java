import java.util.*;
import java.sql.*;

public class register {
    public static void main(String args[]){
        Scanner scan = new Scanner(System.in);
        System.out.println("------------------------------ Registration Page --------------------");
        String f_name,l_name,address,city,password;
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
        

        int min_val = 100000;
        int max_val = 999999;
        double randomNum = Math.random() * ( max_val - min_val );
        int id = (int)randomNum;

        System.out.println("Your User ID is :: "+id);

        // System.out.print(f_name+" "+l_name+" "+address+" "+city+" "+mob_num);
        
        scan.close();
        String database_user = "john";
        String database_password = "password";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/online_voting_system", database_user, database_password);
            Statement stmt = con.createStatement();
            String query = String.format("insert into users values(%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%o);",id,password,f_name,l_name,address,city,mob_num);
            System.out.println(query);
            stmt.executeUpdate(query);
            System.out.println("User Created Sucessfully!!");

            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }   
}
