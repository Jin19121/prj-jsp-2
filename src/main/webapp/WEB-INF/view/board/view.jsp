<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>view post</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<c:import url="/WEB-INF/fragment/navbar.jsp"/>

<%--삭제/수정 권한--%>
<c:set value="${sessionScope.loggedIn.id == 'admin' || sessionScope.loggedIn.id == board.writer}"
       var="permitted"/>
<%--관리자 여부--%>
<c:set value="${sessionScope.loggedIn.access.contains('admin')}" var="Admin"/>

<%--내용--%>
<div class="container text-bg-primary">
    <div class="row justify-content-center">
        <div class="col-12 col-md-9 col-lg-6">
            <h2 class="my-3 border border-primary-subtle rounded p-3">${board.title}</h2>
            <div class="mb-3">
                <label for="inputTitle1" class="form-label">Post ID#</label>
                <input readonly type="text" id="inputTitle1" value="${board.id}" class="form-control">
            </div>
            <%--            <div class="mb-3">--%>
            <%--                <label for="inputTitle1" class="form-label">Title</label>--%>
            <%--                <input readonly type="text" id="inputTitle1" value="${board.title}" class="form-control">--%>
            <%--            </div>--%>
            <div class="mb-3">
                <label for="inputContent" class="form-label">Content</label>
                <textarea readonly name="content" id="inputContent" class="form-control" cols="30"
                          rows="11">${board.content}</textarea>
            </div>
            <div class="mb-4">
                <label for="inputWriter1" class="form-label">Writer</label>
                <input readonly type="text" name="board.writerName" id="inputWriter1" class="form-control"
                       value="${board.writerName}">
            </div>
            <div class="mb-4">
                <label for="inputDate" class="form-label">Date</label>
                <input readonly type="datetime-local" value="${board.date}" id="inputDate" class="form-control"/>
            </div>
            <div class="mb-3 mx-1 d-flex justify-content-between">
                <c:if test="${permitted || Admin}">
                    <a class="btn btn-outline-success btn-light" href="/board/edit?id=${board.id}">
                        <i class="fa-solid fa-pen-to-square"></i>
                        edit
                    </a>
                    <button class="btn btn-outline-danger btn-light" data-bs-toggle="modal"
                            data-bs-target="#deleteConfirmModal1">
                        <i class="fa-solid fa-trash-can"></i>
                        delete
                    </button>
                    <form id="deleteForm1" class="d-none" action="/board/delete" method="post">
                        <input type="hidden" name="id" value="${board.id}">
                    </form>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<c:if test="${permitted || Admin}">
    <div class="modal fade" id="deleteConfirmModal1" tabindex="-1" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5">Confirmation</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Delete post #${board.id}?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        close
                    </button>
                    <button form="deleteForm1" class="btn btn-danger">
                        delete
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
</body>
</html>
