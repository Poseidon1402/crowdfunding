package com.crowdfunding.crowdfunding.repository;

import com.crowdfunding.crowdfunding.dao.User;
import com.crowdfunding.crowdfunding.utils.DatabaseConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AuthenticationRepository {
  public AuthenticationRepository() {}

  public User findByEmail(String email) {
    try {
      String GET_USER_FROM_EMAIL_QUERY = "SELECT * FROM user WHERE Email = ?";

      final Connection connection = DatabaseConnector.connect();

      PreparedStatement stmt = connection.prepareStatement(GET_USER_FROM_EMAIL_QUERY);
      stmt.setString(1, email);
      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        User user = new User();
        user.setId(rs.getInt("user_id"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        return user;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }
}
