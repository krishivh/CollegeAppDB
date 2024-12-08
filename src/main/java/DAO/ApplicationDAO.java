package DAO;

import model.Applications;
import model.Colleges;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/new_schema?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "MyS3cure#2024";

    // Constructor to initialize the connection
    public ApplicationDAO() {
        // Connection setup is handled per query; no need to store it globally
    }

    // Get colleges by userID (only retrieve college name for now)
    public List<Colleges> getCollegesByUserID(int userID) {
        List<Colleges> collegesList = new ArrayList<>();
        String query = "SELECT c.collegeID, c.name FROM Colleges c WHERE c.userID = ?;";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setInt(1, userID); // Set the user ID parameter

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Colleges college = new Colleges();
                    college.setCollegeID(rs.getInt("collegeID"));
                    college.setName(rs.getString("name"));
                    collegesList.add(college);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }

        return collegesList;
    }

    // Add an application for a user with applicationType
    public void addApplication(int collegeID, String submissionStatus, String applicationDeadline, String applicationType, int userID) {
        String query = "INSERT INTO Applications (collegeID, submissionStatus, applicationDeadline, applicationType, userID) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setInt(1, collegeID);
            pstmt.setString(2, submissionStatus);
            pstmt.setString(3, applicationDeadline);
            pstmt.setString(4, applicationType);  // Add the applicationType
            pstmt.setInt(5, userID);  // Associate the application with the user

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Application added successfully!");
            } else {
                System.out.println("Failed to add application.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception
        }
    }

    // Delete an application by applicationID and userID (to ensure the user can only delete their own applications)
    public void deleteApplication(int applicationID, int userID) {
        String query = "DELETE FROM Applications WHERE applicationID = ? AND userID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setInt(1, applicationID);
            pstmt.setInt(2, userID);  // Ensure the application belongs to this user

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Application deleted successfully!");
            } else {
                System.out.println("No application found with ID: " + applicationID);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception
        }
    }

    // Update an application by applicationID and userID, including the applicationType
    public void updateApplication(int applicationID, String submissionStatus, String applicationDeadline, String applicationType, int userID) {
        String query = "UPDATE Applications SET submissionStatus = ?, applicationDeadline = ?, applicationType = ? " +
                "WHERE applicationID = ? AND userID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setString(1, submissionStatus);
            pstmt.setString(2, applicationDeadline);
            pstmt.setString(3, applicationType);  // Set the updated applicationType
            pstmt.setInt(4, applicationID);
            pstmt.setInt(5, userID);  // Ensure the application belongs to the user

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Application updated successfully!");
            } else {
                System.out.println("No application found with ID: " + applicationID);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception
        }
    }

    // Get applications for a specific userID
    public List<Applications> getApplicationsByUserID(int userID) {
        List<Applications> applicationsList = new ArrayList<>();
        String query = "SELECT a.applicationID, c.name, a.submissionStatus, a.applicationDeadline, a.applicationType " +
                "FROM Applications a " +
                "JOIN Colleges c ON a.collegeID = c.collegeID " +
                "WHERE a.userID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setInt(1, userID); // Set the user ID parameter

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Applications application = new Applications();
                    application.setApplicationID(rs.getInt("applicationID"));
                    application.setCollegeName(rs.getString("name"));
                    application.setSubmissionStatus(rs.getString("submissionStatus"));
                    application.setApplicationDeadline(rs.getString("applicationDeadline"));
                    application.setApplicationType(rs.getString("applicationType")); // Add applicationType field

                    applicationsList.add(application);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception
        }

        return applicationsList;
    }
}
