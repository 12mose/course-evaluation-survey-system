<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<div class="page-header">
    <h2>${survey.title}</h2>
    <a href="${pageContext.request.contextPath}/survey/list" class="btn btn-secondary">← Back to Surveys</a>
</div>

<p class="muted" style="margin:-8px 0 20px;">📚 ${survey.courseName}</p>
<c:if test="${not empty survey.description}"><p style="margin-bottom:20px;color:var(--text-secondary);">${survey.description}</p></c:if>

<c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

<form action="${pageContext.request.contextPath}/survey/${survey.surveyId}/submit" method="post" id="surveyForm">

    <c:if test="${loggedUser == null}">
        <div class="card" style="margin-bottom:20px;">
            <div class="form-group" style="margin:0">
                <label>Your Email Address * <span class="muted">(required to receive confirmation)</span></label>
                <input type="email" name="guestEmail" required placeholder="you@example.com" class="form-control">
            </div>
        </div>
    </c:if>

    <c:forEach var="q" items="${questions}" varStatus="st">
        <div class="question-card">
            <p class="question-text">
                <span class="q-num" style="margin-right:10px;">Q${st.index + 1}</span>
                ${q.questionText}
                <c:if test="${q.questionType != 'TEXT'}">
                    <span class="badge badge-danger" style="font-size:10px;margin-left:8px;">Required</span>
                </c:if>
            </p>

            <c:choose>
                <%-- Single choice (Radio) --%>
                <c:when test="${q.questionType == 'SINGLE_CHOICE'}">
                    <div class="options-group">
                        <c:forEach var="o" items="${q.options}">
                            <label class="radio-label">
                                <input type="radio" name="q_${q.questionId}" value="${o.optionId}" required>
                                ${o.optionText}
                            </label>
                        </c:forEach>
                    </div>
                </c:when>

                <%-- Multiple choice (Checkboxes) --%>
                <c:when test="${q.questionType == 'MULTIPLE_CHOICE'}">
                    <div class="options-group">
                        <c:forEach var="o" items="${q.options}">
                            <label class="checkbox-label">
                                <input type="checkbox" name="q_${q.questionId}" value="${o.optionId}">
                                ${o.optionText}
                            </label>
                        </c:forEach>
                    </div>
                </c:when>

                <%-- Open text --%>
                <c:otherwise>
                    <textarea name="q_${q.questionId}" rows="3" class="form-control"
                              placeholder="Your answer…"></textarea>
                </c:otherwise>
            </c:choose>
        </div>
    </c:forEach>

    <div style="margin-top:28px;display:flex;gap:12px;">
        <button type="submit" class="btn btn-primary">📨 Submit Survey</button>
        <a href="${pageContext.request.contextPath}/survey/list" class="btn btn-secondary">Cancel</a>
    </div>
</form>

<jsp:include page="../common/footer.jsp"/>