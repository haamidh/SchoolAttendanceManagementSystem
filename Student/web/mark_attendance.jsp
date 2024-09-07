<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.Date"%>
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
        String[] absentStudents = request.getParameterValues("absent");

        if (teacherId != null && courseId != null && batchId != null && dateString != null) {
            try {
                Date sqlDate = Date.valueOf(dateString);
                AttendanceDAO attendanceDAO = new AttendanceDAO();

                // Clear previous attendance records for the selected date
                //attendanceDAO.clearAttendance(teacherId, courseId, batchId, sqlDate);

                // Mark Present Students
                if (presentStudents != null && presentStudents.length > 0) {
                    for (String studentId : presentStudents) {
                        //String attendanceId = attendanceDAO.generateNextAttendanceId();
                        Attendance attendance = new Attendance();
                        //attendance.setAttendanceId(attendanceId);
                        attendance.setAttendanceId(java.util.UUID.randomUUID().toString());
                        attendance.setTeacherId(teacherId);
                        attendance.setStudentId(studentId);
                        attendance.setCourseId(courseId);
                        attendance.setBatchId(batchId);
                        attendance.setDate(sqlDate);
                        attendance.setStatus("Present");
                        attendanceDAO.markAttendance(attendance);
                    }
                }

                // Mark Absent Students
                if (absentStudents != null && absentStudents.length > 0) {
                    for (String studentId : absentStudents) {
                        //String attendanceId = attendanceDAO.generateNextAttendanceId();
                        Attendance attendance = new Attendance();
                        //attendance.setAttendanceId(attendanceId);
                        attendance.setAttendanceId(java.util.UUID.randomUUID().toString());
                        attendance.setTeacherId(teacherId);
                        attendance.setStudentId(studentId);
                        attendance.setCourseId(courseId);
                        attendance.setBatchId(batchId);
                        attendance.setDate(sqlDate);
                        attendance.setStatus("Absent");
                        attendanceDAO.markAttendance(attendance);
                    }
                }

                message = "Attendance marked successfully!";
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Attendance marked successfully!'); window.location.href='mark_attendance.jsp';</script>");
                return;
            } catch (Exception e) {
                message = "Error marking attendance: " + e.getMessage();
            }
        } else {
            message = "Please fill all fields and mark attendance for at least one student.";
        }
    }

    // Fetch necessary data for display
    TeacherDAO teacherDAO = new TeacherDAO();
    CourseDAO courseDAO = new CourseDAO();
    String displayCourseName = courseDAO.displayCourseName(displayTeacherId);
    String displayCourseId = courseDAO.displayCourseId(displayTeacherId);

    BatchDAO batchDAO = new BatchDAO();
    List batches = batchDAO.getAllBatches();

    List students = new ArrayList();
    String selectedCourseId = request.getParameter("courseId");
    String selectedBatchId = request.getParameter("batchId");
    if (selectedCourseId != null && !selectedCourseId.isEmpty() && selectedBatchId != null && !selectedBatchId.isEmpty()) {
        StudentDAO studentDAO = new StudentDAO();
        students = studentDAO.getStudentsByCourseAndBatch(selectedCourseId, selectedBatchId);
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
            <input type="text" class="form-control" id="teacherId" name="teacherId" value="<%= displayTeacherId %>" readonly required>
        </div>

        <div class="form-group">
            <label for="courseId">Course:</label>
            <select class="form-control" id="courseId" name="courseId" onchange="updateStudents()" required>
                <option value="">Select Course</option>
                <option value="<%= displayCourseId %>" <%= displayCourseId.equals(selectedCourseId) ? "selected" : "" %>><%= displayCourseName %></option>
            </select>
        </div>

        <div class="form-group">
            <label for="batchId">Batch:</label>
            <select class="form-control" id="batchId" name="batchId" onchange="updateStudents()" required>
                <option value="">Select Batch</option>
                <% for (int i = 0; i < batches.size(); i++) { 
                    Batch batch = (Batch) batches.get(i);
                %>
                    <option value="<%= batch.getBatchId() %>" <%= batch.getBatchId().equals(selectedBatchId) ? "selected" : "" %>><%= batch.getBatchName() %></option>
                <% } %>
            </select>
        </div>

        <div class="form-group">
            <label for="date">Date:</label>
            <input type="date" class="form-control" id="date" name="date" required>
        </div>

        <% if (!students.isEmpty()) { %>
            <h4>Students</h4>
            <% for (int i = 0; i < students.size(); i++) { 
                Student student = (Student) students.get(i);
                String studentId = student.getStudentId();
            %>
                <div class="form-check mt-2 container">
                    <div class="row">
                    <div class="col">
                    <input class="form-check-input" type="checkbox" name="present" value="<%= student.getStudentId() %>">
                    <label class="form-check-label" for="present"><%= student.getStudentId() %> - <%= student.getStudentName() %> - Present</label>
                </div><div class="col">
                    <input class="form-check-input" type="checkbox" name="absent" value="<%= student.getStudentId() %>">
                    <label class="form-check-label" for="present"><%= student.getStudentId() %> - <%= student.getStudentName() %> - Absent</label>
                </div></div></div>
            <% } %>
        <% } else if (selectedCourseId != null && !selectedCourseId.isEmpty()) { %>
            <p>No students found for this course and batch.</p>
        <% } %>

        <button type="submit" class="btn btn-primary mt-3">Submit</button>
        <button type="reset" class="btn btn-secondary mt-3">Reset</button>
        
        <% if (!message.isEmpty()) { %>
            <p class="text-danger mt-3"><%= message %></p>
        <% } %>
    </form>
</div>
</body>
</html>
