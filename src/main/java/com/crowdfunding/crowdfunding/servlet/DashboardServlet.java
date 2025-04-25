package com.crowdfunding.crowdfunding.servlet;

import com.crowdfunding.crowdfunding.dao.Project;
import com.crowdfunding.crowdfunding.repository.ProjectRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;

@WebServlet(name = "dashboard", value = "/dashboard")
public class DashboardServlet extends HttpServlet {
  private ProjectRepository repository;

  public void init() {
    repository = new ProjectRepository();
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    List<Project> projectList = null;
    try {
      projectList = repository.getProjectsPerApprobationStatus(false);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }

    request.setAttribute("projectList", projectList);
    this.getServletContext().getRequestDispatcher("/dashboard.jsp").forward(request, response);
  }

  public void destroy() {
  }
}