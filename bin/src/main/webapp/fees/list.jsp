<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Fees</title>
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
    <h2 class="page-title">Fees Management</h2>

    ```
    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-info text-center">${sessionScope.msg}</div>
        <c:remove var="msg" scope="session"/>
    </c:if>

    <!-- Admin/Warden: Add Fee Record -->
    <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'WARDEN'}">
        <div class="card">
            <h4><i class="bi bi-plus-square"></i> Add Fee Record</h4>
            <form method="post" action="${pageContext.request.contextPath}/fees">
                <input type="hidden" name="action" value="add"/>
                <div class="row g-3">
                    <div class="col-md-4">
                        <input type="number" name="studentId" class="form-control" placeholder="Student ID" required/>
                    </div>
                    <div class="col-md-4">
                        <input type="number" step="0.01" name="amount" class="form-control" placeholder="Amount" required/>
                    </div>
                    <div class="col-md-4">
                        <button class="btn btn-primary w-100">Add Fee</button>
                    </div>
                </div>
            </form>
        </div>
    </c:if>

    <!-- Fees Table -->
    <div class="card">
        <h4><i class="bi bi-cash-coin"></i> Fee Records</h4>
        <table class="table table-bordered table-striped">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Student ID</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Paid At</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="f" items="${fees}">
                <tr>
                    <td>${f.id}</td>
                    <td>${f.studentId}</td>
                    <td>${f.amount}</td>
                    <td>
                    <span class="badge
                        ${f.status == 'PENDING' ? 'bg-warning' : 'bg-success'}">
                            ${f.status}
                    </span>
                    </td>
                    <td>${f.paidAt}</td>
                    <td>
                        <c:if test="${f.status == 'PENDING'}">
                            <form method="post" action="${pageContext.request.contextPath}/fees" style="display:inline;">
                                <input type="hidden" name="action" value="pay"/>
                                <input type="hidden" name="id" value="${f.id}"/>
                                <button class="btn btn-sm btn-success">Mark Paid</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
