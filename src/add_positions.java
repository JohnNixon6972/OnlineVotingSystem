import java.util.*;
import java.sql.*;
public class add_positions {
    public static void main(String args[]){
        Scanner scan = new Scanner(System.in);

        System.out.println("------------ Add positions for election ----------");
        System.out.println("Current Upcomming Election Events :: ");
        
        String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy", database_user, database_password);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from election");
            System.out.println("Election ID\tElection_name\tElection Type\tElection start Date\tDuration\tElection Constituency");

            ArrayList<Integer> e_ids = new ArrayList<Integer>();

            while (rs.next()) {
                System.out.println(rs.getInt(1)+"\t\t"+rs.getString(2)+"\t\t"+rs.getString(3)+"\t\t"+rs.getString(4)+"\t\t"+rs.getInt(5)+"\t\t"+rs.getString(6));
                e_ids.add(rs.getInt(1));
                
            }

            System.out.println();
            System.out.print("Enter the Election Id in which you want to add Positions for :: ");
            int e_id = scan.nextInt();
            System.out.println();

            scan.nextLine();

            if (e_ids.contains(e_id)){
                rs = stmt.executeQuery("select * from election where e_id ="+e_id+";"); 
                rs.next();

                String pos_name,e_s_date,e_constituency,e_name;
                System.out.print("Enter the Position name :: ");
                pos_name = scan.nextLine();
                
                e_s_date = rs.getString(4);
                e_constituency = rs.getString(6);
                e_name = rs.getString(2);

                String p_id = (Integer.toString(e_id)).substring(0,2)+e_constituency.substring(1,3)+e_name.substring(1,3)+e_s_date.substring(8)+pos_name.substring(2,4);
                System.out.println("Generated Positon ID is :: "+p_id);

                String query = String.format("insert into election_positions values(\"%s\",%d,\"%s\");",p_id,e_id,pos_name);
                // System.out.println(query);
                stmt.executeUpdate(query);

                System.out.println("Added "+pos_name+" position to "+e_name+" election successfully!!");
                
            }
            else{
                System.out.println("Invalid Election ID!!");
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }


        scan.close();
    }
}
