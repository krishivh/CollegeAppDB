package DAO;

import model.User;
import java.sql.*;

public class UserDAO {

    public int registerUser(User user) throws ClassNotFoundException {
        int result = 0;
        String INSERT_USER_SQL = "INSERT INTO user (firstName, lastName, email, phone, password, highSchool, GPA) VALUES (?, ?, ?, ?, ?, ?, ?)";

        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/new_schema?useSSL=false&serverTimezone=UTC", "root", "MyS3cure#2024");
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {

            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getPassword());
            preparedStatement.setString(6, user.getHighSchool());
            preparedStatement.setFloat(7, user.getGPA());

            System.out.println(preparedStatement);
            result = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
        return result;
    }

    public User loginUser(String email, String password) throws ClassNotFoundException {
        User user = null;
        String LOGIN_USER_SQL = "SELECT * FROM user WHERE email = ? AND password = ?";
//access registered user from database for login
        
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/new_schema?useSSL=false&serverTimezone=UTC", "root", "MyS3cure#2024");
             PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_USER_SQL)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    //create user profile and details (this is also what they will see when registering)
                    user = new User(
                            resultSet.getInt("userID"),
                            resultSet.getString("firstName"),
                            resultSet.getString("lastName"),
                            resultSet.getString("email"),
                            resultSet.getString("password"),
                            resultSet.getString("phone"),
                            resultSet.getString("highSchool"),
                            resultSet.getFloat("GPA")
                    );
                }
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return user;  //return the User object (can be null if no match)
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
