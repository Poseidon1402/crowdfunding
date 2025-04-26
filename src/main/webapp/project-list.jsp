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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Projects | CrowdFund</title>
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

    .projects-page {
        display: flex;
        max-width: 1200px;
        width: 90%;
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    }

    .brand-section {
        width: 300px;
        background: linear-gradient(135deg, var(--secondary) 0%, var(--primary) 100%);
        padding: 40px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        color: white;
        position: relative;
    }

    .brand-logo {
        width: 140px;
        height: 140px;
        margin-bottom: 20px;
        background: white;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 25px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
    }

    .brand-logo svg {
        width: 100%;
        height: 100%;
    }

    .brand-title {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 15px;
        letter-spacing: 0.5px;
        text-transform: uppercase;
        color: var(--orange);
        text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
    }

    .brand-tagline {
        font-size: 16px;
        text-align: center;
        opacity: 0.95;
        max-width: 240px;
        line-height: 1.5;
        font-style: italic;
    }

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
        background: rgba(255, 255, 255, 0.1);
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
        width: 60px;
        height: 60px;
        bottom: -20px;
        left: 50px;
    }

    .projects-container {
        flex: 1;
        padding: 40px;
        overflow-y: auto;
        max-height: 90vh;
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

    .project-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 25px;
        margin-top: 20px;
    }

    .project-card {
        background: #f8f9fa;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
    }

    .project-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .card-title {
        color: var(--primary);
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .status-badge {
        display: inline-flex;
        align-items: center;
        padding: 5px 10px;
        border-radius: 6px;
        font-size: 12px;
        font-weight: 600;
        color: white;
    }

    .status-badge.approved {
        background: var(--secondary);
    }

    .status-badge.pending {
        background: var(--accent);
    }

    .list-unstyled {
        list-style: none;
        margin-bottom: 15px;
    }

    .list-unstyled li {
        margin-bottom: 12px;
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        color: #666;
    }

    .list-unstyled svg {
        width: 16px;
        height: 16px;
        fill: var(--secondary);
    }

    .list-unstyled strong {
        color: var(--dark);
        font-weight: 600;
    }

    .progress-container {
        height: 10px;
        background: #ddd;
        border-radius: 5px;
        overflow: hidden;
        margin: 15px 0;
    }

    .progress-bar {
        height: 100%;
        background: var(--orange);
        transition: width 0.5s ease;
    }

    .contributions-text {
        font-size: 13px;
        color: #666;
        text-align: center;
        margin-bottom: 15px;
    }

    .contributed-text {
        color: var(--secondary);
        font-size: 14px;
        font-weight: 600;
        text-align: center;
        margin-bottom: 15px;
    }

    .contribute-btn {
        background: var(--primary);
        color: white;
        border: none;
        padding: 12px 20px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .contribute-btn:hover {
        background: #5f0440;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(112, 5, 72, 0.3);
    }

    .contribute-btn svg {
        width: 16px;
        height: 16px;
        fill: white;
    }

    footer {
        text-align: center;
        color: #666;
        font-size: 12px;
        margin-top: 30px;
    }

    @media (max-width: 992px) {
        .projects-page {
            flex-direction: column;
            width: 95%;
        }

        .brand-section {
            width: 100%;
            padding: 30px;
        }

        .projects-container {
            padding: 30px;
        }
    }

    @media (max-width: 768px) {
        .project-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<body>
<%
    User currentUser = (User) session.getAttribute("user");
    int userId = currentUser != null ? currentUser.getId() : -1;
%>

<div class="projects-page">
    <div class="brand-section">
        <div class="decorative-circles">
            <div class="circle"></div>
            <div class="circle"></div>
            <div class="circle"></div>
        </div>
        <div class="brand-logo">
            <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
                <!-- Top Hand -->
                <g transform="translate(100, 100) rotate(0) translate(-35, -75)">
                    <!-- Hand Base -->
                    <path d="M0,0 L50,0 L50,40 L0,40 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Wrist -->
                    <path d="M0,15 L-10,15 L-10,25 L0,25 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Thumb -->
                    <path d="M50,15 L60,15 L60,25 L50,25 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Fingers -->
                    <path d="M10,0 L10,-10 L15,-10 L15,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <path d="M20,0 L20,-10 L25,-10 L25,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <path d="M30,0 L30,-10 L35,-10 L35,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <path d="M40,0 L40,-10 L45,-10 L45,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <!-- Color Block -->
                    <rect x="15" y="10" width="20" height="20" fill="#F9A826" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                </g>

                <!-- Right Hand -->
                <g transform="translate(100, 100) rotate(90) translate(-35, -75)">
                    <!-- Hand Base -->
                    <path d="M0,0 L50,0 L50,40 L0,40 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <!-- Wrist -->
                    <path d="M0,15 L-10,15 L-10,25 L0,25 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <!-- Thumb -->
                    <path d="M50,15 L60,15 L60,25 L50,25 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <!-- Fingers -->
                    <path d="M10,0 L10,-10 L15,-10 L15,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <path d="M20,0 L20,-10 L25,-10 L25,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <path d="M30,0 L30,-10 L35,-10 L35,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <path d="M40,0 L40,-10 L45,-10 L45,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                    <!-- Color Block -->
                    <rect x="15" y="10" width="20" height="20" fill="#EB5E55" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"/>
                </g>

                <!-- Bottom Hand -->
                <g transform="translate(100, 100) rotate(180) translate(-35, -75)">
                    <!-- Hand Base -->
                    <path d="M0,0 L50,0 L50,40 L0,40 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Wrist -->
                    <path d="M0,15 L-10,15 L-10,25 L0,25 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Thumb -->
                    <path d="M50,15 L60,15 L60,25 L50,25 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Fingers -->
                    <path d="M10,0 L10,-10 L15,-10 L15,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <path d="M20,0 L20,-10 L25,-10 L25,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <path d="M30,0 L30,-10 L35,-10 L35,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <path d="M40,0 L40,-10 L45,-10 L45,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Color Block -->
                    <rect x="15" y="10" width="20" height="20" fill="#F4D03F" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></rect>
                </g>

                <!-- Left Hand -->
                <g transform="translate(100, 100) rotate(270) translate(-35, -75)">
                    <!-- Hand Base -->
                    <path d="M0,0 L50,0 L50,40 L0,40 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Wrist -->
                    <path d="M0,15 L-10,15 L-10,25 L0,25 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Thumb -->
                    <path d="M50,15 L60,15 L60,25 L50,25 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Fingers -->
                    <path d="M10,0 L10,-10 L15,-10 L15,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <path d="M20,0 L20,-10 L25,-10 L25,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <path d="M30,0 L30,-10 L35,-10 L35,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <path d="M40,0 L40,-10 L45,-10 L45,0 Z" fill="#E0F2FE" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></path>
                    <!-- Color Block -->
                    <rect x="15" y="10" width="20" height="20" fill="#E74C3C" stroke="#5D1F1E" stroke-width="5" stroke-linejoin="round"></rect>
                </g>
            </svg>
        </div>
        <h1 class="brand-title">CrowdFund</h1>
        <p class="brand-tagline">Together we can make it happen</p>
    </div>

    <div class="projects-container">
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
                    <div class="progress-bar" style="width: <%= progress %>%;"></div>
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
</div>
</body>

</html>