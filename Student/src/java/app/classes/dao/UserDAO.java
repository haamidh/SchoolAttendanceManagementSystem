package app.classes.dao;

import app.classes.model.User;

import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User validateUser(String username, String password, String role) {
        User user = null;
        String query = "";

        if (role.equals("admin")) {
            query = "SELECT * FROM admin WHERE username = ? AND password = ?";
        } else if (role.equals("teacher")) {
            query = "SELECT * FROM teachers WHERE username = ? AND password = ?";
        }

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, password);

            //System.out.println("Executing query: " + stmt.toString()); // Print the query

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(role);
                    System.out.println("User found: " + user.getUsername() + ", Role: " + user.getRole());
                } else {
                    System.out.println("No user found with the given credentials.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
