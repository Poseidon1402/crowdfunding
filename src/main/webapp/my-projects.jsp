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
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700;900&display=swap" rel="stylesheet">
</head>

<style>
  :root {
    --primary: #6B0848;
    --secondary: #2A7F7A;
    --accent: #F28C38;
    --orange: #F9A826;
    --yellow: #F4D03F;
    --light: #fefefe;
    --dark: #1a1a1a;
    --brown: #5D1F1E;
    --success: #2A7F7A;
    --error: #F28C38;
  }

  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
  }

  body {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background: linear-gradient(135deg, rgba(42, 127, 122, 0.15) 0%, rgba(107, 8, 72, 0.15) 100%);
    padding: 30px;
  }

  .container {
    max-width: 1400px;
    width: 100%;
    background: var(--light);
    border-radius: 20px;
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
    padding: 50px;
    margin: 30px auto;
    position: relative;
    overflow: hidden;
  }

  .container::before {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 200px;
    background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%236B0848" fill-opacity="0.1" d="M0,192L48,186.7C96,181,192,171,288,181.3C384,192,480,224,576,213.3C672,203,768,149,864,138.7C960,128,1056,160,1152,176C1248,192,1344,192,1392,192L1440,192L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') no-repeat bottom;
    background-size: cover;
    z-index: 0;
  }

  h2 {
    color: var(--primary);
    font-size: 36px;
    font-weight: 900;
    margin-bottom: 40px;
    position: relative;
    z-index: 1;
  }

  h2::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: -12px;
    width: 60px;
    height: 5px;
    background: var(--accent);
    border-radius: 2px;
  }

  .row {
    display: flex;
    flex-wrap: wrap;
    gap: 40px;
    position: relative;
    z-index: 1;
  }

  .col-8 {
    flex: 0 0 70%;
    max-width: 70%;
  }

  .col-4 {
    flex: 0 0 25%;
    max-width: 25%;
  }

  .card {
    background: var(--light);
    border-radius: 16px;
    padding: 30px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    transition: transform 0.4s ease, box-shadow 0.4s ease;
    position: relative;
    margin-bottom: 30px;
  }

  .card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25);
  }

  .card-title {
    color: var(--primary);
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .list-unstyled {
    list-style: none;
    color: var(--dark);
    font-size: 16px;
  }

  .list-unstyled li {
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .list-unstyled svg {
    width: 20px;
    height: 20px;
    fill: var(--secondary);
    transition: transform 0.3s ease;
  }

  .list-unstyled li:hover svg {
    transform: scale(1.2);
  }

  .list-unstyled strong {
    color: var(--primary);
  }

  .progress-circle {
    width: 60px;
    height: 60px;
    position: absolute;
    top: 20px;
    right: 20px;
  }

  .progress-circle svg {
    width: 100%;
    height: 100%;
    transform: rotate(-90deg);
  }

  .progress-circle .bg {
    fill: none;
    stroke: #e0e0e0;
    stroke-width: 8;
  }

  .progress-circle .progress {
    fill: none;
    stroke: var(--accent);
    stroke-width: 8;
    stroke-linecap: round;
    stroke-dasharray: 150;
    stroke-dashoffset: 100;
    transition: stroke-dashoffset 0.5s ease;
  }

  .status-badge {
    display: inline-flex;
    align-items: center;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
    color: var(--light);
  }

  .status-badge.approved {
    background: var(--success);
  }

  .status-badge.pending {
    background: var(--error);
  }

  .alert {
    background: rgba(242, 140, 56, 0.1);
    border-left: 5px solid var(--accent);
    color: var(--accent);
    padding: 20px;
    border-radius: 8px;
    font-size: 16px;
    margin-bottom: 30px;
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .alert svg {
    width: 24px;
    height: 24px;
    fill: var(--accent);
  }

  .form-card {
    background: var(--light);
    border-radius: 16px;
    padding: 30px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    position: relative;
  }

  .form-card .close-btn {
    position: absolute;
    top: 20px;
    right: 20px;
    background: none;
    border: none;
    cursor: pointer;
    padding: 5px;
  }

  .form-card .close-btn svg {
    width: 20px;
    height: 20px;
    fill: var(--dark);
    transition: transform 0.3s ease;
  }

  .form-card .close-btn:hover svg {
    transform: rotate(90deg);
  }

  .form-group {
    margin-bottom: 25px;
    position: relative;
  }

  .form-group label {
    color: var(--dark);
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 10px;
    display: block;
  }

  .form-group input {
    width: 100%;
    padding: 12px 15px;
    border: none;
    border-bottom: 2px solid #ddd;
    background: transparent;
    font-size: 16px;
    color: var(--dark);
    transition: all 0.3s ease;
  }

  .form-group input:focus {
    outline: none;
    border-bottom-color: var(--secondary);
  }

  .form-group input::placeholder {
    color: #aaa;
  }

  button {
    background: var(--accent);
    color: var(--light);
    border: none;
    padding: 16px 24px;
    border-radius: 50px;
    font-size: 18px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s ease;
    width: 100%;
    margin-top: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
  }

  button svg {
    width: 22px;
    height: 22px;
    fill: var(--light);
  }

  button:hover {
    background: #e07b30;
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(242, 140, 56, 0.4);
  }

  .view-details {
    display: inline-flex;
    align-items: center;
    color: var(--secondary);
    text-decoration: none;
    font-size: 16px;
    font-weight: 600;
    margin-top: 15px;
    transition: all 0.3s ease;
    gap: 8px;
  }

  .view-details svg {
    width: 18px;
    height: 18px;
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

    .col-4 {
      padding: 0;
    }
  }

  @media (max-width: 768px) {
    .container {
      padding: 25px;
    }

    h2 {
      font-size: 30px;
    }

    .card {
      padding: 20px;
    }

    .progress-circle {
      width: 50px;
      height: 50px;
    }
  }
</style>

<body>
<div class="container" role="main">
  <h2>My Dashboard</h2>
  <div class="row">
    <!-- Project List -->
    <div class="col-8">
      <h4 style="font-size: 28px; font-weight: 700; color: var(--primary); margin-bottom: 30px;">My Projects</h4>
      <% if (userProjects == null || userProjects.isEmpty()) { %>
      <div class="alert" role="alert">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 17h-2v-2h2v2zm0-4h-2V7h2v6z"/>
        </svg>
        You haven't created any projects yet.
      </div>
      <% } else { %>
      <div class="row">
        <% for (Project project : userProjects) { %>
        <div style="flex: 1 1 45%; margin-bottom: 40px;">
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
                  <path d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0 1 12 2.944a11.955 11.955 0 0 1-8.618 3.04A12.02 12.02 0 0 0 3 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                </svg>
                <strong>Approved:</strong> <%= project.isApproved() ? "Yes" : "No" %>
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