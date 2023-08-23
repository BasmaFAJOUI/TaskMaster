public class Tasktodo {
    private int taskId;
    private String taskName;
    private String description;
    private String date;
                private boolean isCompleted;


    public Tasktodo(int taskId, String taskName, String description, String date) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.description = description;
        this.date = date;


    }
         public boolean isCompleted() {
        return isCompleted;
         }
    public int getTaskId() {
        return taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public String getDescription() {
        return description;
    }

    public String getDate() {
        return date;
    }
     public void setCompleted(boolean completed) {
        isCompleted = completed;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setIsCompleted(boolean isCompleted) {
        this.isCompleted = isCompleted;
    }

    public boolean isIsCompleted() {
        return isCompleted;
    }
}
