package model;

import java.sql.Date;

public class Tasks {
    private int taskID;
    private String taskName;
    private Date dueDate;

    //constructor to initialize all vals
    public Tasks(int taskID, String taskName, Date dueDate) {
        this.taskID = taskID;
        this.taskName = taskName;
        this.dueDate = dueDate;
    }

    //getters and setters for ID, name, submission status, due date

    public int getTaskID() {
        return taskID;
    }

    public void setTaskID(int taskID) {
        this.taskID = taskID;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
}
