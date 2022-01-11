import java.util.*;
import java.util.Date;

import com.mysql.cj.util.EscapeTokenizer;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class apply_voter_id {
    public void apply_voter_id_main(String ID) {

        String  para4;
        List<String> para2;
        String voter_id;
        Scanner sc = new Scanner(System.in);
        String database_user = "uhzci14vwfvrompx";
        String database_password = "UrNhWEKwSchauVtObk0x";
        int user_id = Integer.parseInt(ID);

        ArrayList<Integer> u_ids = new ArrayList<Integer>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://uhzci14vwfvrompx:UrNhWEKwSchauVtObk0x@bggkb6uymbi8nrygousy-mysql.services.clever-cloud.com:3306/bggkb6uymbi8nrygousy",
                    database_user, database_password);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("Select user_id from voter_id_list;");
            ResultSet ps;

            while (rs.next()) {
                u_ids.add(rs.getInt(1));
            }

            if (!u_ids.contains(user_id)) {
                // ArrayList<String> DOB = new ArrayList<String>();

                rs = stmt.executeQuery("Select DOB from users where user_id = "+user_id+";");
                while (rs.next()) {
                    Date DOB = rs.getDate(1);
                    String pattern = "yyyy-mm-dd";
                    DateFormat df = new SimpleDateFormat(pattern);

                    String date = df.format(DOB);

                    // para1 = date.substring(0, 4);
                    // para3 = date.substring(5, 7);
                    para4 = date.substring(8, 9);

                    ArrayList<String> adhaar_card = new ArrayList<String>();
                    ps = stmt.executeQuery("Select Adhaar_Card_No from users where user_id = "+user_id+";");
                    while (ps.next()) {
                        System.out.println(ps.getString(1));
                        adhaar_card.add(ps.getString(1));
                        para2 = adhaar_card.subList(0, 1);
                        System.out.print(para2);
                        StringBuilder parameter = new StringBuilder();
                        int i = 0;
                        while (i < para2.size() - 1) {
                            parameter.append(para2.get(i));
                        
                            i++;
                        }
                        parameter.append(para2.get(i));

                        voter_id =  parameter.toString() + para4.toString();

                        System.out.println("Your Voter_ID is follows : " + voter_id);
                        String query = String.format("Insert into voter_id_list values(\"%s\",\"%d\");", voter_id,
                                user_id);
                        System.out.println(query);
                        stmt.executeUpdate(query);
                        System.out
                                .print("Your voter _ id  " + voter_id + "has been successfully added to voter id list");
                    }

                }

            }
            else{
                System.out.println("User Already has Voter ID!!");
            }

        } catch (Exception e) {
            System.out.println(e);
        }

    }

}
