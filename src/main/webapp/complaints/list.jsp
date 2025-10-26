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
        .logout-btn {
            background: transparent;
            border: none;
            font-size: 1.5rem;
            color: #dc3545;
        }
        .logout-btn:hover { color: #a71d2a; }
        .status-note {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 5px;
        }
    </style>
</head>
<body class="p-4">

<!-- Top Navigation -->
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm rounded px-3 mb-4">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <c:choose>
            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i>
                </a>
            </c:when>
            <c:when test="${sessionScope.user.role == 'WARDEN'}">
                <a href="${pageContext.request.contextPath}/warden/dashboard.jsp" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i>
                </a>
            </c:when>
            <c:when test="${sessionScope.user.role == 'STUDENT'}">
                <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i>
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i> Login
                </a>
            </c:otherwise>
        </c:choose>

        <form action="${pageContext.request.contextPath}/logout" method="get" class="mb-0">
            <button type="submit" class="logout-btn" title="Logout">
                <i class="bi bi-box-arrow-right"></i>
            </button>
        </form>
    </div>
</nav>

<!-- Page Content -->
<div class="container">
    <h2 class="page-title">Complaint Management</h2>

    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-info text-center">${sessionScope.msg}</div>
        <c:remove var="msg" scope="session"/>
    </c:if>

    <c:if test="${sessionScope.user.role == 'STUDENT' || sessionScope.user.role == 'WARDEN'}">
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

    <div class="card">
        <h4><i class="bi bi-list-ul"></i> Complaints List</h4>
        <table class="table table-bordered table-striped">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Created By</th>
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
                <c:choose>
                    <c:when test="${sessionScope.user.role != 'STUDENT'}">
                        <tr>
                            <td>${c.id}</td>
                            <td>${c.createdByName} (${c.createdByRegNo})</td>
                            <td>${c.title}</td>
                            <td>${c.description}</td>
                            <td>
                                <span class="badge
                                    ${c.status == 'PENDING' ? 'bg-warning' :
                                      c.status == 'IN_PROGRESS' ? 'bg-info' : 'bg-success'}">
                                        ${c.status}
                                </span>
                                <c:if test="${not empty c.note}">
                                    <div class="status-note">
                                        <i class="bi bi-chat-left-text"></i> ${c.note}
                                    </div>
                                </c:if>
                            </td>
                            <td>${c.createdAt}</td>
                            <td>
                                <form method="post" action="${pageContext.request.contextPath}/complaints" class="d-flex flex-column gap-2">
                                    <input type="hidden" name="action" value="update"/>
                                    <input type="hidden" name="id" value="${c.id}"/>
                                    <div class="d-flex gap-2">
                                        <select name="status" class="form-select form-select-sm w-50">
                                            <option ${c.status=='PENDING'?'selected':''}>PENDING</option>
                                            <option ${c.status=='IN_PROGRESS'?'selected':''}>IN_PROGRESS</option>
                                            <option ${c.status=='RESOLVED'?'selected':''}>RESOLVED</option>
                                        </select>
                                        <button class="btn btn-sm btn-success">Update</button>
                                    </div>
                                    <textarea name="note" class="form-control form-control-sm mt-1" placeholder="Add note..." rows="1">${c.note}</textarea>
                                </form>
                            </td>
                        </tr>
                    </c:when>

                    <c:when test="${sessionScope.user.role == 'STUDENT' && c.createdBy == sessionScope.user.id}">
                        <tr>
                            <td>${c.id}</td>
                            <td>${c.createdByName} (${c.createdByRegNo})</td>
                            <td>${c.title}</td>
                            <td>${c.description}</td>
                            <td>
                                <span class="badge
                                    ${c.status == 'PENDING' ? 'bg-warning' :
                                      c.status == 'IN_PROGRESS' ? 'bg-info' : 'bg-success'}">
                                        ${c.status}
                                </span>
                                <c:if test="${not empty c.note}">
                                    <div class="status-note">
                                        <i class="bi bi-chat-left-text"></i> ${c.note}
                                    </div>
                                </c:if>
                            </td>
                            <td>${c.createdAt}</td>
                        </tr>
                    </c:when>
                </c:choose>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
