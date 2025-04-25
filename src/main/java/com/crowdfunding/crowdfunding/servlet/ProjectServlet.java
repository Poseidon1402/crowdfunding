package com.crowdfunding.crowdfunding.servlet;

import com.crowdfunding.crowdfunding.dao.Project;
import com.crowdfunding.crowdfunding.dao.User;
import com.crowdfunding.crowdfunding.repository.ProjectRepository;
import com.crowdfunding.crowdfunding.repository.UserRepository;

import java.io.*;
import java.util.ArrayList;
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
  private UserRepository userRepository;

  @Override
  public void init() {
    repository = new ProjectRepository();
    userRepository = new UserRepository();
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    List<Project> projectList = new ArrayList<>();
    try {
      projectList = repository.getProjectsPerApprobationStatus(true);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }

    User currentUser = (User) request.getSession().getAttribute("user");
    try {
      userRepository.loadUserContributions(currentUser);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
    request.getSession().setAttribute("user", currentUser);
    request.setAttribute("projectList", projectList);
    RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/project-list.jsp");
    dispatcher.forward(request, response);
  }

  public void destroy() {
  }
}