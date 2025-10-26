<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Reports</title>
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
            padding: 25px;
            margin-bottom: 30px;
            text-align: center;
        }
        .card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: #007bff;
        }
        .card h4 {
            font-weight: 600;
            margin-bottom: 10px;
        }
        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
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
    <h2 class="page-title">Hostel Reports</h2>
    <div class="row g-4">

        <!-- Rooms -->
        <div class="col-md-3">
            <div class="card">
                <i class="bi bi-house-door"></i>
                <h4>Total Rooms</h4>
                <div class="stat-value">${report.totalRooms}</div>
            </div>
        </div>

        <!-- Students -->
        <div class="col-md-3">
            <div class="card">
                <i class="bi bi-person-badge"></i>
                <h4>Total Students</h4>
                <div class="stat-value">${report.totalStudents}</div>
            </div>
        </div>

        <!-- Beds -->
        <div class="col-md-3">
            <div class="card">
                <i class="bi bi-door-open"></i>
                <h4>Occupied Beds</h4>
                <div class="stat-value">${report.occupiedBeds}</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <i class="bi bi-check2-square"></i>
                <h4>Available Beds</h4>
                <div class="stat-value">${report.availableBeds}</div>
            </div>
        </div>

        <!-- Fees -->
        <div class="col-md-3">
            <div class="card">
                <i class="bi bi-wallet2"></i>
                <h4>Pending Fees</h4>
                <div class="stat-value text-warning">${report.pendingFees}</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <i class="bi bi-cash-coin"></i>
                <h4>Paid Fees</h4>
                <div class="stat-value text-success">${report.paidFees}</div>
            </div>
        </div>

        <!-- Complaints -->
        <div class="col-md-3">
            <div class="card">
                <i class="bi bi-exclamation-triangle"></i>
                <h4>Complaints Pending</h4>
                <div class="stat-value text-danger">${report.complaintsPending}</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <i class="bi bi-check-circle"></i>
                <h4>Complaints Resolved</h4>
                <div class="stat-value text-success">${report.complaintsResolved}</div>
            </div>
        </div>

        <!-- Visitors -->
        <div class="col-md-3">
            <div class="card">
                <i class="bi bi-people"></i>
                <h4>Total Visitors</h4>
                <div class="stat-value">${report.visitorCount}</div>
            </div>
        </div>

    </div>
</div>

</body>
</html>
