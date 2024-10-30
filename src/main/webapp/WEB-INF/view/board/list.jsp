<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Timeline</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>

<c:import url="/WEB-INF/fragment/navbar.jsp"/>
<c:set value="${not empty sessionScope.loggedIn}" var="loggedIn"/>

<div class="container">
    <form action="" class="row justify-content-center">
        <div class="col">
            <h2 class="my-3">Community Timeline</h2>
            <table class="table table-hover">
                <thead>
                <tr class="table-primary">
                    <th>
                        <i class="fa-solid fa-hashtag"></i>
                    </th>
                    <th class="w-50">Title</th>
                    <th>
                        Writer
                        <i class="fa-solid fa-user-pen"></i>
                    </th>
                    <th class="d-none d-lg-table-cell">
                        Date
                        <i class="fa-regular fa-calendar"></i>
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${boardList}" var="board" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td>
                            <a href="/board/view?id=${board.id}">
                                    ${board.title}
                            </a>
                        </td>
                        <td>${board.writerName}</td>
                        <td class="d-none d-lg-table-cell">${board.date}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </form>

    <%--    새 글 버튼--%>
    <c:if test="${loggedIn}">
        <div class="row justify-content-center">
            <div class="col text-end">
                <form action="/board/new" class="mx-3">
                    <button class="btn btn-primary btn-sm">
                        New Post
                        <i class="fa-solid fa-file-circle-plus"></i>
                    </button>
                </form>
            </div>
        </div>
    </c:if>
</div>

<%--pagination--%>
<nav class="mt-4">
    <ul class="pagination justify-content-center">
        <c:if test="${pageInfo.hasPrev}">
            <c:url value="/board/list" var="pageLink">
                <c:param name="page" value="${pageInfo.prev}"/>
                <c:param name="target" value="${param.target}"/>
                <c:param name="keyword" value="${param.keyword}"/>
            </c:url>
            <li class="page-item">
                <a href="${pageLink}" class="page-link">
                    &laquo;
                </a>
            </li>
        </c:if>
        <c:forEach begin="${pageInfo.leftEnd}"
                   end="${pageInfo.rightEnd}"
                   var="pageNo">
            <c:url value="/board/list" var="pageLink">
                <c:param name="page" value="${pageNo}"/>
                <c:param name="target" value="${param.target}"/>
                <c:param name="keyword" value="${param.keyword}"/>
            </c:url>
            <li class="page-item ${pageInfo.currentPage == pageNo ? 'active' : ''}">
                <a href="${pageLink}" class="page-link">${pageNo}</a>
            </li>
        </c:forEach>
        <c:if test="${pageInfo.hasNext}">
            <c:url value="/board/list" var="pageLink">
                <c:param name="page" value="${pageInfo.next}"/>
                <c:param name="target" value="${param.target}"/>
                <c:param name="keyword" value="${param.keyword}"/>
            </c:url>
            <li class="page-item">
                <a href="${pageLink}" class="page-link">
                    &raquo;
                </a>
            </li>
        </c:if>
    </ul>
</nav>

<%--검색 form--%>
<div class="container my-3">
    <form class="row justify-content-center g-1">
        <div class="col-auto">
            <select name="target" id="select1" class="form-select">
                <option value="all">All</option>
                <option value="title" ${param.target=='title'?'selected':''}>Title</option>
                <option value="content" ${param.target=='content'?'selected':''}>Content</option>
                <option value="writer" ${param.target=='writer'?'selected':''}>Writer</option>
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
