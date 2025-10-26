<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Complaints</title>
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
        table th, table td { vertical-align: middle; }
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
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="back-link"> <i
                class="bi bi-arrow-left"></i>
        </a></div>
    <form action="${pageContext.request.contextPath}/logout" method="get">
        <button type="submit" class="logout-btn" title="Logout">
            <i class="bi bi-box-arrow-right"></i>
        </button>
    </form>
    </div>
</nav>

<div class="container">
    <h2 class="page-title">Complaint Management</h2>

    ```
    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-info text-center">${sessionScope.msg}</div>
        <c:remove var="msg" scope="session"/>
    </c:if>

    <!-- Student: Submit Complaint -->
    <c:if test="${sessionScope.user.role == 'STUDENT'}">
        <div class="card">
            <h4><i class="bi bi-pencil-square"></i> Submit Complaint</h4>
            <form method="post" action="${pageContext.request.contextPath}/complaints">
                <input type="hidden" name="action" value="submit"/>
                <div class="mb-3">
                    <label class="form-label">Title</label>
                    <input type="text" name="title" class="form-control" required/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="4" required></textarea>
                </div>
                <button class="btn btn-primary">Submit</button>
            </form>
        </div>
    </c:if>

    <!-- Complaint List -->
    <div class="card">
        <h4><i class="bi bi-list-ul"></i> Complaints List</h4>
        <table class="table table-bordered table-striped">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Student</th>
                <th>Title</th>
                <th>Description</th>
                <th>Status</th>
                <th>Created At</th>
                <c:if test="${sessionScope.user.role != 'STUDENT'}">
                    <th>Actions</th>
                </c:if>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="c" items="${complaints}">
                <tr>
                    <td>${c.id}</td>
                    <td>${c.studentId}</td>
                    <td>${c.title}</td>
                    <td>${c.description}</td>
                    <td>
                    <span class="badge
                        ${c.status == 'PENDING' ? 'bg-warning' :
                          c.status == 'IN_PROGRESS' ? 'bg-info' : 'bg-success'}">
                            ${c.status}
                    </span>
                    </td>
                    <td>${c.createdAt}</td>
                    <c:if test="${sessionScope.user.role != 'STUDENT'}">
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/complaints" class="d-flex gap-2">
                                <input type="hidden" name="action" value="update"/>
                                <input type="hidden" name="id" value="${c.id}"/>
                                <select name="status" class="form-select form-select-sm">
                                    <option ${c.status=='PENDING'?'selected':''}>PENDING</option>
                                    <option ${c.status=='IN_PROGRESS'?'selected':''}>IN_PROGRESS</option>
                                    <option ${c.status=='RESOLVED'?'selected':''}>RESOLVED</option>
                                </select>
                                <button class="btn btn-sm btn-success">Update</button>
                            </form>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
