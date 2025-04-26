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
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard - My Projects | CrowdFund</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/my-project.css">
</head>

<style>
  :root {
    --primary: #700548;
    --secondary: #368F8B;
    --accent: #EB5E55;
    --orange: #F9A826;
    --yellow: #F4D03F;
    --red: #E74C3C;
    --light: #f8f9fa;
    --dark: #212529;
    --brown: #5D1F1E;
  }

  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }

  body {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background: #f5f5f5 linear-gradient(135deg, rgba(54, 143, 139, 0.1) 0%, rgba(112, 5, 72, 0.1) 100%);
    padding: 20px;
  }

  .container {
    max-width: 1400px;
    width: 100%;
    background: white;
    border-radius: 12px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    padding: 40px;
    margin: 20px auto;
    position: relative;
    overflow: hidden;
  }

  h2 {
    color: var(--primary);
    font-size: 28px;
    margin-bottom: 30px;
    position: relative;
  }

  h2::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -10px;
    width: 40px;
    height: 3px;
    background: var(--accent);
  }

  h4 {
    color: var(--primary);
    font-size: 24px;
    margin-bottom: 25px;
    position: relative;
  }

  .row {
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
    position: relative;
    z-index: 1;
  }

  .col-8 {
    flex: 0 0 65%;
    max-width: 65%;
  }

  .col-4 {
    flex: 0 0 30%;
    max-width: 30%;
  }

  .card {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    position: relative;
    margin-bottom: 25px;
  }

  .card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
  }

  .card-title {
    color: var(--primary);
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .list-unstyled {
    list-style: none;
    color: var(--dark);
  }

  .list-unstyled li {
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .list-unstyled svg {
    width: 18px;
    height: 18px;
    fill: var(--secondary);
  }

  .list-unstyled strong {
    color: var(--primary);
  }

  .status-badge {
    display: inline-flex;
    align-items: center;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
    color: white;
    margin-left: 10px;
  }

  .status-badge.approved {
    background: var(--secondary);
  }

  .status-badge.pending {
    background: var(--accent);
  }

  .alert {
    background-color: rgba(235, 94, 85, 0.1);
    border-left: 3px solid var(--accent);
    color: var(--accent);
    padding: 12px;
    margin-bottom: 20px;
    border-radius: 4px;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .alert svg {
    width: 20px;
    height: 20px;
    fill: var(--accent);
  }

  .form-card {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
  }

  .form-group {
    margin-bottom: 20px;
    position: relative;
  }

  .form-group label {
    color: #666;
    margin-bottom: 8px;
    display: block;
    font-size: 14px;
  }

  .form-group input {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    transition: all 0.3s ease;
  }

  .form-group input:focus {
    outline: none;
    border-color: var(--secondary);
    box-shadow: 0 0 0 3px rgba(54, 143, 139, 0.2);
  }

  button {
    background: var(--primary);
    color: white;
    border: none;
    padding: 14px 20px;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    width: 100%;
    margin-top: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
  }

  button:hover {
    background: #5f0440;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(112, 5, 72, 0.3);
  }

  button svg {
    width: 20px;
    height: 20px;
    fill: white;
  }

  .view-details {
    display: inline-flex;
    align-items: center;
    color: var(--secondary);
    text-decoration: none;
    font-size: 15px;
    font-weight: 600;
    margin-top: 15px;
    transition: all 0.3s ease;
    gap: 8px;
  }

  .view-details svg {
    width: 16px;
    height: 16px;
    fill: var(--secondary);
    transition: transform 0.3s ease;
  }

  .view-details:hover {
    color: var(--primary);
  }

  .view-details:hover svg {
    transform: translateX(5px);
    fill: var(--primary);
  }

  @media (max-width: 1024px) {
    .row {
      flex-direction: column;
    }

    .col-8, .col-4 {
      flex: 0 0 100%;
      max-width: 100%;
    }
  }

  @media (max-width: 768px) {
    .container {
      padding: 25px;
    }

    h2 {
      font-size: 24px;
    }

    .card {
      padding: 20px;
    }
  }

  /* Project grid styling */
  .projects-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 25px;
  }

  /* Decorative elements like in login page */
  .decorative-circles {
    position: absolute;
    width: 100%;
    height: 100%;
    overflow: hidden;
    top: 0;
    left: 0;
    z-index: 0;
  }

  .circle {
    position: absolute;
    border-radius: 50%;
    background: rgba(54, 143, 139, 0.1);
  }

  .circle:nth-child(1) {
    width: 120px;
    height: 120px;
    top: -30px;
    left: -30px;
  }

  .circle:nth-child(2) {
    width: 80px;
    height: 80px;
    bottom: 50px;
    right: 30px;
  }

  .circle:nth-child(3) {
    width: 200px;
    height: 200px;
    opacity: 0.05;
    bottom: -100px;
    right: -50px;
  }
</style>

<body>
<div class="container" role="main">
  <div class="decorative-circles">
    <div class="circle"></div>
    <div class="circle"></div>
    <div class="circle"></div>
  </div>

  <h2>My Dashboard</h2>
  <div class="row">
    <!-- Project List -->
    <div class="col-8">
      <h4>My Projects</h4>
      <% if (userProjects == null || userProjects.isEmpty()) { %>
      <div class="alert" role="alert">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 17h-2v-2h2v2zm0-4h-2V7h2v6z"/>
        </svg>
        You haven't created any projects yet.
      </div>
      <% } else { %>
      <div class="projects-grid">
        <% for (Project project : userProjects) { %>
        <div class="card" role="region" aria-labelledby="project-<%= project.getName() %>">
          <h5 class="card-title" id="project-<%= project.getName() %>">
            <%= project.getName() %>
            <span class="status-badge <%= project.isApproved() ? "approved" : "pending" %>">
              <%= project.isApproved() ? "Approved" : "Pending" %>
            </span>
          </h5>
          <ul class="list-unstyled">
            <li>
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                <path d="M19 4H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zM16 2v4M8 2v4M3 10h18"/>
              </svg>
              <strong>Deadline:</strong> <%= project.getDeadline() %>
            </li>
            <li>
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                <circle cx="12" cy="12" r="10"/><path d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12m0 0c-.725 0-1.45-.22-2.069-.659-1.172-.879-1.172-2.303 0-3.182 1.171-.879 3.07-.879 4.242 0l.879.659"/>
              </svg>
              <strong>Money Needed:</strong> $<%= project.getMoneyNeeded() %>
            </li>
            <li>
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                <circle cx="12" cy="12" r="10"/><path d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12m0 0c-.725 0-1.45-.22-2.069-.659-1.172-.879-1.172-2.303 0-3.182 1.171-.879 3.07-.879 4.242 0l.879.659"/>
              </svg>
              <strong>Per Contributor:</strong> $<%= project.getMoneyPerContributor() %>
            </li>
            <li>
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zM12 5c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14c-2.33 0-4.45-.97-6-2.54.68-.98 1.86-1.46 3-1.46h6c1.14 0 2.32.48 3 1.46-1.55 1.57-3.67 2.54-6 2.54z"/>
              </svg>
              <strong>Status:</strong> <%= project.getStatus() %>
            </li>
          </ul>
          <a href="project-details?id=<%= project.getId() %>" class="view-details" aria-label="View details for <%= project.getName() %>">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
              <path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>
            </svg>
            View Details
          </a>
        </div>
        <% } %>
      </div>
      <% } %>
    </div>

    <!-- Add New Project -->
    <div class="col-4">
      <div class="form-card" role="region" aria-labelledby="add-project">
        <h5 class="card-title" id="add-project">
          Add New Project
        </h5>
        <form action="add-project" method="post" aria-label="Add new project form">
          <div class="form-group">
            <label for="name">Project Name</label>
            <input type="text" id="name" name="name" required aria-required="true" placeholder="Enter project name" />
          </div>
          <div class="form-group">
            <label for="deadline">Deadline</label>
            <input type="date" id="deadline" name="deadline" required aria-required="true" />
          </div>
          <div class="form-group">
            <label for="moneyNeeded">Money Needed</label>
            <input type="number" id="moneyNeeded" name="moneyNeeded" required aria-required="true" min="1" placeholder="Enter amount" />
          </div>
          <div class="form-group">
            <label for="moneyPerContributor">Money Per Contributor</label>
            <input type="number" id="moneyPerContributor" name="moneyPerContributor" required aria-required="true" min="1" placeholder="Enter amount" />
          </div>
          <button type="submit" aria-label="Create new project">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
              <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm0-13h-1v4H7v1h4v4h1v-4h4v-1h-4V7z"/>
            </svg>
            Create Project
          </button>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>