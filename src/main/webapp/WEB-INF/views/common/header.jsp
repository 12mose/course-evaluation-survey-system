<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Evaluation System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="nav-brand">
        <div class="nav-brand-icon">📋</div>
        CourseEval
    </a>
    <div class="nav-links">
        <c:choose>
            <c:when test="${sessionScope.loggedUser.roleName == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/courses">Courses</a>
                <a href="${pageContext.request.contextPath}/admin/teachers">Teachers</a>
                <a href="${pageContext.request.contextPath}/admin/surveys">Surveys</a>
                <a href="${pageContext.request.contextPath}/admin/users">Users</a>
            </c:when>
            <c:when test="${sessionScope.loggedUser.roleName == 'INITIATOR'}">
                <a href="${pageContext.request.contextPath}/initiator/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/initiator/surveys/new">New Survey</a>
                <a href="${pageContext.request.contextPath}/survey/list">All Surveys</a>
            </c:when>
            <c:when test="${sessionScope.loggedUser.roleName == 'TEACHER'}">
                <a href="${pageContext.request.contextPath}/teacher/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/survey/list">All Surveys</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/survey/list">Surveys</a>
            </c:otherwise>
        </c:choose>

        <c:if test="${sessionScope.loggedUser != null}">
            <div class="nav-user-chip">
                <div class="nav-avatar">${sessionScope.loggedUser.fullName.substring(0,1)}</div>
                ${sessionScope.loggedUser.fullName}
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </c:if>
        <c:if test="${sessionScope.loggedUser == null}">
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </c:if>
    </div>
</nav>
<div class="container">
