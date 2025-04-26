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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | CrowdFund</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<style>
    :root {
        --primary: #700548;
        --primary-light: #9c1569;
        --secondary: #368F8B;
        --accent: #EB5E55;
        --orange: #F9A826;
        --yellow: #F4D03F;
        --red: #E74C3C;
        --light: #f8f9fa;
        --dark: #212529;
        --brown: #5D1F1E;
        --gray: #6c757d;
        --gray-light: #f0f0f0;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background: #f5f5f5 linear-gradient(135deg, rgba(54, 143, 139, 0.1) 0%, rgba(112, 5, 72, 0.1) 100%);
        min-height: 100vh;
        padding: 20px;
    }

    .top-nav {
        background-color: white;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 25px;
    }

    .logo-container {
        display: flex;
        align-items: center;
    }

    .logo {
        width: 40px;
        height: 40px;
        margin-right: 10px;
    }

    .logo-text {
        font-size: 20px;
        font-weight: 700;
        color: var(--primary);
        letter-spacing: 0.5px;
    }

    .nav-right {
        display: flex;
        align-items: center;
    }

    .user-info {
        margin-right: 15px;
        font-size: 14px;
        color: var(--gray);
    }

    .user-name {
        font-weight: 600;
        color: var(--dark);
    }

    .logout-btn {
        background: var(--primary);
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .logout-btn:hover {
        background: var(--primary-light);
    }

    .container {
        max-width: 1200px;
        width: 100%;
        margin: 80px auto 20px auto;
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        padding: 30px;
        position: relative;
    }

    .dashboard-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        border-bottom: 1px solid #eee;
        padding-bottom: 20px;
    }

    h2 {
        color: var(--primary);
        font-size: 28px;
        position: relative;
        padding-bottom: 10px;
    }

    h2::after {
        content: "";
        position: absolute;
        left: 0;
        bottom: 0;
        width: 40px;
        height: 3px;
        background: var(--accent);
    }

    .filter-container {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .filter-btn {
        background: var(--gray-light);
        color: var(--gray);
        border: none;
        padding: 8px 15px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .filter-btn.active {
        background: var(--secondary);
        color: white;
    }

    .filter-btn:hover:not(.active) {
        background: #e0e0e0;
    }

    .search-container {
        display: flex;
        margin: 20px 0;
    }

    .search-input {
        flex: 1;
        padding: 10px 15px;
        border: 1px solid #ddd;
        border-radius: 6px 0 0 6px;
        font-size: 14px;
    }

    .search-btn {
        background: var(--secondary);
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 0 6px 6px 0;
        cursor: pointer;
    }

    .grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 25px;
        margin-top: 20px;
    }

    .card {
        background: white;
        border-radius: 8px;
        padding: 25px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        border: 1px solid #eee;
        display: flex;
        flex-direction: column;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 15px;
    }

    h3 {
        color: var(--primary);
        font-size: 18px;
        font-weight: 600;
        margin-right: 10px;
    }

    .progress-container {
        margin: 15px 0;
        background: #f0f0f0;
        border-radius: 10px;
        height: 8px;
        overflow: hidden;
    }

    .progress-bar {
        height: 100%;
        background: var(--secondary);
        border-radius: 10px;
    }

    .info {
        margin-bottom: 10px;
        color: #666;
        font-size: 14px;
        display: flex;
        align-items: center;
    }

    .info i {
        margin-right: 8px;
        color: var(--secondary);
        width: 16px;
    }

    .info strong {
        color: var(--dark);
        font-weight: 600;
        margin-right: 5px;
    }

    .badge {
        display: inline-block;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        color: white;
    }

    .badge.approved {
        background: var(--secondary);
    }

    .badge.pending {
        background: var(--orange);
    }

    .badge.rejected {
        background: var(--accent);
    }

    .card-footer {
        margin-top: auto;
        padding-top: 15px;
        border-top: 1px solid #eee;
    }

    .action-buttons {
        display: flex;
        gap: 10px;
        margin-top: 15px;
    }

    .approve-button {
        background: var(--secondary);
        color: white;
        border: none;
        padding: 10px 0;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        flex: 1;
        text-align: center;
    }

    .approve-button:hover {
        background: #277a76;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(54, 143, 139, 0.3);
    }

    .deny-button {
        background: var(--accent);
        color: white;
        border: none;
        padding: 10px 0;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        flex: 1;
        text-align: center;
    }

    .deny-button:hover {
        background: #e04e45;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(235, 94, 85, 0.3);
    }

    .details-button {
        background: var(--gray-light);
        color: var(--gray);
        border: none;
        padding: 10px 15px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-align: center;
        margin-top: 10px;
        display: block;
        width: 100%;
    }

    .details-button:hover {
        background: #e0e0e0;
        color: var(--dark);
    }

    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 30px;
        gap: 5px;
    }

    .page-item {
        background: white;
        border: 1px solid #ddd;
        padding: 8px 15px;
        border-radius: 4px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .page-item.active {
        background: var(--secondary);
        color: white;
        border-color: var(--secondary);
    }

    .page-item:hover:not(.active) {
        background: #f0f0f0;
    }

    .footer {
        text-align: center;
        color: #666;
        font-size: 14px;
        margin-top: 40px;
        padding-top: 20px;
        border-top: 1px solid #eee;
    }

    .decorative-circles {
        position: absolute;
        width: 100%;
        height: 100%;
        overflow: hidden;
        top: 0;
        left: 0;
        z-index: 0;
        pointer-events: none;
    }

    .circle {
        position: absolute;
        border-radius: 50%;
        background: rgba(54, 143, 139, 0.05);
    }

    .circle:nth-child(1) {
        width: 150px;
        height: 150px;
        top: -30px;
        right: -30px;
    }

    .circle:nth-child(2) {
        width: 100px;
        height: 100px;
        bottom: 50px;
        left: 30px;
    }

    .circle:nth-child(3) {
        width: 80px;
        height: 80px;
        bottom: -20px;
        right: 150px;
    }

    .empty-state {
        text-align: center;
        padding: 40px 0;
        color: var(--gray);
    }

    .empty-state i {
        font-size: 48px;
        color: #ccc;
        margin-bottom: 15px;
    }

    .empty-state p {
        font-size: 16px;
        margin-bottom: 20px;
    }

    @media (max-width: 768px) {
        .container {
            padding: 20px;
            margin-top: 70px;
        }

        .grid {
            grid-template-columns: 1fr;
        }

        .dashboard-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 15px;
        }

        .filter-container {
            width: 100%;
            overflow-x: auto;
            padding-bottom: 10px;
            flex-wrap: nowrap;
        }

        .filter-container::-webkit-scrollbar {
            height: 4px;
        }

        .filter-container::-webkit-scrollbar-thumb {
            background: #ccc;
            border-radius: 4px;
        }

        .top-nav {
            padding: 10px 15px;
        }

        .user-info {
            display: none;
        }
    }
</style>

<body>
<nav class="top-nav">
    <div class="logo-container">
        <svg class="logo" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
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
        <span class="logo-text">CrowdFund</span>
    </div>
    <div class="nav-right">
        <div class="user-info">Welcome, <span class="user-name">Admin</span></div>
        <form action="logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</nav>

<div class="container">
    <div class="decorative-circles">
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
    </div>

    <div class="dashboard-header">
        <h2>Project Dashboard</h2>
        <div class="filter-container">
            <button class="filter-btn active">All</button>
            <button class="filter-btn">Pending</button>
            <button class="filter-btn">Approved</button>
            <button class="filter-btn">Rejected</button>
        </div>
    </div>

    <div class="search-container">
        <input type="text" class="search-input" placeholder="Search projects...">
        <button class="search-btn"><i class="fas fa-search"></i></button>
    </div>

    <div class="grid">
        <%
            List<Project> projects = (List<Project>) request.getAttribute("projectList");
            if (projects != null && !projects.isEmpty()) {
                for (Project p : projects) {
                    // Calculate a random progress percentage for visual representation
                    int progressPercent = 0;
                    String statusClass = p.isApproved() ? "approved" : "pending";
                    if (p.getStatus() != null && p.getStatus().equalsIgnoreCase("rejected")) {
                        statusClass = "rejected";
                    }
        %>
        <div class="card">
            <div class="card-header">
                <h3><%= p.getName() %></h3>
                <div class="badge <%= statusClass %>">
                    <%= p.isApproved() ? "Approved" : (p.getStatus() != null && p.getStatus().equalsIgnoreCase("rejected") ? "Rejected" : "Pending") %>
                </div>
            </div>

            <div class="progress-container">
                <div class="progress-bar" style="width: <%= progressPercent %>%;"></div>
            </div>
            <div class="info"><i class="fas fa-user"></i> <strong>User ID:</strong> <%= p.getUserId() %></div>
            <div class="info"><i class="fas fa-calendar"></i> <strong>Deadline:</strong> <%= p.getDeadline() %></div>
            <div class="info"><i class="fas fa-money-bill-wave"></i> <strong>Goal:</strong> $<%= p.getMoneyNeeded() %></div>
            <div class="info"><i class="fas fa-donate"></i> <strong>Per Contributor:</strong> $<%= p.getMoneyPerContributor() %></div>

            <div class="card-footer">
                <% if (!p.isApproved() && (p.getStatus() == null || !p.getStatus().equalsIgnoreCase("rejected"))) { %>
                <form method="post" action="handle-approval">
                    <input type="hidden" name="projectId" value="<%= p.getId() %>"/>
                    <div class="action-buttons">
                        <button class="approve-button" type="submit" name="action" value="approve">
                            <i class="fas fa-check"></i> Approve
                        </button>
                        <button class="deny-button" type="submit" name="action" value="deny">
                            <i class="fas fa-times"></i> Deny
                        </button>
                    </div>
                </form>
                <% } %>
                <a href="project-details?id=<%= p.getId() %>" class="details-button">
                    <i class="fas fa-eye"></i> View Details
                </a>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="empty-state" style="grid-column: 1 / -1;">
            <i class="fas fa-folder-open"></i>
            <p>No projects found</p>
            <button class="approve-button">Refresh</button>
        </div>
        <% } %>
    </div>

    <div class="pagination">
        <button class="page-item"><i class="fas fa-chevron-left"></i></button>
        <button class="page-item active">1</button>
        <button class="page-item">2</button>
        <button class="page-item">3</button>
        <button class="page-item"><i class="fas fa-chevron-right"></i></button>
    </div>

    <div class="footer">© 2025 CrowdFund Platform | All Rights Reserved</div>
</div>

<script>
    // Add basic interactivity for the filter buttons
    const filterButtons = document.querySelectorAll('.filter-btn');
    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
        });
    });
</script>
</body>
</html>