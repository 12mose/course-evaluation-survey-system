<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – CourseEval</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="auth-page">

<!-- Left decorative panel -->
<div class="auth-hero">
    <div class="auth-hero-icon">📋</div>
    <h1>CourseEval</h1>
    <p>A modern platform for collecting course feedback, evaluating teaching quality, and empowering continuous learning.</p>
</div>

<!-- Right form panel -->
<div class="auth-panel">
    <div class="auth-card">
        <h2>Welcome back 👋</h2>
        <p class="auth-subtitle">Sign in to your account to continue</p>

        <c:if test="${not empty flashAttributes.error}">
            <div class="alert alert-error">${flashAttributes.error}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required placeholder="Enter your username">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required placeholder="Enter your password">
            </div>
            <button type="submit" class="btn btn-primary btn-block" style="margin-top:8px;">Sign In</button>
        </form>

        <div class="auth-links" style="margin-top:20px;">
            <a href="${pageContext.request.contextPath}/register-student">Register as Student</a>
            <span class="auth-divider"> · </span>
            <a href="${pageContext.request.contextPath}/register">Register as Teacher</a>
            <span class="auth-divider"> · </span>
            <a href="${pageContext.request.contextPath}/register-initiator">Register as Initiator</a>
            <span class="auth-divider"> · </span>
            <a href="${pageContext.request.contextPath}/register-admin">Register as Admin</a>
        </div>
        <div class="auth-divider" style="margin-top:16px;">
            <a href="${pageContext.request.contextPath}/survey/list" style="color:var(--text-muted); font-size:13px;">Browse as Guest →</a>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
