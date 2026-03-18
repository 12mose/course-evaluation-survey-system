<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<div class="page-header">
    <h2>Assign Teacher</h2>
    <a href="${pageContext.request.contextPath}/admin/courses" class="btn btn-secondary">← Back to Courses</a>
</div>

<div class="card" style="max-width:520px;">
    <h3>📘 ${course.courseName}</h3>
    <p class="muted" style="margin-bottom:20px;">Select an active teacher to assign to this course.</p>
    <form action="${pageContext.request.contextPath}/admin/courses/assign" method="post">
        <input type="hidden" name="courseId" value="${course.courseId}">
        <div class="form-group">
            <label>Select Teacher</label>
            <select name="teacherId" class="form-control" required>
                <option value="">-- Select Teacher --</option>
                <c:forEach var="t" items="${allTeachers}">
                    <c:if test="${t.status == 'ACTIVE'}">
                        <option value="${t.userId}">${t.fullName} (${t.username})</option>
                    </c:if>
                </c:forEach>
            </select>
        </div>
        <div style="display:flex;gap:10px;">
            <button type="submit" class="btn btn-primary">✔ Assign Teacher</button>
            <a href="${pageContext.request.contextPath}/admin/courses" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>

<jsp:include page="../common/footer.jsp"/>
