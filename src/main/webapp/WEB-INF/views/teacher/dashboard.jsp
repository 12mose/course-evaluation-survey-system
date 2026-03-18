<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<div class="page-header">
    <h2>Teacher Dashboard</h2>
</div>

<!-- My Courses -->
<h3 style="margin-bottom:14px;">My Courses</h3>
<c:choose>
    <c:when test="${empty courses}">
        <div class="empty-state">
            <div class="empty-state-icon">📚</div>
            <p>No courses assigned to you yet.</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="stats-grid" style="margin-bottom:32px;">
            <c:forEach var="c" items="${courses}">
                <div class="stat-card">
                    <div class="stat-card-icon">📘</div>
                    <h3 style="font-size:22px;">${c.courseCode}</h3>
                    <p>${c.courseName}</p>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<!-- Surveys for My Courses -->
<h3 style="margin-bottom:14px;">Surveys for My Courses</h3>
<c:choose>
    <c:when test="${empty surveys}">
        <div class="empty-state">
            <div class="empty-state-icon">📋</div>
            <p>No surveys for your courses yet.</p>
        </div>
    </c:when>
    <c:otherwise>
        <table class="table">
            <thead>
                <tr><th>Title</th><th>Course</th><th>Status</th><th>Responses</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach var="s" items="${surveys}">
                <tr>
                    <td><strong>${s.title}</strong></td>
                    <td>${s.courseName}</td>
                    <td><span class="badge badge-${s.status == 'PUBLISHED' ? 'success' : s.status == 'DRAFT' ? 'warning' : 'secondary'}">${s.status}</span></td>
                    <td class="muted">—</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/teacher/surveys/${s.surveyId}/results" class="btn btn-info btn-sm">View Results</a>
                        <c:if test="${s.status == 'PUBLISHED'}">
                            <a href="${pageContext.request.contextPath}/survey/${s.surveyId}/take" class="btn btn-secondary btn-sm" target="_blank">Preview</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>

<jsp:include page="../common/footer.jsp"/>
