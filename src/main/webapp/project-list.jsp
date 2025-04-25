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
<html>
<head>
    <title>All Projects</title>
    <link rel="stylesheet" href="css/projects-list.css" />
</head>
<body>

<%
    User currentUser = (User) session.getAttribute("user");
    int userId = currentUser != null ? currentUser.getId() : -1;
%>

<h2>All Projects</h2>

<div class="grid">
    <%
        List<Project> projects = (List<Project>) request.getAttribute("projectList");
        for (Project p : projects) {
    %>
    <div class="card">
        <h3><%= p.getName() %></h3>
        <div class="info"><strong>User ID:</strong> <%= p.getUserId() %></div>
        <div class="info"><strong>Deadline:</strong> <%= p.getDeadline() %></div>
        <div class="info"><strong>Money Needed:</strong> $<%= p.getMoneyNeeded() %></div>
        <div class="info"><strong>Per Contributor:</strong> $<%= p.getMoneyPerContributor() %></div>
        <div class="info"><strong>Status:</strong> <%= p.getStatus() %></div>
        <div class="badge <%= p.isApproved() ? "approved" : "rejected" %>">
            <%= p.isApproved() ? "Approved" : "Pending" %>
        </div>

        <% if (p.isApproved() && userId != -1) { %>
        <%
            boolean alreadyContributed = currentUser.getContributions().contains(p.getId());
            if (alreadyContributed) {
        %>
        <p style="margin-top: 10px; color: green;"><strong>Already Contributed</strong></p>
        <%
        } else {
        %>
        <form action="contribute" method="post" style="margin-top: 10px;">
            <input type="hidden" name="projectId" value="<%= p.getId() %>">
            <input type="hidden" name="userId" value="<%= userId %>">
            <button type="submit">Contribute $<%= p.getMoneyPerContributor() %></button>
        </form>
        <%
            }
        %>

        <% } %>
    </div>
    <% } %>
</div>

<div class="footer">© 2025 Crowdfunding Platform</div>

</body>
</html>


