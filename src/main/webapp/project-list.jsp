<%--
  Created by IntelliJ IDEA.
  User: Aina
  Date: 24/04/2025
  Time: 21:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.crowdfunding.crowdfunding.dao.Project" %>
<%@ page import="com.crowdfunding.crowdfunding.dao.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>All Projects</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>
<%
    User currentUser = (User) session.getAttribute("user");
    int userId = currentUser != null ? currentUser.getId() : -1;
%>

<div class="container py-4">
    <h2 class="text-center mb-4">All Projects</h2>

    <div class="row g-4">
        <%
            List<Project> projects = (List<Project>) request.getAttribute("projectList");
            for (Project p : projects) {
                int totalNeeded = p.getMoneyNeeded();
                int perContributor = p.getMoneyPerContributor();
                int currentContributions = p.getContributions();
                int totalRequired = (perContributor != 0) ? totalNeeded / perContributor : 1;
                int progress = (int) (((double) currentContributions / totalRequired) * 100);
        %>
        <div class="col-md-6 col-lg-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><%= p.getName() %></h5>

                    <ul class="list-unstyled mb-3">
                        <li><strong>User ID:</strong> <%= p.getUserId() %></li>
                        <li><strong>Deadline:</strong> <%= p.getDeadline() %></li>
                        <li><strong>Money Needed:</strong> $<%= totalNeeded %></li>
                        <li><strong>Per Contributor:</strong> $<%= perContributor %></li>
                        <li><strong>Status:</strong> <%= p.getStatus() %></li>
                    </ul>

                    <span class="badge <%= p.isApproved() ? "bg-success" : "bg-secondary" %>">
                            <%= p.isApproved() ? "Approved" : "Pending" %>
                        </span>

                    <div class="progress my-3" style="height: 20px;">
                        <div class="progress-bar" role="progressbar"
                             style="width: <%= progress %>%;" aria-valuenow="<%= progress %>"
                             aria-valuemin="0" aria-valuemax="100">
                            <%= progress %>%
                        </div>
                    </div>

                    <p><%= currentContributions %> / <%= totalRequired %> contributions</p>

                    <% if (p.isApproved() && userId != -1) {
                        boolean alreadyContributed = currentUser.getContributions().contains(p.getId());
                        if (alreadyContributed) { %>
                    <p class="text-success"><strong>Already Contributed</strong></p>
                    <% } else { %>
                    <form action="contribute" method="post">
                        <input type="hidden" name="projectId" value="<%= p.getId() %>">
                        <input type="hidden" name="userId" value="<%= userId %>">
                        <button type="submit" class="btn btn-primary w-100">
                            Contribute $<%= perContributor %>
                        </button>
                    </form>
                    <% }
                    } %>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <footer class="text-center mt-5 text-muted">
        © 2025 Crowdfunding Platform
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>



