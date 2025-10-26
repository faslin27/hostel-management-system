<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>SEU Hostel Management - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            background: #f8f9fa;
        }
        .login-card {
            max-width: 400px;
            margin: 80px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .login-card h3 {
            margin-bottom: 25px;
            text-align: center;
            font-weight: 600;
        }
        .logo {
            display: block;
            margin: 0 auto 20px;
            width: 100px;
            height: 100px;
            background: #007bff;
            border-radius: 50%;
            color: #fff;
            font-size: 20px;
            line-height: 100px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="login-card">
    <div class="logo">SEUSL</div>
    <h3>Hostel Management Login</h3>
    <form method="post" action="<%= request.getContextPath() %>/login">
        <div class="mb-3">
            <input name="username" placeholder="Username" class="form-control" required/>
        </div>
        <div class="mb-3">
            <input name="password" type="password" placeholder="Password" class="form-control" required/>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <button class="btn btn-primary w-100">Login</button>
    </form>
</div>
</body>
</html>
