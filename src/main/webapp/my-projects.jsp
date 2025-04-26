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
<html>
<head>
  <title>My Projects</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">

<div class="container py-5">
  <h2 class="mb-4 text-center">My Projects</h2>

  <% if (userProjects == null || userProjects.isEmpty()) { %>
  <div class="alert alert-info text-center">You haven't created any projects yet.</div>
  <% } else { %>
  <div class="row">
    <% for (Project project : userProjects) { %>
    <div class="col-md-6 mb-4">
      <div class="card shadow rounded-4">
        <div class="card-body">
          <h5 class="card-title"><%= project.getName() %></h5>
          <p class="card-text">
            Deadline: <%= project.getDeadline() %><br>
            Money Needed: $<%= project.getMoneyNeeded() %><br>
            Per Contributor: $<%= project.getMoneyPerContributor() %><br>
            Approved: <%= project.isApproved() ? "Yes" : "No" %><br>
            Status: <%= project.getStatus() %>
          </p>
        </div>
      </div>
    </div>
    <% } %>
  </div>
  <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

