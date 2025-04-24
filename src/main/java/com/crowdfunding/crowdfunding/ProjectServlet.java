package com.crowdfunding.crowdfunding;

import com.crowdfunding.crowdfunding.dao.Project;
import com.crowdfunding.crowdfunding.repository.ProjectRepository;

import java.io.*;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "Project", value = "/projects")
public class ProjectServlet extends HttpServlet {
  private ProjectRepository repository;

  @Override
  public void init() {
    repository = new ProjectRepository();
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    List<Project> projectList = null;
    try {
      projectList = repository.getProjectsPerApprobationStatus(true);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }

    request.setAttribute("projectList", projectList);
    RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/project-list.jsp");
    dispatcher.forward(request, response);
  }

  public void destroy() {
  }
}