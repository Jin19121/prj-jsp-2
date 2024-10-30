<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>new post</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<%--메뉴--%>
<c:import url="/WEB-INF/fragment/navbar.jsp"/>

<div class="container text-bg-primary">
    <div class="row justify-content-center">
        <div class="col-12 col-md-9 col-lg-6">
            <h2 class="my-3 mx-3">New Post</h2>
            <form method="post">
                <div class="mb-3">
                    <label for="inputTitle1" class="form-label">Title</label>
                    <input type="text" id="inputTitle1" name="title" class="form-control">
                </div>
                <div class="mb-4">
                    <label for="inputContent" class="form-label">Content</label>
                    <textarea name="content" id="inputContent" class="form-control" cols="30" rows="10"></textarea>
                </div>
                <%--                <div class="mb-4">--%>
                <%--                    <label for="inputWriter1" class="form-label">Writer</label>--%>
                <%--                    <input type="text" name="writer" id="inputWriter1" class="form-control"/>--%>
                <%--                </div>--%>
                <div class="mb-4 mx-1 d-flex justify-content-between">
                    <button class="btn btn-light btn-outline-primary">
                        <i class="fa-solid fa-plus"></i>
                        Post
                    </button>
                    <a href="/board/list" class="btn btn-outline-secondary btn-light">
                        Cancel
                        <i class="fa-solid fa-xmark"></i>
                    </a>
                </div>
            </form>
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
