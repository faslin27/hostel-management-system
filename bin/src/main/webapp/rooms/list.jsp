<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Rooms Management Module</title>
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
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
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

        ul {
            margin: 0;
            padding-left: 18px;
        }

        .logout-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            background: transparent;
            border: none;
            font-size: 1.8rem;
            color: #dc3545;
        }

        .logout-btn:hover {
            color: #a71d2a;
        }

        .back-link {
            margin-top: 20px;
            display: inline-block;
        }

        .table-responsive {
            max-height: 500px;
            overflow-y: auto;
        }

        .table-responsive thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 1;
        }
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
    <h2 class="page-title">Room Management</h2>

    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-info text-center">${sessionScope.msg}</div>
        <c:remove var="msg" scope="session"/>
    </c:if>

    <!-- Card 1: Manage Allocations -->
    <div class="card">
        <h4><i class="bi bi-door-open"></i> Manage Allocations</h4>
        <div class="table-responsive">
            <table class="table table-bordered table-striped mb-0">
                <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Room No</th>
                    <th>Capacity</th>
                    <th>Status</th>
                    <th>Allocate Student</th>
                    <th>Current Occupants</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="r" items="${rooms}">
                    <tr>
                        <td>${r.id}</td>
                        <td>${r.roomNumber}</td>
                        <td>
                                ${r.capacity} beds <br/>
                                ${r.filled} occupied <br/>
                                ${r.remaining} available
                        </td>
                        <td>
                            <span class="badge ${r.status == 'VACANT' ? 'bg-success' : 'bg-danger'}">${r.status}</span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${r.status != 'FULL'}">
                                    <form method="post" class="d-flex gap-2"
                                          action="${pageContext.request.contextPath}/rooms">
                                        <input type="hidden" name="action" value="allocate"/>
                                        <input type="hidden" name="roomId" value="${r.id}"/>
                                        <select name="studentId" class="form-select form-select-sm" required>
                                            <option value="">--Select Student--</option>
                                            <c:forEach var="s" items="${students}">
                                                <option value="${s.id}">${s.name} (${s.regNo})</option>
                                            </c:forEach>
                                        </select>
                                        <button class="btn btn-sm btn-success">Allocate</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <em>No beds available</em>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <ul>
                                <c:forEach var="s" items="${r.allocations}">
                                    <li>
                                            ${s.name} (${s.username})
                                        <form method="post" action="${pageContext.request.contextPath}/rooms"
                                              style="display:inline;">
                                            <input type="hidden" name="action" value="unallocate"/>
                                            <input type="hidden" name="roomId" value="${r.id}"/>
                                            <input type="hidden" name="studentId" value="${s.id}"/>
                                            <button class="btn btn-sm btn-danger">Remove</button>
                                        </form>
                                    </li>
                                </c:forEach>
                            </ul>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Card 2: Add New Room -->
    <div class="card">
        <h4><i class="bi bi-plus-square"></i> Add New Room</h4>
        <form method="post" action="${pageContext.request.contextPath}/rooms">
            <input type="hidden" name="action" value="add"/>
            <div class="row g-3">
                <div class="col-md-4">
                    <input name="roomNumber" class="form-control" placeholder="Room Number" required/>
                </div>
                <div class="col-md-3">
                    <input name="capacity" type="number" class="form-control" value="2" min="1" required/>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-primary w-100">Add Room</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
