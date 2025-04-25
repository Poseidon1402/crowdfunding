<%--
  Created by IntelliJ IDEA.
  User: Aina
  Date: 25/04/2025
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.crowdfunding.crowdfunding.dao.Project" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="css/projects-list.css" />
</head>
<body>

<h2>Dasboard</h2>

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

        <% if (!p.isApproved()) { %>
        <form method="post" action="handle-approval" style="margin-top: 15px;">
            <input type="hidden" name="projectId" value="<%= p.getId() %>"/>
            <button class="approve-button" type="submit" name="action" value="approve">Approve</button>
            <button class="deny-button" type="submit" name="action" value="deny">Deny</button>
        </form>
        <% } %>
    </div>
    <% } %>
</div>

<div class="footer">© 2025 Crowdfunding Platform</div>

</body>
</html>

