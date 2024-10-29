<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Members</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<c:import url="/WEB-INF/fragment/navbar.jsp"/>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-md-9 col-lg-6">
            <h2 class="my-3">Members</h2>
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th class="w-50">Nickname</th>
                    <th>Registered Date</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${memberList}" var="m">
                    <tr>
                        <td>
                            <a href="/member/view?id=${m.id}">${m.id}</a>
                        </td>
                        <td>${m.nickname}</td>
                        <td>${m.signed}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%--member pagination--%>
<nav class="mt-4">
    <ul class="pagination justify-content-center">
        <c:if test="${pageMap.hasPrev}">
            <c:url value="/member/list" var="pageLink">
                <c:param name="page" value="${pageMap.prev}"/>
                <c:param name="search" value="${pageMap.search}"/>
                <c:param name="keyword" value="${pageMap.keyword}"/>
            </c:url>
            <li class="page-item">
                <a href="${pageLink}" class="page-link">
                    &laquo;
                </a>
            </li>
        </c:if>
        <c:forEach begin="${pageMap.left}" end="${pageMap.right}" var="pageNo">
            <c:url value="/member/list" var="pageLink">
                <c:param name="page" value="${pageNo}"/>
                <c:param name="search" value="${pageMap.search}"/>
                <c:param name="keyword" value="${pageMap.keyword}"/>
            </c:url>
            <li class="page-item ${pageMap.current == pageNo ? 'active':''}">
                <a href="${pageLink}" class="page-link">${pageNo}</a>
            </li>
        </c:forEach>
        <c:if test="${pageMap.hasNext}">
            <c:url value="/member/list" var="pageLink">
                <c:param name="page" value="${pageMap.next}"/>
                <c:param name="search" value="${pageMap.search}"/>
                <c:param name="keyword" value="${pageMap.keyword}"/>
            </c:url>
            <li class="page-item">
                <a href="${pageLink}" class="page-link">
                    &raquo;
                </a>
            </li>
        </c:if>
    </ul>
</nav>

<%--검색 창--%>
<div class="container my-3">
    <form class="row justify-content-center g-1">
        <div class="col-auto">
            <select name="search" id="select1" class="form-select">
                <option value="all">All</option>
                <option value="id" ${param.search == 'id'?'selected':''}>ID</option>
                <option value="nickname" ${param.search == 'nickname'?'selected':''}>Nickname</option>
                <option value="email" ${param.search == 'email'?'selected':''}>E-Mail</option>
            </select>
        </div>
        <div class="col-6 col-md-4 col-lg-3">
            <input type="text" name="keyword" class="form-control" value="${param.keyword}">
        </div>
        <div class="col-auto">
            <button class="btn btn-outline-primary h-100">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </div>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
</body>
</html>
