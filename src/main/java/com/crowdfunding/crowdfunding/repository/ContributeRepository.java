package com.crowdfunding.crowdfunding.repository;

import com.crowdfunding.crowdfunding.utils.DatabaseConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ContributeRepository {
  public void contributeToProject(int userId, int projectId) throws Exception {
    final Connection connection = DatabaseConnector.connect();

    String insertSQL = "INSERT INTO project_user (UserID2, ProjectID2) VALUES (?, ?)";

    PreparedStatement ps = connection.prepareStatement(insertSQL);
    ps.setInt(1, userId);
    ps.setInt(2, projectId);
    ps.executeUpdate();
  }

  public int getContributionCountByProjectId(int projectId) throws Exception {
    final Connection connection = DatabaseConnector.connect();

    String query = "SELECT COUNT(*) FROM project_user WHERE ProjectID2 = ?";
    PreparedStatement ps = connection.prepareStatement(query);
    ps.setInt(1, projectId);

    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
      return rs.getInt(1);
    }

    return 0;
  }
}
