<%@page import="java.util.List"%>
<%@ page import="app.classes.dao.*" %>
<%@ page import="app.classes.model.*" %>
<%
    // Check if the user is an admin
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Handling form submissions for adding/removing batches, courses, teachers, etc.
    String action = request.getParameter("action");
    if ("addBatch".equals(action)) {
        String batchName = request.getParameter("batchName");
        BatchDAO batchDAO = new BatchDAO();
        Batch batch = new Batch();
        batch.setBatchName(batchName);
        batchDAO.addBatch(batch);
    } else if ("removeBatch".equals(action)) {
        String batchId = request.getParameter("batchId");
        BatchDAO batchDAO = new BatchDAO();
        batchDAO.deleteBatch(batchId);
    } else if ("addCourse".equals(action)) {
        String courseName = request.getParameter("courseName");
        CourseDAO courseDAO = new CourseDAO();
        Course course = new Course();
        course.setCourseName(courseName);
        courseDAO.addCourse(course);
    } else if ("removeCourse".equals(action)) {
        String courseId = request.getParameter("courseId");
        CourseDAO courseDAO = new CourseDAO();
        courseDAO.deleteCourse(courseId);
    }
    // Similarly handle other actions

    // Fetch necessary data for display
    BatchDAO batchDAO = new BatchDAO();
    List<Batch> batches = batchDAO.getAllBatches();
    CourseDAO courseDAO = new CourseDAO();
    List<Course> courses = courseDAO.getAllCourses();
    TeacherDAO teacherDAO = new TeacherDAO();
    List<Teacher> teachers = teacherDAO.getAllTeachers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Home - Student Attendance Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: url('cam.jpg') no-repeat center center/cover;
            position: relative;
            overflow: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 1;
        }

        .container-fluid {
            position: relative;
            z-index: 2;
            padding: 0 15px;
        }

        .dashboard-title {
            position: relative;
            top: 20px;
            left: 20px;
            font-size: 2.5em;
            margin-bottom: 30px;
            color: #fff;
        }

        .logout-button {
            position: absolute;
            bottom: 20px;
            right: 20px;
        }

        .btn-block {
            height: 100px;
            font-size: 1.2em;
            text-align: center;
            margin-bottom: 15px;
        }

        @media (max-width: 768px) {
            .btn-block {
                height: 60px;
                font-size: 1em;
            }
            .dashboard-title {
                font-size: 2em;
                margin-bottom: 20px;
            }
            .logout-button {
                bottom: 10px;
                right: 10px;
            }
        }

        @media (max-width: 576px) {
            .btn-block {
                height: 50px;
                font-size: 0.9em;
            }
            .dashboard-title {
                font-size: 1.5em;
                margin-bottom: 15px;
                text-align: center;
            }
            .logout-button {
                position: static;
                width: 100%;
                margin-top: 10px;
            }
            .container-fluid {
                padding: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid d-flex flex-column vh-100">
        <div class="row">
            <div class="col-12">
                <h2 class="dashboard-title text-center">Admin Dashboard</h2>
            </div>
        </div>
        <div class="row flex-grow-1 justify-content-center align-items-center">
            <div class="col-12 col-md-6 col-lg-4">
                <a href="manage_batch.jsp" class="btn btn-dark btn-outline-light btn-block d-flex justify-content-center align-items-center">Manage Batch</a>
            </div>
            <div class="col-12 col-md-6 col-lg-4">
                <a href="manage_course.jsp" class="btn btn-dark btn-outline-light btn-block d-flex justify-content-center align-items-center">Manage Course</a>
            </div>
            <div class="col-12 col-md-6 col-lg-4">
                <a href="manage_teacher.jsp" class="btn btn-dark btn-outline-light btn-block d-flex justify-content-center align-items-center">Manage Teacher</a>
            </div>
            <div class="col-12 col-md-6 col-lg-4">
                <a href="manage_student.jsp" class="btn btn-dark btn-outline-light btn-block d-flex justify-content-center align-items-center">Manage Student</a>
            </div>
            <div class="col-12 col-md-6 col-lg-4">
                <a href="view_attendance_admin.jsp" class="btn btn-dark btn-outline-light btn-block d-flex justify-content-center align-items-center">Attendance Records</a>
            </div>
        </div>
        <div class="row">
            <div class="col-12 text-right">
                <a href="index.jsp" class="btn btn-danger logout-button">Logout</a>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
