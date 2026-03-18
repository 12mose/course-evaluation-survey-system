<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register – CourseEval</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="auth-page">

<!-- Left decorative panel -->
<div class="auth-hero">
    <div class="auth-hero-icon">🎓</div>
    <h1>Join CourseEval</h1>
    <p>Create your account and start participating in course evaluations to improve the learning experience for everyone.</p>
</div>

<!-- Right form panel -->
<div class="auth-panel">
    <div class="auth-card">
        <h2>${empty registerTitle ? 'Teacher Registration' : registerTitle}</h2>
        <p class="auth-subtitle">Fill in the details below to create your account</p>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}${empty registerAction ? '/register' : registerAction}" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" required placeholder="Your full name">
            </div>
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required placeholder="Choose a username">
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required placeholder="Your email address">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required placeholder="Choose a password (min 6 chars)" minlength="6">
            </div>
            <button type="submit" class="btn btn-primary btn-block" style="margin-top:8px;">Create Account</button>
        </form>

        <div class="auth-links">
            <a href="${pageContext.request.contextPath}/login">← Back to Login</a>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
