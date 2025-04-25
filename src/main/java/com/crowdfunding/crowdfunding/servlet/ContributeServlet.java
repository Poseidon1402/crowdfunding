package com.crowdfunding.crowdfunding.servlet;

import com.crowdfunding.crowdfunding.repository.ContributeRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/contribute")
public class ContributeServlet extends HttpServlet {
  private ContributeRepository repository;

  @Override
  public void init() {
    repository = new ContributeRepository();
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {

    int projectId = Integer.parseInt(request.getParameter("projectId"));
    int userId = Integer.parseInt(request.getParameter("userId"));

    try {
      repository.contributeToProject(userId, projectId);
      response.sendRedirect("projects"); // ✅ redirect to dashboard after contribution
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Contribution failed.");
    }
  }
}

