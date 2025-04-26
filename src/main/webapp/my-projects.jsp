<%--
  Created by IntelliJ IDEA.
  User: Aina
  Date: 26/04/2025
  Time: 09:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.crowdfunding.crowdfunding.dao.Project" %>
<%
  List<Project> userProjects = (List<Project>) request.getAttribute("userProjects");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dashboard - My Projects</title>
  <link rel="stylesheet" href="css/my-project.css">
</head>
<body>
<div class="container">
  <h2>My Dashboard</h2>
  <div class="row">
    <!-- Project List -->
    <div class="col-8">
      <h4 style="margin-bottom: 20px;">My Projects</h4>
      <% if (userProjects == null || userProjects.isEmpty()) { %>
      <div class="alert">You haven't created any projects yet.</div>
      <% } else { %>
      <div class="row">
        <% for (Project project : userProjects) { %>
        <div style="flex: 1 1 45%; margin-bottom: 30px;">
          <div class="card">
            <h5 class="card-title"><%= project.getName() %></h5>
            <ul class="list-unstyled">
              <li><strong>Deadline:</strong> <%= project.getDeadline() %></li>
              <li><strong>Money Needed:</strong> $<%= project.getMoneyNeeded() %></li>
              <li><strong>Per Contributor:</strong> $<%= project.getMoneyPerContributor() %></li>
              <li><strong>Approved:</strong> <%= project.isApproved() ? "Yes" : "No" %></li>
              <li><strong>Status:</strong> <%= project.getStatus() %></li>
            </ul>
          </div>
        </div>
        <% } %>
      </div>
      <% } %>
    </div>

    <!-- Add New Project -->
    <div class="col-4">
      <div class="card">
        <h5 class="card-title">Add New Project</h5>
        <form action="add-project" method="post">
          <div class="form-group">
            <label for="name">Project Name</label>
            <input type="text" id="name" name="name" required />
          </div>
          <div class="form-group">
            <label for="deadline">Deadline</label>
            <input type="date" id="deadline" name="deadline" required />
          </div>
          <div class="form-group">
            <label for="moneyNeeded">Money Needed</label>
            <input type="number" id="moneyNeeded" name="moneyNeeded" required />
          </div>
          <div class="form-group">
            <label for="moneyPerContributor">Money Per Contributor</label>
            <input type="number" id="moneyPerContributor" name="moneyPerContributor" required />
          </div>
          <button type="submit">Create Project</button>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>



