import java.util.*;
import java.sql.*;

public class login {
    public String login_main() {
        Scanner scan = new Scanner(System.in);

        String id;
        String password;

        System.out.println("------------------- Welcome to Online Voting System ---------------");
        System.out.print("Enter ID :: ");
        id = scan.nextLine();
        System.out.print("Enter Password :: ");
        password = scan.nextLine();
        
        String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";
        
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
                Statement stmt = con.createStatement();
                ResultSet rs ;
                String role;
                
                if (id.length() == 4){
                    rs = stmt.executeQuery("select * from admin");
                    role = "admin";
                }
                else{
                    rs = stmt.executeQuery("select * from users");
                    role = "user";
                }
                int u_id;
                String u_paasword;
                Boolean is_correct;
                is_correct = false;
                
                while (rs.next()) {
                    u_id = rs.getInt(1);
                    u_paasword = rs.getString(2);
                    if (u_id == Integer.parseInt(id)) {
                        if (u_paasword.equals(password)) {
                            System.out.println(
                                "Welcome back " + rs.getString(3) + " " + rs.getString(4));
                                is_correct = true;
                                return role;
                            } else {
                                System.out.println("Incorrect Password!!");
                                is_correct = true;
                                break;
                            }
                        }
                    }
                    if (!is_correct) {
                        System.out.println("User Does not Exist");
                    }
                    
                    con.close();
                } catch (Exception e) {
                    System.out.println(e);
                }
                // scan.close();
                return "invalid";
            }
        }
        