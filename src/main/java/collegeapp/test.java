package collegeapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class test {
    public static void main(String[] args) {
        //connects to mysql workbench database
        String url = "jdbc:mysql://localhost:3306/new_schema";
        String username = "root"; 
        String password = "MyS3cure#2024"; 

        try {
            //establish connection
            Connection connection = DriverManager.getConnection(url, username, password);

            //create statement
            Statement statement = connection.createStatement();

            //query execution
            ResultSet resultSet = statement.executeQuery("SELECT * FROM User");

            //result processing
            while (resultSet.next()) {
                System.out.println(resultSet.getString("first_name"));
            }

            //close connection
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
