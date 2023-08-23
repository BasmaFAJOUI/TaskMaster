
import java.util.Date;


public class Task {
    private int id;
    private String name;
    private String desc;
    private String mails;
    private String category;
    private Date date;

    public Task(int id, String name, String desc, String mails, String category, Date date) {
        this.id=id;
        this.name = name;
        this.desc = desc;
        this.mails = mails;
        this.category = category;
        this.date = date;
    }

    public String getDesc() {
        return desc;
    }

    public String getCategory() {
        return category;
    }

    public Date getDate() {
        return date;
    }
  public Task(int id, String name) {
        this.name = name;
        this.id= id;
    }

    public String getMails() {
        return mails;
    }


  
    public String getName() {
        return name;
    }
}


