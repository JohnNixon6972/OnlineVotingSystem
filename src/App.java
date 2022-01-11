import java.io.IOException;
import java.util.*;

public class App {
    public static void main(String[] args) throws IOException {
        System.out.println();
        Scanner sc = new Scanner(System.in);
        login l = new login();
        String ID = l.login_main();
        // System.out.println(role);
        // sc.nextLine();
        verify: while (true) {
            while (ID == "invalid") {
                System.out.println("Press 1 to Retry\nPress 2 to Register");
                System.out.print("Enter Choice :: ");
                int choice = sc.nextInt();

                if (choice == 1) {
                    ID = l.login_main();
                } else {
                    register r = new register();
                    r.register_main();
                    ID = l.login_main();
                }
            }

            if (ID.length() != 4) {
                int choice;
                while (true) {
                    System.out.println(
                            "Press 1 to View Result of Election\nPress 2 to Apply as a Candidate for a Election\nPress 3 Vote in a Election\nPress 4 to Apply Voter ID\nPress 5 to View Voter ID Card\nPress 6 to Log-Out");
                    System.out.print("Eneter Choice ::");
                    choice = sc.nextInt();
                    sc.nextLine();

                    switch (choice) {
                        case 1:
                            View_result vr = new View_result();
                            vr.view_result_main(ID);
                            break;
                        case 2:
                            apply_as_candidate apc = new apply_as_candidate();
                            apc.apply_as_candidate_main(ID);
                            break;
                        case 3:
                            vote_in_election vie = new vote_in_election();
                            vie.vote_in_election_main(ID);
                            break;
                        case 4:
                            apply_voter_id avi = new apply_voter_id();
                            avi.apply_voter_id_main(ID);
                            break;
                        case 5:
                            view_voter_id vvi = new view_voter_id();
                            vvi.view_voter_id_main(ID);
                            break;
                        case 6:
                            System.out.print(
                                    "You have Successfully logged out !!!\nPress 1 to login Again or any other number to exit :: ");
                            int opt = sc.nextInt();
                            if (opt != 1) {
                                sc.close();
                                System.exit(0);
                            } else {
                                ID = l.login_main();
                                continue verify;
                            }
                        default:
                            System.out.println("Invalid Choice!!");
                    }

                }

            } else {
                int choice;
                while (true) {
                    System.out.println(
                            "Press 1 to Create Eevent for Election\nPress 2 to Add Positions for a Election\nPress 3 View Stats of Election\nPress 4 to Publish Result of Election\nPress 5 to Cancel Election\nPress 6 to Log-Out");
                    System.out.print("Eneter Choice ::");
                    choice = sc.nextInt();
                    sc.nextLine();

                    switch (choice) {
                        case 1:
                            elecionEvent el = new elecionEvent();
                            el.election_event_main();
                            break;
                        case 2:
                            add_positions ap = new add_positions();
                            ap.add_positions_main();
                            break;
                        case 3:
                            view_stats vs = new view_stats();
                            vs.view_stats_main();
                            break;
                        case 4:
                            publish_result pr = new publish_result();
                            pr.publish_result_main();
                            break;
                        case 5:
                            electioncancel ec = new electioncancel();
                            ec.election_cancel_main();
                            break;
                        case 6:
                            System.out.print(
                                    "You have Successfully logged out !!!\nPress 1 to login Again or any other number to exit :: ");
                            int opt = sc.nextInt();
                            if (opt != 1) {
                                sc.close();
                                System.exit(0);
                            } else {
                                ID = l.login_main();
                                continue verify;
                            }
                        default:
                            System.out.println("Invalid Choice!!");
                    }
                }
            }
            
        }
        
    }
}
