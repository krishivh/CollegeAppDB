package DAO;

import model.Colleges;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CollegeDAO {

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
            statement.setFloat(4, averageGPA);
            statement.setInt(5, userID);
            statement.executeUpdate();
            System.out.println("College added successfully!");
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    // Get all colleges for a specific user
    public List<Colleges> getCollegesByUserID(int userID) {
        String sql = "SELECT * FROM Colleges WHERE userID = ?";
        List<Colleges> collegeList = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userID);
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

    // Search colleges by name
    public List<Colleges> searchCollegesByName(String keyword) {
        String sql = "SELECT * FROM Colleges WHERE name LIKE ?";
        List<Colleges> collegeList = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + keyword + "%");
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

    // Delete a college
    public void deleteCollege(int collegeID, int userID) {
        String sql = "DELETE FROM Colleges WHERE collegeID = ? AND userID = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, collegeID);
            statement.setInt(2, userID);
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

    // Update a college
    public void updateCollege(int collegeID, String name, String location, int yearFounded, float averageGPA, int userID) {
        String sql = "UPDATE Colleges SET name = ?, location = ?, yearFounded = ?, averageGPA = ? WHERE collegeID = ? AND userID = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            statement.setString(2, location);
            statement.setInt(3, yearFounded);
            statement.setFloat(4, averageGPA);
            statement.setInt(5, collegeID);
            statement.setInt(6, userID);
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