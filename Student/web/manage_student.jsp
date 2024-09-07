<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="app.classes.dao.StudentDAO" %>
<%@ page import="app.classes.model.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Students - Student Attendance Management System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background-color: #f0f4f7;
            font-family: 'Arial', sans-serif;
            color: #333;
        }
        .container {
            max-width: 900px;
            margin-top: 50px;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }
        h2 {
            margin-bottom: 30px;
            font-weight: bold;
            color: #5c7cfa;
            text-align: center;
        }
        .form-inline .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            border-radius: 25px;
            padding: 10px 15px;
            border: 1px solid #ced4da;
        }
        .btn-primary, .btn-warning, .btn-danger {
            border-radius: 25px;
            padding: 10px 20px;
            transition: background-color 0.3s ease;
        }
        .btn-primary {
            background-color: #5c7cfa;
            border: none;
        }
        .btn-primary:hover {
            background-color: #3b5bdb;
        }
        .btn-warning {
            background-color: #f39c12;
            border: none;
        }
        .btn-warning:hover {
            background-color: #e67e22;
        }
        .btn-danger {
            background-color: #e74c3c;
            border: none;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
        table {
            margin-top: 30px;
        }
        th {
            background-color: #5c7cfa;
            color: #fff;
        }
        td {
            vertical-align: middle;
        }
        .modal-content {
            border-radius: 10px;
        }
        .modal-header {
            background-color: #5c7cfa;
            color: #fff;
        }
        .text-center a {
            border-radius: 25px;
            padding: 10px 20px;
            background-color: #6c757d;
            color: #fff;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .text-center a:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="box">
        <h2>Manage Students</h2>
        <%
            String action = request.getParameter("action");
            StudentDAO studentDAO = new StudentDAO();

            if ("addStudent".equals(action)) {
                String studentId = request.getParameter("studentId");
                String studentName = request.getParameter("studentName");
                String batchId = request.getParameter("batchId");
                String courseId = request.getParameter("courseId");
                String address = request.getParameter("address");
                String phoneNumber = request.getParameter("phoneNumber");
                if (studentId != null && studentName != null && batchId != null && courseId != null && address != null && phoneNumber != null) {
                    Student student = new Student(studentId, studentName, batchId, courseId, address, phoneNumber);
                    studentDAO.addStudent(student);
                }
            } else if ("deleteStudent".equals(action)) {
                String studentId = request.getParameter("studentId");
                if (studentId != null) {
                    studentDAO.deleteStudent(studentId);
                }
            } else if ("editStudent".equals(action)) {
                String studentId = request.getParameter("studentId");
                String studentName = request.getParameter("studentName");
                String batchId = request.getParameter("batchId");
                String courseId = request.getParameter("courseId");
                String address = request.getParameter("address");
                String phoneNumber = request.getParameter("phoneNumber");
                if (studentId != null && studentName != null && batchId != null && courseId != null && address != null && phoneNumber != null) {
                    Student student = new Student(studentId, studentName, batchId, courseId, address, phoneNumber);
                    studentDAO.updateStudent(student);
                }
            }

            List<Student> students = studentDAO.getAllStudents();
        %>
        <form action="manage_student.jsp" method="post" class="form-inline justify-content-center">
            <input type="hidden" name="action" value="addStudent">
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="studentId" name="studentId" placeholder="Student ID" required>
            </div>
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="studentName" name="studentName" placeholder="Student Name" required>
            </div>
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="batchId" name="batchId" placeholder="Batch ID" required>
            </div>
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="courseId" name="courseId" placeholder="Course ID" required>
            </div>
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="address" name="address" placeholder="Address" required>
            </div>
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Phone Number" required>
            </div>
            <button type="submit" class="btn btn-primary mx-sm-2">Add Student</button>
        </form>
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Batch ID</th>
                    <th>Course ID</th>
                    <th>Address</th>
                    <th>Phone Number</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Student student : students) {
                %>
                <tr>
                    <td><%= student.getStudentId() %></td>
                    <td><%= student.getStudentName() %></td>
                    <td><%= student.getBatchId() %></td>
                    <td><%= student.getCourseId() %></td>
                    <td><%= student.getAddress() %></td>
                    <td><%= student.getPhoneNumber() %></td>
                    <td>
                        <div class="btn-group" role="group" aria-label="Student Actions">
                            <form action="manage_student.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="deleteStudent">
                                <input type="hidden" name="studentId" value="<%= student.getStudentId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                            <button type="button" class="btn btn-warning btn-sm ml-2" data-toggle="modal" data-target="#editStudentModal<%= student.getStudentId() %>">Edit</button>
                        </div>

                        <!-- Edit Student Modal -->
                        <div class="modal fade" id="editStudentModal<%= student.getStudentId() %>" tabindex="-1" role="dialog" aria-labelledby="editStudentModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editStudentModalLabel">Edit Student</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="manage_student.jsp" method="post">
                                            <input type="hidden" name="action" value="editStudent">
                                            <input type="hidden" name="studentId" value="<%= student.getStudentId() %>">
                                            <div class="form-group">
                                                <label for="studentName">Student Name</label>
                                                <input type="text" class="form-control" id="studentName" name="studentName" value="<%= student.getStudentName() %>" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="batchId">Batch ID</label>
                                                <input type="text" class="form-control" id="batchId" name="batchId" value="<%= student.getBatchId() %>" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="courseId">Course ID</label>
                                                <input type="text" class="form-control" id="courseId" name="courseId" value="<%= student.getCourseId() %>" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="address">Address</label>
                                                <input type="text" class="form-control" id="address" name="address" value="<%= student.getAddress() %>" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="phoneNumber">Phone Number</label>
                                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="<%= student.getPhoneNumber() %>" required>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Save changes</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <div class="text-center">
            <a href="admin_home.jsp">Back to Dashboard</a>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
