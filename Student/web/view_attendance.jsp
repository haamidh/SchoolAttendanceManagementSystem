<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="app.classes.dao.*" %>
<%@ page import="app.classes.model.*" %>
<%
    // Check if the user is an admin
    User user = (User) session.getAttribute("user");
    String displayTeacherId = (String) session.getAttribute("teacherId");
    session.setAttribute("teacherId", displayTeacherId);
    
    if (user == null || !"teacher".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Fetch all attendance records
    AttendanceDAO attendanceDAO = new AttendanceDAO();
    //List<Attendance> attendanceList = attendanceDAO.getAllAttendance();
    List<Attendance> attendanceList = attendanceDAO.getAttendanceByTeacherId(displayTeacherId);

    String message = "";
    if (attendanceList.isEmpty()) {
        message = "No previous attendance records available.";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Attendance - Admin</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 20px;
        }
        .table thead th {
            background-color: #343a40;
            color: #fff;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f2f2f2;
        }
        .text-center {
            margin-top: 20px;
        }
        .btn-secondary {
            margin-top: 20px;
        }
        .card {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <h2 class="text-center">View Attendance</h2>
        </div>
        <div class="card-body">
            
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    
                    
                    <th>Student ID</th>
                    <th>Batch ID</th>
                    <th>Course ID</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <% if (!message.isEmpty()) { %>
                    <tr>
                        <td colspan="7" class="text-center"><%= message %></td>
                    </tr>
                <% } else { %>
                    <% for (Attendance attendance : attendanceList) { %>
                        <tr>
                            
                            
                            <td><%= attendance.getStudentId() %></td>
                            <td><%= attendance.getBatchId() %></td>
                            <td><%= attendance.getCourseId() %></td>
                            <td><%= attendance.getDate() %></td>
                            <td><%= attendance.getStatus() %></td>
                        </tr>
                    <% } %>
                <% } %>
                </tbody>
            </table>
            <a href="admin_home.jsp" class="btn btn-secondary">Back</a>
        </div>
    </div>
</div>
</body>
</html>
