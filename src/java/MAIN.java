import java.sql.SQLException;
import java.util.List;

public class MAIN {
    public static void main(String[] args) {
        // Replace these values with your actual database configuration
        String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
        String username = "root";
        String password = "";
        
        int boardId = 1; // Replace with the desired board ID
        
        try {
            myservlet servlet = new myservlet();
            int boardID=54;
            List<String> mappedEmails = servlet.getMappedUserEmailsForBoard(boardID);
            
            System.out.println("Mapped User Emails for Board ID " + boardID + ":");
            for (String email : mappedEmails) {
                System.out.println(email);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}

