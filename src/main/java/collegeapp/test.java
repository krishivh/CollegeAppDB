package collegeapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class test {
    public static void main(String[] args) {
        // Ensure to add the proper database driver to your classpath, e.g., MySQL Connector/J
        String url = "jdbc:mysql://localhost:3306/new_schema";
        String username = "root"; // Replace with your MySQL username
        String password = "MyS3cure#2024"; // Replace with your MySQL password

        try {
            // Establish the connection
            Connection connection = DriverManager.getConnection(url, username, password);

            // Create a statement
            Statement statement = connection.createStatement();

            // Execute the query
            ResultSet resultSet = statement.executeQuery("SELECT * FROM User");

            // Process the results
            while (resultSet.next()) {
                System.out.println(resultSet.getString("first_name"));
            }

            // Close resources
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
