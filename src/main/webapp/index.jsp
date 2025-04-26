<%--
  Created by IntelliJ IDEA.
  User: Aina
  Date: 24/04/2025
  Time: 19:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | CrowdFund</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
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
    }

    .login-page {
        display: flex;
        max-width: 900px;
        width: 90%;
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    }

    .brand-section {
        flex: 1;
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
        width: 160px;
        height: 160px;
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
        font-size: 32px;
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

    .login-container {
        flex: 1;
        padding: 40px;
        display: flex;
        flex-direction: column;
        justify-content: center;
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

    .error-message {
        background-color: rgba(235, 94, 85, 0.1);
        border-left: 3px solid var(--accent);
        color: var(--accent);
        padding: 12px;
        margin-bottom: 20px;
        border-radius: 4px;
        font-size: 14px;
    }

    form {
        display: flex;
        flex-direction: column;
    }

    .input-group {
        margin-bottom: 20px;
        position: relative;
    }

    label {
        color: #666;
        margin-bottom: 8px;
        display: block;
        font-size: 14px;
    }

    input {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-size: 16px;
        transition: all 0.3s ease;
    }

    input:focus {
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
        margin-top: 10px;
    }

    button:hover {
        background: #5f0440;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(112, 5, 72, 0.3);
    }

    .additional-links {
        margin-top: 25px;
        text-align: center;
        font-size: 14px;
        color: #666;
    }

    .additional-links a {
        color: var(--secondary);
        text-decoration: none;
        margin: 0 5px;
        transition: all 0.3s ease;
    }

    .additional-links a:hover {
        color: var(--primary);
        text-decoration: underline;
    }

    @media (max-width: 768px) {
        .login-page {
            flex-direction: column;
            width: 95%;
        }

        .brand-section {
            padding: 30px 20px;
        }

        .login-container {
            padding: 30px 20px;
        }
    }
</style>
<body>
<div class="login-page">
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

    <div class="login-container">
        <h2>Sign In</h2>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="login" method="post">
            <div class="input-group">
                <label for="email">Email Address</label>
                <input type="email" name="email" id="email" required autocomplete="email" />
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" name="password" id="password" required autocomplete="current-password" />
            </div>

            <button type="submit">Login</button>
        </form>
    </div>
</div>
</body>
</html>