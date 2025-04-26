package com.crowdfunding.crowdfunding.servlet;

import com.crowdfunding.crowdfunding.dao.Project;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

@WebServlet(name = "add-project", value = "/add-project")
public class CreateProjectServlet extends HttpServlet {

  public void init() {}

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    this.getServletContext().getRequestDispatcher("/add-project.jsp").forward(request, response);
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");

    try {
      int userId = Integer.parseInt(request.getParameter("userId"));
      String name = request.getParameter("name");
      String deadlineStr = request.getParameter("deadline");
      int moneyNeeded = Integer.parseInt(request.getParameter("moneyNeeded"));
      int moneyPerContributor = Integer.parseInt(request.getParameter("moneyPerContributor"));

      java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
      java.util.Date parsedDate = formatter.parse(deadlineStr);
      java.sql.Date deadline = new java.sql.Date(parsedDate.getTime());

      // Default values
      boolean isApproved = false;
      String status = "pending";

      Project newProject = new Project(
        0, // ID is auto-generated
        userId,
        name,
        deadline,
        isApproved,
        moneyNeeded,
        moneyPerContributor,
        status
      );

      com.crowdfunding.crowdfunding.repository.ProjectRepository repo = new com.crowdfunding.crowdfunding.repository.ProjectRepository();
      repo.addProject(newProject);

      request.setAttribute("success", "Project added successfully.");
      this.getServletContext().getRequestDispatcher("/add-project.jsp").forward(request, resp);

    } catch (Exception e) {
      e.printStackTrace();
      request.setAttribute("error", "Error while creating project: " + e.getMessage());
      this.getServletContext().getRequestDispatcher("/add-project.jsp").forward(request, resp);
    }
  }

  public void destroy() {
  }
}