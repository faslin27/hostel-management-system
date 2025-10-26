<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>My Profile</title>
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
            font-size: 1.2rem;
            color: #dc3545;
        }
        .logout-btn:hover {
            color: #a71d2a;
        }

        .profile-card {
            width: 100%;
            max-width: 500px;
            padding: 30px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            text-align: center;
            position: relative;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin: 0 auto 20px auto;
            background: url('https://cdn-icons-png.flaticon.com/512/149/149071.png') center/cover no-repeat;
            border: 3px solid #007bff;
        }

        .profile-card h3 {
            margin-bottom: 25px;
        }

        .profile-card input {
            text-align: center;
        }

        .btn-group {
            margin-top: 20px;
        }
    </style>
    <script>
        function enableEdit() {
            const fields = document.querySelectorAll('.profile-card input');
            fields.forEach(f => f.removeAttribute('disabled'));
            document.getElementById('saveBtn').style.display = 'inline-block';
            document.getElementById('editBtn').style.display = 'none';
        }
    </script>
</head>
<body>

<!-- Logout button top right -->
<form action="${pageContext.request.contextPath}/logout" method="get">
    <button type="submit" class="logout-btn" title="Logout">
        <i class="bi bi-box-arrow-right"></i>
    </button>
</form>

<div class="profile-card">
    <div class="profile-avatar"></div>
    <h3>My Profile</h3>
    <form method="post" action="${pageContext.request.contextPath}/user/profile">
        <c:set var="u" value="${userObj}" />

        <div class="mb-3">
            <input name="name" class="form-control" value="${u.name}" disabled />
        </div>
        <div class="mb-3">
            <input name="regNo" class="form-control" value="${u.regNo}" disabled />
        </div>
        <div class="mb-3">
            <input name="nic" class="form-control" value="${u.nic}" disabled />
        </div>
        <div class="mb-3">
            <input name="mobile" class="form-control" value="${u.mobile}" disabled />
        </div>

        <div class="d-flex justify-content-center btn-group">
            <button type="button" class="btn btn-warning" id="editBtn" onclick="enableEdit()">Edit Profile</button>
            <button type="submit" class="btn btn-primary" id="saveBtn" style="display:none;">Save</button>
        </div>
    </form>
</div>

</body>
</html>
