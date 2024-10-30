<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--로그인 여부--%>
<c:set value="${not empty sessionScope.loggedIn}" var="loggedIn"/>
<%--관리자 여부--%>
<c:set value="${sessionScope.loggedIn.access.contains('admin')}" var="Admin"/>
<%--현재 창의 id 파라미터가 관리자의 아이디인가--%>
<c:set value="${param.id==sessionScope.loggedIn.id}" var="viewingAdmin"/>


<div class="mb-2">
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="/board/list">Community</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link <%= "list".equals(request.getParameter("active")) ? "active text-primary fw-bold bg-light" : "" %>"
                           href="/board/list">
                            <i class="fa-solid fa-list"></i>
                            Timeline
                        </a>
                    </li>
                    <c:if test="${loggedIn}">
                        <li class="nav-item">
                            <a class="nav-link <%= "new".equals(request.getParameter("active")) ? "active text-primary fw-bold bg-light" : "" %>"
                               href="/board/new">
                                <i class="fa-solid fa-file-pen"></i>
                                New Post
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${not loggedIn}">
                        <li class="nav-item">
                            <a class="nav-link <%= "register".equals(request.getParameter("active")) ? "active text-primary fw-bold bg-light" : "" %>"
                               href="/member/register">
                                <i class="fa-solid fa-user-plus"></i>
                                Register
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${loggedIn && Admin}">
                        <li class="nav-item">
                            <a href="/member/mlist"
                               class="nav-link <%= "mlist".equals(request.getParameter("active")) ? "active text-primary fw-bold bg-light" : "" %>">
                                <i class="fa-regular fa-address-book"></i>
                                Members
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${loggedIn}">
                        <li class="nav-item">
                            <c:choose>
                                <c:when test="${viewingAdmin}">
                                    <a href="/member/view?id=${sessionScope.loggedIn.id}"
                                       class="nav-link <%= "view".equals(request.getParameter("active")) ? "active text-primary fw-bold bg-light" : "" %>">
                                        <i class="fa-solid fa-user"></i>
                                        Your Profile
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/member/view?id=${sessionScope.loggedIn.id}" class="nav-link">
                                        <i class="fa-regular fa-address-card"></i>
                                        Your Profile
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:if>
                    <c:if test="${not loggedIn}">
                        <li class="nav-item">
                            <a href="/member/login"
                               class="nav-link <%= "login".equals(request.getParameter("active")) ? "active text-primary fw-bold bg-light" : "" %>">
                                <i class="fa-solid fa-arrow-right-to-bracket"></i>
                                Sign in
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${loggedIn}">
                        <li class="nav-item">
                            <a href="/member/logout" class="nav-link">
                                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                                Sign out
                            </a>
                        </li>
                    </c:if>

                </ul>
            </div>
        </div>
    </nav>
</div>
<div class="mb-1">
    <c:if test="${not empty message}">
        <div class="container mb-4">
            <div class="row justify-content-center">
                <div class="col col-md-8 col-xl-6">
                    <div class="alert alert-${message.type} alert-dismissible fade show">
                        <c:if test="${message.type=='danger'}">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                        </c:if>
                            ${message.text}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>