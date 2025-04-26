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
    <title>All Projects | CrowdFund</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        text-align: center;
    }

    h2::after {
        content: '';
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        bottom: -12px;
        width: 60px;
        height: 5px;
        background: var(--accent);
        border-radius: 2px;
    }

    .project-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 40px;
        position: relative;
        z-index: 1;
    }

    .project-card {
        flex: 1 1 30%;
        background: var(--light);
        border-radius: 16px;
        padding: 30px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        transition: transform 0.4s ease, box-shadow 0.4s ease;
        position: relative;
    }

    .project-card:hover {
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
        justify-content: space-between;
    }

    .list-unstyled {
        list-style: none;
        color: var(--dark);
        font-size: 16px;
        margin-bottom: 20px;
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

    .progress-container {
        height: 24px;
        background: #e0e0e0;
        border-radius: 12px;
        overflow: hidden;
        margin: 15px 0;
        position: relative;
    }

    .progress-bar {
        height: 100%;
        background: linear-gradient(90deg, var(--accent), #e07b30);
        transition: width 1s ease-in-out;
        position: relative;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        padding-right: 10px;
        color: var(--light);
        font-size: 0.9rem;
        font-weight: 600;
    }

    .contributions-text {
        font-size: 0.95rem;
        color: var(--dark);
        margin-bottom: 15px;
        text-align: center;
    }

    .contributed-text {
        color: var(--success);
        font-weight: 600;
        text-align: center;
        margin-bottom: 15px;
    }

    .contribute-btn {
        background: linear-gradient(90deg, var(--accent), #e07b30);
        color: var(--light);
        border: none;
        padding: 12px 20px;
        border-radius: 50px;
        font-size: 16px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.3s ease;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .contribute-btn svg {
        width: 20px;
        height: 20px;
        fill: var(--light);
    }

    .contribute-btn:hover {
        background: #e07b30;
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(242, 140, 56, 0.4);
    }

    footer {
        text-align: center;
        color: var(--dark);
        font-size: 14px;
        margin-top: 40px;
        opacity: 0.7;
        position: relative;
        z-index: 1;
    }

    @media (max-width: 1024px) {
        .project-grid {
            flex-direction: column;
        }

        .project-card {
            flex: 0 0 100%;
            max-width: 100%;
        }
    }

    @media (max-width: 768px) {
        .container {
            padding: 25px;
        }

        h2 {
            font-size: 30px;
        }

        .project-card {
            padding: 20px;
        }
    }
</style>

<body>
<%
    User currentUser = (User) session.getAttribute("user");
    int userId = currentUser != null ? currentUser.getId() : -1;
%>

<div class="container" role="main">
    <h2>All Projects</h2>

    <div class="project-grid">
        <%
            List<Project> projects = (List<Project>) request.getAttribute("projectList");
            for (Project p : projects) {
                int totalNeeded = p.getMoneyNeeded();
                int perContributor = p.getMoneyPerContributor();
                int currentContributions = p.getContributions();
                int totalRequired = (perContributor != 0) ? totalNeeded / perContributor : 1;
                int progress = (int) (((double) currentContributions / totalRequired) * 100);
        %>
        <div class="project-card" role="region" aria-labelledby="project-<%= p.getName() %>">
            <h5 class="card-title" id="project-<%= p.getName() %>">
                <%= p.getName() %>
                <span class="status-badge <%= p.isApproved() ? "approved" : "pending" %>">
                    <%= p.isApproved() ? "Approved" : "Pending" %>
                </span>
            </h5>

            <ul class="list-unstyled">
                <li>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zM12 5c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14c-2.33 0-4.45-.97-6-2.54.68-.98 1.86-1.46 3-1.46h6c1.14 0 2.32.48 3 1.46-1.55 1.57-3.67 2.54-6 2.54z"/>
                    </svg>
                    <strong>User ID:</strong> <%= p.getUserId() %>
                </li>
                <li>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M19 4H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zM16 2v4M8 2v4M3 10h18"/>
                    </svg>
                    <strong>Deadline:</strong> <%= p.getDeadline() %>
                </li>
                <li>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                        <circle cx="12" cy="12" r="10"/><path d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12m0 0c-.725 0-1.45-.22-2.069-.659-1.172-.879-1.172-2.303 0-3.182 1.171-.879 3.07-.879 4.242 0l.879.659"/>
                    </svg>
                    <strong>Money Needed:</strong> $<%= totalNeeded %>
                </li>
                <li>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                        <circle cx="12" cy="12" r="10"/><path d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12m0 0c-.725 0-1.45-.22-2.069-.659-1.172-.879-1.172-2.303 0-3.182 1.171-.879 3.07-.879 4.242 0l.879.659"/>
                    </svg>
                    <strong>Per Contributor:</strong> $<%= perContributor %>
                </li>
                <li>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zM12 5c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14c-2.33 0-4.45-.97-6-2.54.68-.98 1.86-1.46 3-1.46h6c1.14 0 2.32.48 3 1.46-1.55 1.57-3.67 2.54-6 2.54z"/>
                    </svg>
                    <strong>Status:</strong> <%= p.getStatus() %>
                </li>
            </ul>

            <div class="progress-container">
                <div class="progress-bar" style="width: <%= progress %>%;">
                    <%= progress %>%
                </div>
            </div>

            <p class="contributions-text"><%= currentContributions %> / <%= totalRequired %> contributions</p>

            <% if (p.isApproved() && userId != -1) {
                boolean alreadyContributed = currentUser.getContributions().contains(p.getId());
                if (alreadyContributed) { %>
            <p class="contributed-text">Already Contributed</p>
            <% } else { %>
            <form action="contribute" method="post" aria-label="Contribute to project <%= p.getName() %>">
                <input type="hidden" name="projectId" value="<%= p.getId() %>">
                <input type="hidden" name="userId" value="<%= userId %>">
                <button type="submit" class="contribute-btn" aria-label="Contribute to <%= p.getName() %>">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm0-13h-1v4H7v1h4v4h1v-4h4v-1h-4V7z"/>
                    </svg>
                    Contribute $<%= perContributor %>
                </button>
            </form>
            <% }
            } %>
        </div>
        <% } %>
    </div>

    <footer>
        © 2025 Crowdfunding Platform
    </footer>
</div>
</body>

</html>