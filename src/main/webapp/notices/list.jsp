<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Notices</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #fff;
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .page-title {
            margin: 30px 0;
            text-align: center;
            font-weight: 700;
            font-size: 2rem;
            color: #333;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        .card h4 {
            font-weight: 600;
            margin-bottom: 20px;
        }
        table th, table td {
            vertical-align: middle;
        }
        .back-link {
            margin-top: 20px;
            display: inline-block;
        }
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            background: transparent;
            border: none;
            font-size: 1.5rem;
            color: #dc3545;
        }
        .logout-btn:hover { color: #a71d2a; }
    </style>
</head>
<body class="p-4">

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm rounded px-3">
    <div class="container-fluid">
        <c:choose>
            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="back-link">
                    <i class="bi bi-arrow-left"></i>
                </a>
            </c:when>
            <c:when test="${sessionScope.user.role == 'WARDEN'}">
                <a href="${pageContext.request.contextPath}/warden/dashboard.jsp" class="back-link">
                    <i class="bi bi-arrow-left"></i>
                </a>
            </c:when>
            <c:when test="${sessionScope.user.role == 'STUDENT'}">
                <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="back-link">
                    <i class="bi bi-arrow-left"></i>
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login.jsp" class="back-link">
                    <i class="bi bi-arrow-left"></i>
                </a>
            </c:otherwise>
        </c:choose>
    </div>

    <form action="${pageContext.request.contextPath}/logout" method="get">
        <button type="submit" class="logout-btn" title="Logout">
            <i class="bi bi-box-arrow-right"></i>
        </button>
    </form>
</nav>

<div class="container">
    <h2 class="page-title">Notice Management</h2>
    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-info text-center">${sessionScope.msg}</div>
        <c:remove var="msg" scope="session"/>
    </c:if>

    <!-- Post Notice (Admin/Warden only) -->
    <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'WARDEN'}">
        <div class="card">
            <h4><i class="bi bi-megaphone"></i> Post New Notice</h4>
            <form method="post" action="${pageContext.request.contextPath}/notices">
                <input type="hidden" name="action" value="post"/>
                <div class="mb-3">
                    <label class="form-label">Title</label>
                    <input type="text" name="title" class="form-control" required/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="4" required></textarea>
                </div>
                <button class="btn btn-primary">Post Notice</button>
                <input type="hidden" name="createdBy" value="${sessionScope.user.role}" />
            </form>
        </div>
    </c:if>

    <!-- Notices List -->
    <div class="card">
        <h4><i class="bi bi-list-ul"></i> All Notices</h4>
        <table class="table table-bordered table-striped">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Posted By</th>
                <th>Posted On</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="n" items="${notices}">
                <tr>
                    <td>${n.id}</td>
                    <td>${n.title}</td>
                    <td>${n.description}</td>
                    <td>${n.createdBy}</td>
                    <td>${n.createdAt}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
