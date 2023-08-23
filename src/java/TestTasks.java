import java.sql.SQLException;
import java.util.List;

public class TestTasks {
    public static void main(String[] args) {
        try {
            List<Task> tasks = new myservlet().getTasksForColumn("for now"); // Replace 'now' with the desired column name
            for (Task task : tasks) {
                System.out.println(task.getName());
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // Print the exception stack trace
        }
    }
}


