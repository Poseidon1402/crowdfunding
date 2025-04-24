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

  public List<Project> getAllProjects() throws Exception {
    List<Project> projects = new ArrayList<>();

    String SELECT_ALL_PROJECTS = "SELECT * FROM project";

    final Connection connection = DatabaseConnector.connect();

    PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PROJECTS);

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
        projects.add(project);
      }

    return projects;
}
}
