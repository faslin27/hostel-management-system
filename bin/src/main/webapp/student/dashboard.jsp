<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
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
        .logout-btn:hover {
            color: #a71d2a;
        }

        .dashboard-card {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }

        .dashboard-card h3 {
            margin-bottom: 30px;
            font-weight: 600;
        }

        .dashboard-card .btn {
            width: 140px;
            padding: 10px;
            font-size: 1rem;
            border-radius: 8px;
        }

        .dashboard-card .btn-primary {
            background: #007bff;
            border: none;
        }

        .dashboard-card .btn-primary:hover {
            background: #0056b3;
        }

        .dashboard-card .btn-secondary {
            background: #6c757d;
            border: none;
        }

        .dashboard-card .btn-secondary:hover {
            background: #495057;
        }
    </style>
</head>
<body>

<!-- Logout icon top right -->
<form action="${pageContext.request.contextPath}/logout" method="get">
    <button type="submit" class="logout-btn" title="Logout">
        <i class="bi bi-box-arrow-right"></i>
    </button>
</form>

<div class="dashboard-card">
    <h3>Admin Dashboard</h3>
    <div class="d-flex justify-content-center gap-3 flex-wrap">
        <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-primary">My Profile</a>
        <!-- Add more dashboard links here if needed -->
    </div>
</div>

</body>
</html>
