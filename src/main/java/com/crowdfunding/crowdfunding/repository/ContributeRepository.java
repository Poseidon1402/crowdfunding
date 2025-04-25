package com.crowdfunding.crowdfunding.repository;

import com.crowdfunding.crowdfunding.utils.DatabaseConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ContributeRepository {
  public void contributeToProject(int userId, int projectId) throws Exception {
    final Connection connection = DatabaseConnector.connect();

    String insertSQL = "INSERT INTO project_user (UserID2, ProjectID2) VALUES (?, ?)";

    PreparedStatement ps = connection.prepareStatement(insertSQL);
    ps.setInt(1, userId);
    ps.setInt(2, projectId);
    ps.executeUpdate();
  }
}
