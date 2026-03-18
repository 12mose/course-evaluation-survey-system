<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<div class="page-header">
    <h2>Admin Dashboard</h2>
</div>

<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

<!-- Stat Cards -->
<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-card-icon">🎓</div>
        <h3>${totalCourses}</h3>
        <p>Total Courses</p>
    </div>
    <div class="stat-card">
        <div class="stat-card-icon">📊</div>
        <h3>${totalSurveys}</h3>
        <p>Active Surveys</p>
    </div>
    <div class="stat-card">
        <div class="stat-card-icon">⏳</div>
        <h3>${pendingTeachers.size()}</h3>
        <p>Pending Approvals</p>
    </div>
</div>

<!-- Pending Teacher Approvals -->
<c:if test="${not empty pendingTeachers}">
    <h3>⏳ Pending Teacher Approvals</h3>
    <table class="table">
        <thead>
            <tr><th>Name</th><th>Username</th><th>Email</th><th>Actions</th></tr>
        </thead>
        <tbody>
        <c:forEach var="t" items="${pendingTeachers}">
            <tr>
                <td><strong>${t.fullName}</strong></td>
                <td>${t.username}</td>
                <td>${t.email}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/admin/teachers/approve" method="post" style="display:inline">
                        <input type="hidden" name="userId" value="${t.userId}">
                        <button class="btn btn-success btn-sm">✔ Approve</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/admin/teachers/reject" method="post" style="display:inline">
                        <input type="hidden" name="userId" value="${t.userId}">
                        <button class="btn btn-danger btn-sm">✕ Reject</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>
<c:if test="${empty pendingTeachers}">
    <div class="empty-state">
        <div class="empty-state-icon">✅</div>
        <p>No pending teacher approvals</p>
    </div>
</c:if>

<jsp:include page="../common/footer.jsp"/>
