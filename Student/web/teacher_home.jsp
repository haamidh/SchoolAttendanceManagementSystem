<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="app.classes.dao.*" %>
<%@ page import="app.classes.model.*" %>
<%
    User user = (User) session.getAttribute("user");
    String displayTeacherName = request.getParameter("username");
    TeacherDAO teacherDAO = new TeacherDAO();
    String displayTeacherId = teacherDAO.displayTeacherId(displayTeacherName);
    session.setAttribute("teacherId", displayTeacherId);

    if (user == null || !"teacher".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teacher Home - Student Attendance Management System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background: url('edu.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
            height: 90vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            position: relative;
            overflow: hidden;

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.1);
            z-index: 1;
        }

        .container {
            position: relative;
            z-index: 2;
            background-color: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            text-align: center;
        }

        h2 {
            margin-bottom: 30px;
            font-weight: bold;
            color: #ffffff;
        }

        .btn {
            width: 200px;
            padding: 15px;
            border-radius: 25px;
            font-size: 1.2em;
            margin-top: 15px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            color: #ffffff;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background-color: #c82333;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Teacher Dashboard</h2>
        <div class="text-center">
            <a href="mark_attendance.jsp" class="btn btn-primary">Mark Attendance</a>
        </div>
        <div class="text-center">
            <a href="view_attendance.jsp" class="btn btn-primary">View Attendance</a>
        </div>
        <div class="text-center">
            <a href="index.jsp" class="btn btn-danger">Logout</a>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
