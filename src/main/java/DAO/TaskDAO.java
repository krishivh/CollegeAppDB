package DAO;

import model.Tasks;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/new_schema?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "MyS3cure#2024";

    //add new task. 
    //set name, date, etc
    public void addTask(String taskName, Date dueDate, int userID) {
        String sql = "INSERT INTO Tasks (taskName, dueDate, userID) VALUES (?, ?, ?)";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, taskName);
            statement.setDate(2, dueDate);
            statement.setInt(3, userID);
            statement.executeUpdate();
            System.out.println("Task added successfully!");
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    //get all tasks for a specific user
    public List<Tasks> getAllTasksByUser(int userID) {
        String sql = "SELECT * FROM Tasks WHERE userID = ?";
        List<Tasks> taskList = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);  //sets the user id in the query to filter tasks for a specific user
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Tasks task = new Tasks(
                        resultSet.getInt("taskID"),
                        resultSet.getString("taskName"),
                        resultSet.getDate("dueDate")
                );
                taskList.add(task);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return taskList;
    }

    //edit task for user
    public void updateTask(int taskID, String taskName, Date dueDate, int userID) {
        String sql = "UPDATE Tasks SET taskName = ?, dueDate = ? WHERE taskID = ? AND userID = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, taskName);
            statement.setDate(2, dueDate);
            statement.setInt(3, taskID);
            statement.setInt(4, userID);
            //executes update query
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Task updated successfully!");
            } else {
                System.out.println("No task found with ID: " + taskID + " for this user.");
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    //deletes a task for a specific user, removed from database
    public void deleteTask(int taskID, int userID) {
        String sql = "DELETE FROM Tasks WHERE taskID = ? AND userID = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, taskID);
            statement.setInt(2, userID);
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Task deleted successfully!");
            } else {
                System.out.println("No task found with ID: " + taskID + " for this user.");
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    //implemented to help pront specific details of sql exception
    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause(); //get why error occurred
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
