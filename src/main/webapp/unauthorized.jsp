<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Unauthorized</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="p-5 text-center">
<h2 class="text-danger">Access Denied</h2>
<p>You do not have permission to view this page.</p>
<a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">Back to Dashboard</a>
</body>
</html>
