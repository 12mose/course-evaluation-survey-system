<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<div class="page-header">
    <h2>Results – ${survey.title}</h2>
    <a href="${pageContext.request.contextPath}/teacher/dashboard" class="btn btn-secondary">← Dashboard</a>
</div>

<p class="muted" style="margin:-8px 0 24px;">
    📚 ${survey.courseName} &nbsp;·&nbsp; 👥 <strong>${totalResponses}</strong> total responses
</p>

<c:forEach var="q" items="${questions}" varStatus="st">
    <div class="result-card">
        <h4>Q${st.index + 1}. ${q.questionText}</h4>
        <c:choose>
            <c:when test="${q.questionType == 'TEXT'}">
                <div>
                    <c:forEach var="ans" items="${q.textResponses}">
                        <div class="text-response-item">${ans}</div>
                    </c:forEach>
                    <c:if test="${empty q.textResponses}">
                        <p class="muted">No text responses yet.</p>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="o" items="${q.options}">
                    <c:set var="pct" value="${totalResponses > 0 ? (o.responseCount * 100 / totalResponses) : 0}"/>
                    <div class="result-row">
                        <span class="option-label">${o.optionText}</span>
                        <div class="progress-bar-wrap">
                            <div class="progress-bar" style="width:${pct}%"></div>
                        </div>
                        <span class="result-count">${o.responseCount} (${pct}%)</span>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</c:forEach>

<jsp:include page="../common/footer.jsp"/>