package DAO;

import model.Colleges;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CollegeDAO {

    // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/new_schema?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    // Add a new college for a specific user
    public void addCollege(String name, String location, int yearFounded, float averageGPA, int userID) {
        String sql = "INSERT INTO Colleges (name, location, yearFounded, averageGPA, userID) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            statement.setString(2, location);
            statement.setInt(3, yearFounded);
            statement.setFloat(4, averageGPA); // Use float for averageGPA
            statement.setInt(5, userID); // Associate college with userID
            statement.executeUpdate();
            System.out.println("College added successfully!");
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    // Get all Colleges for a specific user
    public List<Colleges> getCollegesByUserID(int userID) {
        String sql = "SELECT * FROM Colleges WHERE userID = ?";
        List<Colleges> collegeList = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID); // Filter by userID
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Colleges college = new Colleges(
                        resultSet.getInt("collegeID"),
                        resultSet.getString("name"),
                        resultSet.getString("location"),
                        resultSet.getInt("yearFounded"),
                        resultSet.getFloat("averageGPA")
                );
                collegeList.add(college);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return collegeList;
    }

    // Delete a college for a specific user
    public void deleteCollege(int collegeID, int userID) {
        String sql = "DELETE FROM Colleges WHERE collegeID = ? AND userID = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, collegeID);
            statement.setInt(2, userID); // Ensure the user is deleting their own college
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("College deleted successfully!");
            } else {
                System.out.println("No college found with ID: " + collegeID + " for this user.");
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    // Update a college for a specific user
    public void updateCollege(int collegeID, String name, String location, int yearFounded, float averageGPA, int userID) {
        String sql = "UPDATE Colleges SET name = ?, location = ?, yearFounded = ?, averageGPA = ? WHERE collegeID = ? AND userID = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            statement.setString(2, location);
            statement.setInt(3, yearFounded);
            statement.setFloat(4, averageGPA); // Use float for averageGPA
            statement.setInt(5, collegeID);  // Ensure you're passing the correct collegeID
            statement.setInt(6, userID);  // Ensure you're passing the correct userID
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("College updated successfully!");
            } else {
                System.out.println("No college found with ID: " + collegeID + " for this user.");
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    // Helper method for printing SQL exceptions
    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
