package com.crowdfunding.crowdfunding.servlet;

import com.crowdfunding.crowdfunding.dao.Project;
import com.crowdfunding.crowdfunding.dao.User;
import com.crowdfunding.crowdfunding.repository.ProjectRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "my-projects", value = "/my-projects")
public class MyProjectsServlet extends HttpServlet {
  private ProjectRepository repository;

  @Override
  public void init() throws ServletException {
    repository = new ProjectRepository();
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    User currentUser = (User) request.getSession().getAttribute("user");

    if (currentUser == null) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    try {
      List<Project> userProjects = repository.getProjectsByUserId(currentUser.getId());
      request.setAttribute("userProjects", userProjects);
      request.getRequestDispatcher("my-projects.jsp").forward(request, response);
    } catch (Exception e) {
      throw new ServletException("Failed to fetch projects", e);
    }
  }
}