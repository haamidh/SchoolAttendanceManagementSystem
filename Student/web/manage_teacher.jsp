<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="app.classes.dao.CourseDAO, app.classes.dao.TeacherDAO, app.classes.model.Course, app.classes.model.Teacher, java.util.List" %>
<%
    // Fetch necessary data for display
    CourseDAO courseDAO = new CourseDAO();
    List<Course> courses = courseDAO.getAllCourses();

    // Handling form submissions for adding/removing/editing teachers
    String action = request.getParameter("action");
    if ("addTeacher".equals(action)) {
        String teacherId = request.getParameter("teacherId");
        String teacherName = request.getParameter("teacherName");
        String courseId = request.getParameter("courseId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (teacherId != null && teacherName != null && username != null && password != null && courseId != null) {
            Teacher teacher = new Teacher();
            teacher.setTeacherId(teacherId);
            teacher.setTeacherName(teacherName);
            teacher.setUsername(username);
            teacher.setPassword(password);
            teacher.setCourseId(courseId);

            TeacherDAO teacherDAO = new TeacherDAO();
            teacherDAO.addTeacher(teacher);
        }
    } else if ("deleteTeacher".equals(action)) {
        String teacherId = request.getParameter("teacherId");
        if (teacherId != null) {
            TeacherDAO teacherDAO = new TeacherDAO();
            teacherDAO.deleteTeacher(teacherId);
        }
    } else if ("editTeacher".equals(action)) {
        String teacherId = request.getParameter("teacherId");
        String teacherName = request.getParameter("teacherName");
        String courseId = request.getParameter("courseId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (teacherId != null && teacherName != null && courseId != null && username != null && password != null) {
            Teacher teacher = new Teacher();
            teacher.setTeacherId(teacherId);
            teacher.setTeacherName(teacherName);
            teacher.setCourseId(courseId);
            teacher.setUsername(username);
            teacher.setPassword(password);

            TeacherDAO teacherDAO = new TeacherDAO();
            teacherDAO.updateTeacher(teacher);
        }
    }

    // Fetch all teachers for display
    TeacherDAO teacherDAO = new TeacherDAO();
    List<Teacher> teachers = teacherDAO.getAllTeachers();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Teachers - Student Attendance Management System</title>
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
            <h2 class="text-center">Manage Teachers</h2>
            <form action="manage_teacher.jsp" method="post" class="form-inline">
                <input type="hidden" name="action" value="addTeacher">
                <div class="form-group mx-sm-3 mb-2">
                    <label for="teacherId" class="sr-only">Teacher ID</label>
                    <input type="text" class="form-control" id="teacherId" name="teacherId" placeholder="Teacher ID" required>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="teacherName" class="sr-only">Teacher Name</label>
                    <input type="text" class="form-control" id="teacherName" name="teacherName" placeholder="Teacher Name" required>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <select class="form-control" id="courseId" name="courseId" required>
                        <option value="">Select Course</option>
                        <% for (Course course : courses) { %>
                        <option value="<%= course.getCourseId() %>"><%= course.getCourseName() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="username" class="sr-only">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="password" class="sr-only">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                </div>
                <button type="submit" class="btn btn-primary mb-2">Add Teacher</button>
            </form>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Teacher ID</th>
                        <th>Teacher Name</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Course</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Teacher teacher : teachers) { %>
                    <tr>
                        <td><%= teacher.getTeacherId() %></td>
                        <td><%= teacher.getTeacherName() %></td>
                        <td><%= teacher.getUsername() %></td>
                        <td><%= teacher.getPassword() %></td>
                        <td><%= teacher.getCourseId() %></td>
                        <td>
                            <form action="manage_teacher.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="deleteTeacher">
                                <input type="hidden" name="teacherId" value="<%= teacher.getTeacherId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                            <button type="button" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#editTeacherModal<%= teacher.getTeacherId() %>">Edit</button>

                            <!-- Edit Teacher Modal -->
                            <div class="modal fade" id="editTeacherModal<%= teacher.getTeacherId() %>" tabindex="-1" role="dialog" aria-labelledby="editTeacherModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editTeacherModalLabel">Edit Teacher</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="manage_teacher.jsp" method="post">
                                                <input type="hidden" name="action" value="editTeacher">
                                                <input type="hidden" name="teacherId" value="<%= teacher.getTeacherId() %>">
                                                <div class="form-group">
                                                    <label for="teacherName">Teacher Name</label>
                                                    <input type="text" class="form-control" id="teacherName" name="teacherName" value="<%= teacher.getTeacherName() %>" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="courseId">Course</label>
                                                    <select class="form-control" id="courseId" name="courseId" required>
                                                        <% for (Course course : courses) { %>
                                                        <option value="<%= course.getCourseId() %>" <%= teacher.getCourseId().equals(course.getCourseId()) ? "selected" : "" %>><%= course.getCourseName() %></option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="username">Username</label>
                                                    <input type="text" class="form-control" id="username" name="username" value="<%= teacher.getUsername() %>" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="password">Password</label>
                                                    <input type="password" class="form-control" id="password" name="password" value="<%= teacher.getPassword() %>" required>
                                                </div>
                                                <button type="submit" class="btn btn-warning">Save Changes</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <div class="text-center">
                <a href="admin_home.jsp">Back to Dashboard</a>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
