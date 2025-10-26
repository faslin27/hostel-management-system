<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Fee Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background:#fff; min-height:100vh; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .page-title { margin:30px 0; text-align:center; font-weight:700; font-size:2rem; color:#333; }
        .card { border-radius:15px; box-shadow:0 5px 20px rgba(0,0,0,0.1); padding:30px; margin-bottom:30px; }
        .logout-btn { position:absolute; top:20px; right:20px; background:transparent; border:none; font-size:1.5rem; color:#dc3545; }
        .logout-btn:hover { color:#a71d2a; }
    </style>
</head>
<body class="p-4">

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm rounded px-3">
    <div class="container-fluid">
        <c:choose>
            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="back-link"><i class="bi bi-arrow-left"></i></a>
            </c:when>
            <c:when test="${sessionScope.user.role == 'WARDEN'}">
                <a href="${pageContext.request.contextPath}/warden/dashboard.jsp" class="back-link"><i class="bi bi-arrow-left"></i></a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="back-link"><i class="bi bi-arrow-left"></i></a>
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
    <h2 class="page-title">Fees Management</h2>
    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-info text-center">${sessionScope.msg}</div>
        <c:remove var="msg" scope="session"/>
    </c:if>

    <!-- Admin: Add Fee Record -->
    <c:if test="${sessionScope.user.role == 'ADMIN'}">
        <div class="card">
            <h4><i class="bi bi-plus-square"></i> Add Fee Record</h4>
            <form method="post" action="${pageContext.request.contextPath}/fees">
                <input type="hidden" name="action" value="add"/>

                <div class="row g-3">
                    <!-- ✅ Student dropdown -->
                    <div class="col-md-4">
                        <select name="studentId" class="form-select" required>
                            <option value="">Select Student</option>
                            <c:forEach var="s" items="${students}">
                                <option value="${s.id}">
                                        ${s.name} (${s.regNo})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Year -->
                    <div class="col-md-3">
                        <input type="number" name="feeYear" class="form-control" placeholder="Year" required/>
                    </div>

                    <!-- Period -->
                    <div class="col-md-3">
                        <select name="period" class="form-select" required>
                            <option value="FIRST_HALF">First 6 Months</option>
                            <option value="SECOND_HALF">Second 6 Months</option>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <button class="btn btn-primary w-100">Add Fee</button>
                    </div>
                </div>
            </form>
        </div>
    </c:if>

    <!-- Fee Table -->
    <div class="card">
        <h4><i class="bi bi-cash-coin"></i> Fee Records</h4>
        <table class="table table-bordered table-striped">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Student</th>
                <th>Year</th>
                <th>Period</th>
                <th>Status</th>
                <th>Paid At</th>
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <th>Action</th>
                </c:if>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="f" items="${fees}">
                <tr>
                    <td>${f.id}</td>
                    <td>
                        <c:forEach var="s" items="${students}">
                            <c:if test="${s.id == f.studentId}">
                                ${s.name} (${s.regNo})
                            </c:if>
                        </c:forEach>
                    </td>                    <td>${f.feeYear}</td>
                    <td>${f.period}</td>
                    <td>
                        <span class="badge ${f.status == 'PENDING' ? 'bg-warning' : 'bg-success'}">${f.status}</span>
                    </td>
                    <td>
                        <c:if test="${not empty f.paidAt}">
                            ${f.paidAt}
                        </c:if>
                    </td>
                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                        <td>
                            <c:if test="${f.status == 'PENDING'}">
                                <form method="post" action="${pageContext.request.contextPath}/fees" style="display:inline;">
                                    <input type="hidden" name="action" value="pay"/>
                                    <input type="hidden" name="id" value="${f.id}"/>
                                    <button class="btn btn-sm btn-success">Mark Paid</button>
                                </form>
                            </c:if>
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
