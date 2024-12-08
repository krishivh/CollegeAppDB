package DAO;

import model.Colleges;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CollegeDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/new_schema";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "MyS3cure#2024";

    // Add a new college
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get all colleges for a specific user
    public List<Colleges> getCollegesByUserID(int userID) {
        List<Colleges> collegesList = new ArrayList<>();
        String sql = "SELECT * FROM Colleges WHERE userID = ?";
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
                collegesList.add(college);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return collegesList;
    }

    // Delete a college
    public void deleteCollege(int collegeID, int userID) {
        String sql = "DELETE FROM Colleges WHERE collegeID = ? AND userID = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, collegeID);
            statement.setInt(2, userID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Search colleges by name for a specific user
    public List<Colleges> searchCollegesByName(String name, int userID) {
        List<Colleges> collegesList = new ArrayList<>();
        String sql = "SELECT * FROM Colleges WHERE name LIKE ? AND userID = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + name + "%");
            statement.setInt(2, userID);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Colleges college = new Colleges(
                        resultSet.getInt("collegeID"),
                        resultSet.getString("name"),
                        resultSet.getString("location"),
                        resultSet.getInt("yearFounded"),
                        resultSet.getFloat("averageGPA")
                );
                collegesList.add(college);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return collegesList;
    }
}