<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="app.classes.dao.*" %>
<%@ page import="app.classes.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");

    String displayTeacherId = (String) session.getAttribute("teacherId");
    session.setAttribute("teacherId", displayTeacherId);

    if (user == null || !"teacher".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    String message = "";
    String action = request.getParameter("action");
    if ("markAttendance".equals(action)) {
        String teacherId = request.getParameter("teacherId");
        String courseId = request.getParameter("courseId");
        String batchId = request.getParameter("batchId");
        String dateString = request.getParameter("date");
        String[] presentStudents = request.getParameterValues("present");

        if (teacherId != null && courseId != null && batchId != null && dateString != null && presentStudents != null) {
            try {
                java.sql.Date sqlDate = java.sql.Date.valueOf(dateString);

                AttendanceDAO attendanceDAO = new AttendanceDAO();
                for (String studentId : presentStudents) {
                    Attendance attendance = new Attendance();
                    attendance.setAttendanceId(java.util.UUID.randomUUID().toString());
                    attendance.setTeacherId(teacherId);
                    attendance.setStudentId(studentId);
                    attendance.setCourseId(courseId);
                    attendance.setBatchId(batchId);
                    attendance.setDate(sqlDate);
                    attendance.setStatus("Present");
                    attendanceDAO.markAttendance(attendance);
                }

                message = "Attendance marked successfully!";
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Attendance marked successfully!'); window.location.href='mark_attendance.jsp';</script>");
                return;
            } catch (Exception e) {
                message = "Error marking attendance: " + e.getMessage();
            }
        } else {
            message = "Please fill all fields and mark attendance for all students.";
        }
    }

    // Fetch necessary data for display
    TeacherDAO teacherDAO = new TeacherDAO();
    List<Teacher> teachers = teacherDAO.getAllTeachers();

    CourseDAO courseDAO = new CourseDAO();
    List<Course> courses = courseDAO.getAllCourses();
    String displayCourseName = courseDAO.displayCourseName(displayTeacherId);
    String displayCourseId = courseDAO.displayCourseId(displayTeacherId);


    BatchDAO batchDAO = new BatchDAO();
    List<Batch> batches = batchDAO.getAllBatches();

    List<Student> students = new ArrayList<Student>();
    String selectedCourseId = request.getParameter("courseId");
    if (selectedCourseId != null && !selectedCourseId.isEmpty()) {
        StudentDAO studentDAO = new StudentDAO();
        students = studentDAO.getStudentsByCourse(selectedCourseId);
    }
%>

<%
    if ("markAttendance".equals(action)) {
        String teacherId = request.getParameter("teacherId");
        String courseId = request.getParameter("courseId");
        String batchId = request.getParameter("batchId");
        String dateString = request.getParameter("date");
        String[] presentStudents = request.getParameterValues("present");

        if (teacherId != null && courseId != null && batchId != null && dateString != null && presentStudents != null) {
            try {
                java.sql.Date sqlDate = java.sql.Date.valueOf(dateString);

                AttendanceDAO attendanceDAO = new AttendanceDAO();
                String attendanceId = attendanceDAO.generateNextAttendanceId();

                for (String studentId : presentStudents) {
                    Attendance attendance = new Attendance();
                    attendance.setAttendanceId(attendanceId);
                    attendance.setTeacherId(teacherId);
                    attendance.setStudentId(studentId);
                    attendance.setCourseId(courseId);
                    attendance.setBatchId(batchId);
                    attendance.setDate(sqlDate);
                    attendance.setStatus("Present");
                    attendanceDAO.markAttendance(attendance);

                    // Update ID for next student
                    attendanceId = attendanceDAO.generateNextAttendanceId();
                }

                message = "Attendance marked successfully!";
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Attendance marked successfully!'); window.location.href='mark_attendance.jsp';</script>");
                return;
            } catch (Exception e) {
                message = "Error marking attendance: " + e.getMessage();
            }
        } else {
            message = "Please fill all fields and mark attendance for all students.";
        }
    }
%>



<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mark Attendance</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <script>
            function updateStudents() {
                document.getElementById('attendanceForm').submit();
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Mark Attendance</h2>
            <form id="attendanceForm" action="mark_attendance.jsp" method="post">
                <input type="hidden" name="action" value="markAttendance">

                <div class="form-group">
                    <label for="teacherId">Teacher ID:</label>
                    <select class="form-control" id="teacherId" name="teacherId" required>
                        <option value="">Select Teacher</option>
                        <% for (Teacher teacher : teachers) {%>
                        <option value="<%= teacher.getTeacherId()%>" <%= teacher.getTeacherId().equals(user.getUserId()) ? "selected" : ""%>><%= teacher.getTeacherId()%> - <%= teacher.getTeacherName()%></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="courseId">Course:</label>
                    <select class="form-control" id="courseId" name="courseId" onchange="updateStudents()" required>
                        <option value="">Select Course</option>
                        <% for (Course course : courses) {%>
                        <option value="<%= course.getCourseId()%>" <%= course.getCourseId().equals(selectedCourseId) ? "selected" : ""%>><%= course.getCourseName()%></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="batchId">Batch:</label>
                    <select class="form-control" id="batchId" name="batchId" required>
                        <option value="">Select Batch</option>
                        <% for (Batch batch : batches) {%>
                        <option value="<%= batch.getBatchId()%>"><%= batch.getBatchName()%></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="date">Date:</label>
                    <input type="date" class="form-control" id="date" name="date" required>
                </div>

                <% if (students.size() > 0) { %>
                <h4>Students</h4>
                <% for (Student student : students) {%>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="present" value="<%= student.getStudentId()%>">
                    <label class="form-check-label" for="present"><%= student.getStudentId()%> - <%= student.getStudentName()%></label>
                </div>
                <% } %>
                <% } %>

                <button type="submit" class="btn btn-primary mt-3">Submit</button>
                <button type="reset" class="btn btn-secondary mt-3">Reset</button>

                <% if (!message.isEmpty()) {%>
                <p class="text-danger mt-3"><%= message%></p>
                <% }%>
            </form>
            <a href="teacher_home.jsp" class="btn btn-secondary mt-3">Back</a>
        </div>
    </body>
</html>