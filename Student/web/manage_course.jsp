<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="app.classes.dao.CourseDAO" %>
<%@ page import="app.classes.model.Course" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Course - Student Attendance Management System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background-color: #f0f4f7;
            font-family: 'Arial', sans-serif;
            color: #333;
        }
        .container {
            max-width: 800px;
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
        .btn-primary {
            border-radius: 25px;
            padding: 10px 20px;
            background-color: #5c7cfa;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #3b5bdb;
        }
        .btn-danger {
            border-radius: 25px;
            padding: 5px 15px;
            transition: background-color 0.3s ease;
        }
        .btn-danger:hover {
            background-color: #e74c3c;
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
        <h2>Manage Courses</h2>
        <%
            String action = request.getParameter("action");
            if ("addCourse".equals(action)) {
                String courseId = request.getParameter("courseId");
                String courseName = request.getParameter("courseName");
                if (courseId != null && courseName != null) {
                    Course course = new Course();
                    course.setCourseId(courseId);
                    course.setCourseName(courseName);

                    CourseDAO courseDAO = new CourseDAO();
                    courseDAO.addCourse(course);
                }
            } else if ("deleteCourse".equals(action)) {
                String courseId = request.getParameter("courseId");
                if (courseId != null) {
                    CourseDAO courseDAO = new CourseDAO();
                    courseDAO.deleteCourse(courseId);
                }
            }

            CourseDAO courseDAO = new CourseDAO();
            List<Course> courses = courseDAO.getAllCourses();
        %>
        <form action="manage_course.jsp" method="post" class="form-inline justify-content-center">
            <input type="hidden" name="action" value="addCourse">
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="courseId" name="courseId" placeholder="Course ID" required>
            </div>
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="courseName" name="courseName" placeholder="Course Name" required>
            </div>
            <button type="submit" class="btn btn-primary mx-sm-2">Add Course</button>
        </form>
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>Course ID</th>
                    <th>Course Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Course course : courses) {
                %>
                <tr>
                    <td><%= course.getCourseId() %></td>
                    <td><%= course.getCourseName() %></td>
                    <td>
                        <form action="manage_course.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="deleteCourse">
                            <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
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
