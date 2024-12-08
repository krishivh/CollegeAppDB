package collegeapp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private Connection connection;

    public UserDAO(Connection connection) {
        this.connection = connection;
    }

    public void registerUser(String username, String password, String email, String role) throws SQLException {
        String query = "INSERT INTO Users (username, password, email, role) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setString(1, username);
        stmt.setString(2, password);
        stmt.setString(3, email);
        stmt.setString(4, role);
        stmt.executeUpdate();
    }

    public boolean loginUser(String username, String password) throws SQLException {
        String query = "SELECT * FROM Users WHERE username = ? AND password = ?";
        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setString(1, username);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();
        return rs.next();
    }
}

