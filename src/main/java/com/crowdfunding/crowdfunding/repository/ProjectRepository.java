package com.crowdfunding.crowdfunding.repository;

import com.crowdfunding.crowdfunding.dao.Project;
import com.crowdfunding.crowdfunding.utils.DatabaseConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProjectRepository {

  public ProjectRepository() {}

  public List<Project> getProjectsPerApprobationStatus(boolean isApproved) throws Exception {
    List<Project> projects = new ArrayList<>();
    ContributeRepository contributeRepository = new ContributeRepository();

    String SELECT_APPROVED_PROJECTS = "SELECT * FROM project WHERE Is_approved=?";
    final Connection connection = DatabaseConnector.connect();

    PreparedStatement preparedStatement = connection.prepareStatement(SELECT_APPROVED_PROJECTS);
    preparedStatement.setBoolean(1, isApproved);

    ResultSet rs = preparedStatement.executeQuery();

    while (rs.next()) {
      Project project = new Project(
        rs.getInt("ID2"),
        rs.getInt("UserID2"),
        rs.getString("Project_name"),
        rs.getDate("Deadline"),
        rs.getBoolean("Is_approved"),
        rs.getInt("Money_needed"),
        rs.getInt("Money_needed_per_contributor"),
        rs.getString("Status")
      );
      project.setContributions(contributeRepository.getContributionCountByProjectId(project.getId()));
      projects.add(project);
    }

    return projects;
  }

  // ✅ Approve project by setting Is_approved = true
  public void approveProject(int projectId) throws Exception {
    String UPDATE_QUERY = "UPDATE project SET Is_approved = TRUE WHERE ID2 = ?";
    try (Connection connection = DatabaseConnector.connect();
         PreparedStatement statement = connection.prepareStatement(UPDATE_QUERY)) {
      statement.setInt(1, projectId);
      statement.executeUpdate();
    }
  }

  // ❌ Deny project by setting Status = 'denied'
  public void denyProject(int projectId) throws Exception {
    String UPDATE_QUERY = "UPDATE project SET Status = 'denied' WHERE ID2 = ?";
    try (Connection connection = DatabaseConnector.connect();
         PreparedStatement statement = connection.prepareStatement(UPDATE_QUERY)) {
      statement.setInt(1, projectId);
      statement.executeUpdate();
    }
  }

  public void addProject(Project project) throws Exception {
    String INSERT_PROJECT = "INSERT INTO project (UserID2, Project_name, Deadline, Is_approved, Money_needed, Money_needed_per_contributor, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
    Connection connection = DatabaseConnector.connect();

    PreparedStatement statement = connection.prepareStatement(INSERT_PROJECT);

    statement.setInt(1, project.getUserId());
    statement.setString(2, project.getName());
    statement.setDate(3, new java.sql.Date(project.getDeadline().getTime()));
    statement.setBoolean(4, project.isApproved());
    statement.setInt(5, project.getMoneyNeeded());
    statement.setInt(6, project.getMoneyPerContributor());
    statement.setString(7, project.getStatus());

    statement.executeUpdate();
  }
}
