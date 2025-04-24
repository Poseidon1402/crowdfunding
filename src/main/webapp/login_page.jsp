<%--
  Created by IntelliJ IDEA.
  User: Aina
  Date: 24/04/2025
  Time: 19:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/login.css" />
</head>
<body>
<div class="login-container">
    <h2>Login</h2>
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>
    <form action="login" method="post">
        <label for="email">Email</label>
        <input type="email" name="email" id="email" required />

        <label for="password">Password</label>
        <input type="password" name="password" id="password" required />

        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>


