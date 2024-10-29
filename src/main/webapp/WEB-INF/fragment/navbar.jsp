<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <a class="navbar-brand" href="/board/list">Community</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="/board/list">
                        <i class="fa-solid fa-list"></i>
                        Timeline
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/board/new">
                        <i class="fa-solid fa-file-pen"></i>
                        New Post
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/member/register">
                        <i class="fa-solid fa-user-plus"></i>
                        Register
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/member/list" class="nav-link">
                        <i class="fa-regular fa-address-book"></i>
                        Members
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/member/login" class="nav-link">
                        <i class="fa-solid fa-arrow-right-to-bracket"></i>
                        Log In
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/member/login" class="nav-link">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        Log Out
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<c:if test="${not empty message}">
    <div class="container mb-4">
        <div class="row justify-content-center">
            <div class="col col-md-8 col-xl-6">
                <div class="alert alert-${message.type} alert-dismissible fade show">
                        ${message.text}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </div>
        </div>
    </div>
</c:if>