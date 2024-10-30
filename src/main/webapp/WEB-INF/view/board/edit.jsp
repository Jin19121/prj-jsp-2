<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>edit post</title>
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
            <h2 class="my-3 border border-primary-subtle rounded p-3">Edit Post #${board.id}</h2>
            <form method="post" id="updateForm">
                <div class="mb-3">
                    <label for="inputTitle1" class="form-label">Title</label>
                    <input type="text" id="inputTitle1" name="title" value="${board.title}" class="form-control">
                </div>
                <div class="mb-4">
                    <label for="inputContent" class="form-label">Content</label>
                    <textarea name="content" id="inputContent" class="form-control"
                              cols="30" rows="10">${board.content}</textarea>
                </div>
                <%--                <div class="mb-4">--%>
                <%--                    <label for="inputWriter1" class="form-label">Writer</label>--%>
                <%--                    <input type="text" name="writer" value="${board.writer}" id="inputWriter1" class="form-control"/>--%>
                <%--                </div>--%>

                <div class="mb-4 mx-1 d-flex justify-content-between">
                    <button class="btn btn-outline-success btn-light" data-bs-toggle="modal"
                            data-bs-target="#updateConfirmModal" type="button">
                        <i class="fa-solid fa-pen-to-square"></i>
                        edit
                    </button>
                    <a href="/board/view?id=${board.id}" class="btn btn-outline-secondary btn-light">
                        Cancel
                        <i class="fa-solid fa-xmark"></i>
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal" id="updateConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">Confirmation</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Save edited post "${board.title}"?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    close
                </button>
                <button form="updateForm" class="btn btn-success">
                    save
                </button>
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
