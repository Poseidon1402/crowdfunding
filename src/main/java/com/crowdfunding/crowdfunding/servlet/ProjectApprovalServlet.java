package com.crowdfunding.crowdfunding.servlet;

import com.crowdfunding.crowdfunding.repository.ProjectRepository;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "approval", value = "/handle-approval")
public class ProjectApprovalServlet extends HttpServlet {
  private ProjectRepository repository;

  @Override
  public void init() {
    repository = new ProjectRepository();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {

    String projectIdStr = request.getParameter("projectId");
    String action = request.getParameter("action"); // "approve" or "deny"

    if (projectIdStr != null && action != null) {
      try {
        int projectId = Integer.parseInt(projectIdStr);

        if (action.equals("approve")) {
          repository.approveProject(projectId);
        } else if (action.equals("deny")) {
          repository.denyProject(projectId);
        }

      } catch (NumberFormatException e) {
        e.printStackTrace(); // Handle invalid ID
      } catch (Exception e) {
        throw new RuntimeException(e);
      }
    }

    // Redirect back to dashboard after handling
    response.sendRedirect(request.getContextPath() + "/dashboard");
  }

  public void destroy() {
  }
}