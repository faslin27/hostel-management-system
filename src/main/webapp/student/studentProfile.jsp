<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Student Profile</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet"/>

    <style>
        body {
            background: #f8f9fa;
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .profile-card {
            max-width: 700px;
            margin: 40px auto;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            padding: 30px;
        }

        .profile-header {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-bottom: 30px;
            text-align: center;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: url('https://cdn-icons-png.flaticon.com/512/149/149071.png') center/cover no-repeat;
            border: 3px solid #0d6efd;
        }

        .profile-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: #333;
        }

        .profile-section {
            margin-bottom: 20px;
        }

        .profile-label {
            font-weight: 600;
            color: #555;
        }

        .profile-value {
            color: #222;
        }

        .badge-room {
            font-size: 0.95rem;
        }

        .logout-btn {
            background: transparent;
            border: none;
            font-size: 1.4rem;
            color: #dc3545;
        }

        .logout-btn:hover {
            color: #a71d2a;
        }
    </style>
</head>
<body class="p-4">

<!-- Role-based navigation -->
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

<!-- Profile Card -->
<div class="profile-card">
    <div class="profile-header">
        <div class="profile-avatar"></div>
        <div class="mt-3">
            <div class="profile-title">${student.user.name}</div>
            <div class="text-muted">Reg No: ${student.user.regNo}</div>
        </div>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/students">
        <input type="hidden" name="id" value="${student.user.id}"/>

        <div class="profile-section">
            <div class="profile-label">NIC:</div>
            <div class="profile-value">${empty student.user.nic ? '-' : student.user.nic}</div>
        </div>

        <div class="profile-section">
            <div class="profile-label">Mobile:</div>
            <input type="text" name="mobile" class="form-control" value="${student.user.mobile}" />
        </div>

        <div class="profile-section">
            <div class="profile-label">Emergency Contact:</div>
            <input type="text" name="emergencyNumber" class="form-control" value="${student.emergencyNumber}" />
        </div>

        <div class="profile-section">
            <div class="profile-label">Address:</div>
            <textarea name="address" class="form-control" rows="3">${student.address}</textarea>
        </div>

        <div class="profile-section">
            <div class="profile-label">Faculty:</div>
            <div class="profile-value">${student.faculty}</div>
        </div>

        <div class="profile-section">
            <div class="profile-label">Course:</div>
            <div class="profile-value">${student.course}</div>
        </div>

        <div class="profile-section">
            <div class="profile-label">Department:</div>
            <div class="profile-value">${student.department}</div>
        </div>

        <div class="profile-section">
            <div class="profile-label">Hostel:</div>
            <div class="profile-value">${student.hostelName}</div>
        </div>

        <div class="profile-section">
            <div class="profile-label">Room:</div>
            <div class="profile-value">
                <c:choose>
                    <c:when test="${student.roomId == 0}">
                        <span class="badge bg-secondary badge-room">Not allocated</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-success badge-room">Room ${student.roomId}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-save"></i> Save Changes
            </button>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
