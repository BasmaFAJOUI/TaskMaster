import java.sql.*;
import java.util.*;

public class test {

    public static void main(String[] args) {
        int userId = 48; // Replace with the user ID for whom you want to fetch boards

        try {
            List<String> boardNames = fetchUserBoardsFromDatabase(userId);
            System.out.println("User Boards:");
            for (String boardName : boardNames) {
                System.out.println(boardName);
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
    }

    public static List<String> fetchUserBoardsFromDatabase(int userId) throws ClassNotFoundException, SQLException {
        List<String> boardNames = new ArrayList<>();

        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
            String sql = "SELECT kb.board_name FROM kanban_boards kb INNER JOIN user_board_mapping ubm ON kb.board_id = ubm.board_id WHERE ubm.user_id = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String boardName = rs.getString("kb.board_name");
                        boardNames.add(boardName);
                    }
                }
            }
        }

        return boardNames;
    }
}
