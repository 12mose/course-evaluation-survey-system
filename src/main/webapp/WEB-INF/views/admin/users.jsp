<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<div class="page-header">
    <h2>System Users</h2>
</div>

<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

<!-- Add / Edit Form -->
<div class="card">
    <h3>${userForm.userId == 0 ? '➕ Add New User' : '✏️ Edit User'}</h3>
    <form action="${pageContext.request.contextPath}/admin/users/save" method="post">
        <input type="hidden" name="userId" value="${userForm.userId}" />
        <div class="form-row">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" class="form-control" value="${userForm.fullName}" required placeholder="Full name">
            </div>
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" class="form-control" value="${userForm.username}" required placeholder="Username">
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" class="form-control" value="${userForm.email}" required placeholder="Email address">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label>Password
                    <c:if test="${userForm.userId != 0}"><span class="muted"> (leave blank to keep current)</span></c:if>
                </label>
                <input type="password" name="password" class="form-control" ${userForm.userId == 0 ? 'required' : ''} placeholder="Password">
            </div>
            <div class="form-group">
                <label>Role</label>
                <select name="roleId" class="form-control">
                    <option value="1" ${userForm.roleId == 1 ? 'selected' : ''}>ADMIN</option>
                    <option value="2" ${userForm.roleId == 2 ? 'selected' : ''}>INITIATOR</option>
                    <option value="3" ${userForm.roleId == 3 ? 'selected' : ''}>TEACHER</option>
                    <option value="4" ${userForm.roleId == 4 ? 'selected' : ''}>RESPONDENT</option>
                </select>
            </div>
            <div class="form-group">
                <label>Status</label>
                <select name="status" class="form-control">
                    <option value="ACTIVE"    ${userForm.status == 'ACTIVE'    ? 'selected' : ''}>ACTIVE</option>
                    <option value="PENDING"   ${userForm.status == 'PENDING'   ? 'selected' : ''}>PENDING</option>
                    <option value="REJECTED"  ${userForm.status == 'REJECTED'  ? 'selected' : ''}>REJECTED</option>
                </select>
            </div>
        </div>
        <div style="display:flex;gap:10px;margin-top:4px;">
            <button type="submit" class="btn btn-primary">${userForm.userId == 0 ? 'Create User' : 'Save Changes'}</button>
            <c:if test="${userForm.userId != 0}">
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
            </c:if>
        </div>
    </form>
</div>

<!-- Users Table -->
<table class="table">
    <thead>
        <tr><th>Name</th><th>Username</th><th>Email</th><th>Role</th><th>Status</th><th>Joined</th><th>Actions</th></tr>
    </thead>
    <tbody>
    <c:forEach var="u" items="${users}">
        <tr>
            <td><strong>${u.fullName}</strong></td>
            <td>${u.username}</td>
            <td>${u.email}</td>
            <td><span class="badge">${u.roleName}</span></td>
            <td>
                <span class="badge badge-${u.status == 'ACTIVE' ? 'success' : u.status == 'PENDING' ? 'warning' : 'danger'}">
                    ${u.status}
                </span>
            </td>
            <td style="color:var(--text-muted);font-size:13px;">${u.createdAt}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/users/edit/${u.userId}" class="btn btn-info btn-sm">Edit</a>
                <c:if test="${u.userId != loggedUser.userId}">
                    <a href="${pageContext.request.contextPath}/admin/users/delete/${u.userId}"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Delete this user permanently?')">Delete</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<jsp:include page="../common/footer.jsp"/>