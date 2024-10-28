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

<div class="container text-bg-primary">
    <div class="row justify-content-center">
        <div class="col-12 col-md-9 col-lg-6">
            <h2 class="my-3 mx-3">Post ${board.id}</h2>
            <div class="mb-3">
                <label for="inputTitle1" class="form-label">Title</label>
                <input readonly type="text" id="inputTitle1" value="${board.title}" class="form-control">
            </div>
            <div class="mb-3">
                <label for="inputContent" class="form-label">Content</label>
                <textarea readonly name="content" id="inputContent" class="form-control" cols="30"
                          rows="10">${board.content}</textarea>
            </div>
            <div class="mb-4">
                <label for="inputWriter1" class="form-label">Writer</label>
                <input readonly type="text" name="writer" id="inputWriter1" class="form-control"
                       value="${board.writer}">
            </div>

            <div class="mb-4">
                <label for="inputDate" class="form-label">Date</label>
                <input readonly type="datetime-local" value="${board.date}" id="inputDate" class="form-control"/>
            </div>
            <div class="mb-4">
                <form action="/board/delete" method="post">
                    <input type="hidden" name="id" value="${board.id}">
                    <button class="btn btn-outline-danger btn-light">
                        <i class="fa-regular fa-trash-can"></i>
                        삭제
                    </button>
                </form>
                <a class="btn btn-outline-success btn-light" href="/board/edit?id=${board.id}">
                    <i class="fa-solid fa-pen-to-square"></i>
                    수정
                </a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
</body>
</html>
