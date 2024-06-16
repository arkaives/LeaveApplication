<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Leave List</title>
    <link rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <style>
        body {
            background-color: #BE93D4;
            color: black;
            font-family: Arial, sans-serif;
        }

        header {
            background-color: black;
        }

        .navbar-brand {
            color: white !important;
        }

        .navbar-nav .nav-link {
            color: white !important;
        }

        .navbar-nav .nav-link:hover {
            color: purple !important;
        }

        h3 {
            color: black;
        }

        .btn-custom {
            background-color: white;
            border-color: white;
            color: black;
            transition: box-shadow 0.3s ease;
        }

        .btn-custom:hover {
            background-color: purple;
            border-color: purple;
            color: white;
            box-shadow: 0 0 10px purple;
        }

        .btn-circle {
            border-radius: 50%;
            width: 30px;  /* Smaller width */
            height: 30px; /* Smaller height */
            padding: 5px;
            text-align: center;
            font-size: 16px;
            line-height: 1.42857;
            display: inline-flex;
            justify-content: center;
            align-items: center;
        }

        .btn-edit {
            background-color: blue;
            border-color: blue;
            color: white;
            transition: box-shadow 0.3s ease;
            margin-right: 5px; /* Adjust spacing between buttons */
        }

        .btn-edit:hover {
            box-shadow: 0 0 10px blue;
        }

        .btn-delete {
            background-color: red;
            border-color: red;
            color: white;
            transition: box-shadow 0.3s ease;
        }

        .btn-delete:hover {
            box-shadow: 0 0 10px red;
        }

        .material-icons {
            font-size: 18px; /* Smaller icon size */
        }

        .table-container {
            opacity: 0;
            transform: translateY(20px);
            animation: slide-up 1s forwards;
        }

        @keyframes slide-up {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table {
            border-radius: 10px;
            overflow: hidden; /* Ensure rounded corners */
        }

        .table th, .table td {
            color: black;
        }

        .table th {
            background-color: purple;
            color: white;
        }

        .table tbody tr:nth-child(odd) {
            background-color: #f2f2f2;
        }

        .table tbody tr:nth-child(even) {
            background-color: white;
        }

        .table a {
            color: white;
        }

        .table a:hover {
            color: white;
        }
    </style>
</head>
<body>

    <header>
        <nav class="navbar navbar-expand-md navbar-dark">
            <div>
                <a href="#" class="navbar-brand">Leave Application</a>
            </div>
            <ul class="navbar-nav">
                <li><a href="<%=request.getContextPath()%>/leave-list?action=new" class="nav-link">Apply for Leave</a></li>
            </ul>
        </nav>
    </header>
    <br>

    <div class="row">
        <div class="container">
            <h3 class="text-center">List of Leave Applications</h3>
            <hr>
            <div class="container text-left">
                <a href="<%=request.getContextPath()%>/leave-list?action=new" class="btn btn-custom">Apply for Leave</a>
            </div>
            <br>
            <div class="table-container">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Leave Type</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="leave" items="${listLeave}">
                            <tr>
                                <td><c:out value="${leave.id}" /></td>
                                <td><c:out value="${leave.name}" /></td>
                                <td><c:out value="${leave.leaveType}" /></td>
                                <td><c:out value="${leave.status}" /></td>
                                <td>
                                    <a href="leave-list?action=edit&id=<c:out value='${leave.id}' />" class="btn btn-edit btn-circle">
                                        <i class="material-icons">edit</i>
                                    </a>
                                    <a href="leave-list?action=delete&id=<c:out value='${leave.id}' />" class="btn btn-delete btn-circle">
                                        <i class="material-icons">delete</i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
