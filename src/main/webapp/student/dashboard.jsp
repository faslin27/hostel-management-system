<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; min-height: 100vh; display: flex; flex-direction: column; }
        .logout-btn { position: absolute; top: 20px; right: 20px; background: transparent; border: none; font-size: 1.8rem; color: #dc3545; }
        .dashboard-container { flex-grow: 1; display: flex; flex-direction: column; justify-content: center; align-items: center; padding: 40px; }
        .dashboard-title { margin-bottom: 40px; font-weight: 700; font-size: 2rem; }
        .card-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 25px; width: 100%; max-width: 1000px; }
        .dashboard-card { background: #fff; border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); padding: 40px 20px; text-align: center; cursor: pointer; text-decoration: none; color: inherit; }
        .dashboard-card i { font-size: 3rem; margin-bottom: 15px; color: #007bff; }
        .dashboard-card h5 { margin: 0; font-weight: 600; font-size: 1.2rem; }
    </style>
</head>
<body>
<form action="${pageContext.request.contextPath}/logout" method="get">
    <button type="submit" class="logout-btn" title="Logout"><i class="bi bi-box-arrow-right"></i></button>
</form>

<div class="dashboard-container">
    <h2 class="dashboard-title">Student Dashboard</h2>
    <div class="card-grid">
        <a href="${pageContext.request.contextPath}/students" class="dashboard-card">
            <i class="bi bi-person"></i><h5>My Profile</h5>
        </a>

        <a href="${pageContext.request.contextPath}/fees" class="dashboard-card">
            <i class="bi bi-cash-coin"></i><h5>My Payments</h5>
        </a>

        <a href="${pageContext.request.contextPath}/complaints" class="dashboard-card">
            <i class="bi bi-exclamation-octagon"></i><h5>My Complaints</h5>
        </a>

        <a href="${pageContext.request.contextPath}/notices" class="dashboard-card">
            <i class="bi bi-megaphone"></i><h5>Notices</h5>
        </a>

    </div>
</div>
</body>
</html>
