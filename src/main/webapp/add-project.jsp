<%--
  Created by IntelliJ IDEA.
  User: Aina
  Date: 26/04/2025
  Time: 08:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.crowdfunding.crowdfunding.dao.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add project</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-lg rounded-4">
                <div class="card-body p-4">
                    <h3 class="card-title text-center mb-4">Create a New Project</h3>

                    <% if (user == null) { %>
                    <div class="alert alert-warning text-center">
                        You must be <a href="login">logged in</a> to create a project.
                    </div>
                    <% } else { %>
                    <form action="add-project" method="post">
                        <!-- Hidden userId from session -->
                        <input type="hidden" name="userId" value="<%= user.getId() %>" />

                        <div class="mb-3">
                            <label for="name" class="form-label">Project Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>

                        <div class="mb-3">
                            <label for="deadline" class="form-label">Deadline</label>
                            <input type="date" class="form-control" id="deadline" name="deadline" required>
                        </div>

                        <div class="mb-3">
                            <label for="moneyNeeded" class="form-label">Money Needed</label>
                            <input type="number" class="form-control" id="moneyNeeded" name="moneyNeeded" required>
                        </div>

                        <div class="mb-3">
                            <label for="moneyPerContributor" class="form-label">Money Per Contributor</label>
                            <input type="number" class="form-control" id="moneyPerContributor" name="moneyPerContributor" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Submit Project</button>
                    </form>
                    <% } %>
                </div>
            </div>

            <footer class="text-center mt-4 text-muted small">
                © 2025 Crowdfunding Platform
            </footer>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


