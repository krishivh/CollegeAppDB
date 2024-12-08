package model;

import java.sql.Date;

public class Tasks {
    private int taskID;
    private String taskName;
    private Date dueDate;

    // Constructor
    public Tasks(int taskID, String taskName, Date dueDate) {
        this.taskID = taskID;
        this.taskName = taskName;
        this.dueDate = dueDate;
    }

    // Getters and Setters
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