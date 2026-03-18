<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<div class="page-header">
    <h2>Available Surveys</h2>
</div>

<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

<c:choose>
    <c:when test="${empty surveys}">
        <div class="empty-state">
            <div class="empty-state-icon">📋</div>
            <p>No surveys are currently available. Check back later!</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="survey-grid">
            <c:forEach var="s" items="${surveys}">
                <div class="survey-card">
                    <h3>${s.title}</h3>
                    <p class="muted" style="margin-bottom:8px;">📚 ${s.courseName}</p>
                    <p style="font-size:14px;color:var(--text-secondary);">${s.description}</p>
                    <div class="survey-meta">
                        <span class="badge">${s.accessType}</span>
                        <c:if test="${not empty s.endDate}">
                            <span class="muted">Closes: ${s.endDate}</span>
                        </c:if>
                    </div>
                    <a href="${pageContext.request.contextPath}/survey/${s.surveyId}/take"
                       class="btn btn-primary btn-block" style="margin-top:16px;">Take Survey →</a>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="../common/footer.jsp"/>
