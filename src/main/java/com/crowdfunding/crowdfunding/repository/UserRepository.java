package com.crowdfunding.crowdfunding.repository;

import com.crowdfunding.crowdfunding.dao.User;
import com.crowdfunding.crowdfunding.utils.DatabaseConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserRepository {
  public void loadUserContributions(User user) throws Exception {
    final Connection connection = DatabaseConnector.connect();

    String sql = "SELECT ProjectID2 FROM project_user WHERE UserID2 = ?";
    PreparedStatement ps = connection.prepareStatement(sql);
    ps.setInt(1, user.getId());

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
      int projectId = rs.getInt("ProjectID2");
      user.addContribution(projectId);
    }

    rs.close();
    ps.close();
    connection.close();
  }

}
