<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<div class="page-header">
    <h2>Teacher Management</h2>
</div>

<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

<table class="table">
    <thead>
        <tr><th>Name</th><th>Username</th><th>Email</th><th>Status</th><th>Actions</th></tr>
    </thead>
    <tbody>
    <c:forEach var="t" items="${teachers}">
        <tr>
            <td><strong>${t.fullName}</strong></td>
            <td>${t.username}</td>
            <td>${t.email}</td>
            <td>
                <span class="badge badge-${t.status == 'ACTIVE' ? 'success' : t.status == 'PENDING' ? 'warning' : 'danger'}">
                    ${t.status}
                </span>
            </td>
            <td>
                <c:if test="${t.status == 'PENDING'}">
                    <form action="${pageContext.request.contextPath}/admin/teachers/approve" method="post" style="display:inline">
                        <input type="hidden" name="userId" value="${t.userId}">
                        <button class="btn btn-success btn-sm">✔ Approve</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/admin/teachers/reject" method="post" style="display:inline">
                        <input type="hidden" name="userId" value="${t.userId}">
                        <button class="btn btn-danger btn-sm">✕ Reject</button>
                    </form>
                </c:if>
                <c:if test="${t.status == 'ACTIVE'}">
                    <span class="muted">—</span>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<jsp:include page="../common/footer.jsp"/>
