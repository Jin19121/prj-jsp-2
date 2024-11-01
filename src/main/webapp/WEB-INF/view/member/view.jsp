<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>view profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<c:import url="/WEB-INF/fragment/navbar.jsp">
    <c:param name="active" value="view"/>
</c:import>

<%-- 수정/삭제 권한 --%>
<c:set value="${sessionScope.loggedIn.id == member.id}" var="permitted"/>
<%--관리자 여부--%>
<c:set value="${sessionScope.loggedIn.access.contains('admin')}" var="Admin"/>

<div class="container text-bg-success">
    <div class="row justify-content-center">
        <div class="col-12 col-md-9 col-lg-6">
            <h2 class="my-3 border border-success-subtle rounded p-3">${member.nickname}'s Profile</h2>
            <div class="mb-3">
                <label for="inputId" class="form-label">ID</label>
                <input type="text" id="inputId" value="${member.id}" readonly name="id" class="form-control">
            </div>
            <div class="mb-3">
                <label for="inputPassword" class="form-label">Password</label>
                <input type="password" id="inputPassword" value="${member.password}" readonly name="password"
                       class="form-control">
            </div>
            <div class="mb-3">
                <label for="inputNickname" class="form-label">Nickname</label>
                <input type="text" id="inputNickname" value="${member.nickname}" readonly name="id"
                       class="form-control">
            </div>
            <div class="mb-3">
                <label for="inputEmail" class="form-label">E-mail</label>
                <input type="text" id="inputEmail" value="${member.email}" readonly name="email"
                       class="form-control">
            </div>
            <div class="mb-4">
                <label for="inputDate" class="form-label">Registered Date</label>
                <input type="text" id="inputDate" value="${member.signed}" readonly name="signed"
                       class="form-control">
            </div>
            <c:if test="${permitted}">
                <div class="mb-4 mx-1 d-flex justify-content-between">
                    <a href="/member/edit?id=${member.id}" class="btn btn-outline-success btn-light">
                        <i class="fa-solid fa-user-pen"></i>
                        Edit Profile
                    </a>
                    <button class="btn btn-outline-danger btn-light" data-bs-toggle="modal"
                            data-bs-target="#deleteConfirmModal1">
                        <i class="fa-solid fa-user-minus"></i>
                        Delete Account
                    </button>
                </div>
            </c:if>

            <c:if test="${Admin}">
                <div class="mx-1 mb-4 d-flex justify-content-end">
                    <a class="btn btn-sm btn-outline-secondary btn-light" href="/member/mlist">
                        to list
                        <i class="fa-regular fa-address-book"></i>
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>

<c:if test="${permitted}">
    <!-- Modal -->
    <div class="modal fade" id="deleteConfirmModal1" tabindex="-1" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5">Confirmation</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div>
                        <form action="/member/delete" method="post" id="deleteForm1">
                            <input type="hidden" name="id" value="${member.id}">
                            <label for="inputPassword2" class="form-label">
                                Password
                            </label>
                            <input class="form-control" type="text" name="password" id="inputPassword2">
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        Close
                    </button>
                    <button form="deleteForm1" class="btn btn-danger">
                        Delete
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
