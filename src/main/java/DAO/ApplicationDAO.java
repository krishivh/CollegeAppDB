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

   // Fetches a list of colleges associated with a specific user ID
    // Input - userID - The ID of the user whose colleges are being fetched
    // Output - List of Colleges objects representing the user's colleges
    public List<Colleges> getCollegesByUserID(int userID) {
        List<Colleges> collegesList = new ArrayList<>();
        String query = "SELECT name FROM Colleges WHERE userID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setInt(1, userID);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Colleges college = new Colleges();
                    college.setName(rs.getString("name")); // Fetch the college name
                    collegesList.add(college);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return collegesList;
    }

    // Adds a new application record to the database for a user
    // Input: collegeName - Name of the college the application is for
    //        submissionStatus - Current status of the application (e.g., Submitted)
    //        applicationDeadline - Deadline for the application
    //        applicationType - Type of application (e.g., Early Decision)
    //        userID - ID of the user adding the application
    public void addApplication(String collegeName, String submissionStatus, String applicationDeadline, String applicationType, int userID) {
        String query = "INSERT INTO Applications (collegeName, submissionStatus, applicationDeadline, applicationType, userID) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setString(1, collegeName);
            pstmt.setString(2, submissionStatus);
            pstmt.setString(3, applicationDeadline);
            pstmt.setString(4, applicationType);
            pstmt.setInt(5, userID);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Application added successfully for college: " + collegeName);
            } else {
                System.err.println("Failed to add application for college: " + collegeName);
            }

        } catch (SQLException e) {
            System.err.println("Error while adding application: " + e.getMessage());
            e.printStackTrace();
        }
    }


    // Update an existing application with same parameters
    public void updateApplication(int applicationID, String collegeName, String submissionStatus, String applicationDeadline, String applicationType, int userID) {
        String query = "UPDATE Applications SET collegeName = ?, submissionStatus = ?, applicationDeadline = ?, applicationType = ? " +
                "WHERE applicationID = ? AND userID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setString(1, collegeName); // Update collegeName
            pstmt.setString(2, submissionStatus);
            pstmt.setString(3, applicationDeadline);
            pstmt.setString(4, applicationType);
            pstmt.setInt(5, applicationID);
            pstmt.setInt(6, userID);

            // See if record was updated successfully
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Application updated successfully!");
            } else {
                System.out.println("No application found with the provided ID.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Deletes an application record from the database
    // Input: applicationID - ID of the application to delete
    //        userID - ID of the user deleting the application
    public void deleteApplication(int applicationID, int userID) {
        String query = "DELETE FROM Applications WHERE applicationID = ? AND userID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setInt(1, applicationID);
            pstmt.setInt(2, userID);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Application deleted successfully. ID: " + applicationID);
            } else {
                System.err.println("No application found with the provided ID: " + applicationID);
            }

        } catch (SQLException e) {
            System.err.println("Error while deleting application: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Fetches a list of application records for a specific user from the database
    // Input: userID - The ID of the user whose applications are being fetched
    // Output: List of Applications objects representing the user's applications
    public List<Applications> getApplicationsByUserID(int userID) {
        List<Applications> applicationsList = new ArrayList<>();
        String query = "SELECT applicationID, collegeName, submissionStatus, applicationDeadline, applicationType " +
                "FROM Applications " +
                "WHERE userID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            pstmt.setInt(1, userID);

            try (ResultSet rs = pstmt.executeQuery()) {
                // Use getters and setters to retrieve and set parameters
                while (rs.next()) {
                    Applications application = new Applications();
                    application.setApplicationID(rs.getInt("applicationID"));
                    application.setCollegeName(rs.getString("collegeName"));
                    application.setSubmissionStatus(rs.getString("submissionStatus"));
                    application.setApplicationDeadline(rs.getString("applicationDeadline"));
                    application.setApplicationType(rs.getString("applicationType"));

                    applicationsList.add(application);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return applicationsList;
    }
}
