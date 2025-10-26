<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Student Management</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet"/>

    <style>
        body { background:#fff; min-height:100vh; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .page-title { margin:30px 0; text-align:center; font-weight:700; font-size:2rem; color:#333; }
        .card { border-radius:15px; box-shadow:0 5px 20px rgba(0,0,0,0.1); padding:20px; margin-bottom:30px; }
        .back-link { display:inline-flex; align-items:center; gap:8px; text-decoration:none; color:#333; }
        .back-link:hover { color:#0d6efd; }
        .logout-btn { background: transparent; border: none; font-size: 1.4rem; color: #dc3545; }
        .navbar .right-actions { margin-left:auto; display:flex; align-items:center; gap:12px; }
        .table thead th { white-space: nowrap; }
    </style>
</head>
<body class="p-4">

<!-- Redirect if accessed directly -->
<c:if test="${students == null}">
    <c:redirect url='${pageContext.request.contextPath}/students'/>
</c:if>

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
    <h2 class="page-title">Student Management</h2>

    <!-- Session message -->
    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-info text-center">${sessionScope.msg}</div>
        <c:remove var="msg" scope="session"/>
    </c:if>

    <div class="card">
        <h4 class="mb-3"><i class="bi bi-people"></i> All Students</h4>

        <div class="table-responsive">
            <table class="table table-bordered table-striped mb-0 align-middle">
                <thead class="table-light">
                <tr>
                    <th>Name</th>
                    <th>Reg No</th>
                    <th>NIC</th>
                    <th>Mobile</th>
                    <th>Faculty</th>
                    <th>Course</th>
                    <th>Department</th>
                    <th>Hostel</th>
                    <th>Emergency No</th>
                    <th>Address</th>
                    <th>Room</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty students}">
                    <tr>
                        <td colspan="15" class="text-center text-muted">No students found.</td>
                    </tr>
                </c:if>

                <c:forEach var="s" items="${students}">
                    <tr>
                        <td>${s.user.name}</td>
                        <td>${s.user.regNo}</td>
                        <td>${empty s.user.nic ? '-' : s.user.nic}</td>
                        <td>${empty s.user.mobile ? '-' : s.user.mobile}</td>
                        <td>${s.faculty}</td>
                        <td>${s.course}</td>
                        <td>${s.department}</td>
                        <td>${s.hostelName}</td>
                        <td>${s.emergencyNumber}</td>
                        <td>${s.address}</td>
                        <td>
                            <c:choose>
                                <c:when test="${s.roomId == 0}">
                                    <span class="badge bg-secondary">Not allocated</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-success">Room ${s.roomId}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
