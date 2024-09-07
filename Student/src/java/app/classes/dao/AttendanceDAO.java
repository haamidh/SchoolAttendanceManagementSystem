package app.classes.dao;

import app.classes.model.Attendance;
import app.classes.model.Student;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AttendanceDAO {

    // Method to generate the next attendance ID in the format A001, A002, etc.
    public String generateNextAttendanceId() throws SQLException {
        String sql = "SELECT attendance_id FROM attendance ORDER BY attendance_id DESC LIMIT 1";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                String lastId = resultSet.getString("attendance_id");
                int numericPart = Integer.parseInt(lastId.substring(1));
                int nextId = numericPart + 1;
                return String.format("A%03d", nextId);
            } else {
                return "A001";
            }
        }
    }

    // Method to mark attendance
    public void markAttendance(Attendance attendance) {
        String sql = "INSERT INTO attendance (attendance_id, teacher_id, student_id, batch_id, course_id, date, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, attendance.getAttendanceId());
            statement.setString(2, attendance.getTeacherId());
            statement.setString(3, attendance.getStudentId());
            statement.setString(4, attendance.getBatchId());
            statement.setString(5, attendance.getCourseId());
            statement.setDate(6, new java.sql.Date(attendance.getDate().getTime()));
            statement.setString(7, attendance.getStatus());

            statement.executeUpdate();
        } catch (SQLException e) {
            // Log the exception to a file or console
            System.err.println("Error marking attendance: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Method to retrieve all attendance records
    public List<Attendance> getAllAttendance() {
        List<Attendance> attendanceList = new ArrayList<>();
        String query = "SELECT * FROM attendance";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Attendance attendance = new Attendance();
                attendance.setAttendanceId(rs.getString("attendance_id"));
                attendance.setTeacherId(rs.getString("teacher_id"));
                attendance.setStudentId(rs.getString("student_id"));
                attendance.setBatchId(rs.getString("batch_id"));
                attendance.setCourseId(rs.getString("course_id"));
                attendance.setDate(rs.getDate("date"));
                attendance.setStatus(rs.getString("status"));
                attendanceList.add(attendance);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceList;
    }

    // Method to update an attendance record
    public void updateAttendance(Attendance attendance) {
        String query = "UPDATE attendance SET teacher_id = ?, student_id = ?, batch_id = ?, course_id = ?, date = ?, status = ? WHERE attendance_id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, attendance.getTeacherId());
            stmt.setString(2, attendance.getStudentId());
            stmt.setString(3, attendance.getBatchId());
            stmt.setString(4, attendance.getCourseId());
            stmt.setDate(5, new java.sql.Date(attendance.getDate().getTime()));
            stmt.setString(6, attendance.getStatus());
            stmt.setString(7, attendance.getAttendanceId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete an attendance record by ID
    public void deleteAttendance(String attendanceId) {
        String query = "DELETE FROM attendance WHERE attendance_id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, attendanceId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to get students by course ID
    public List<Student> getStudentsByCourse(String courseId) {
        List<Student> students = new ArrayList<>();
        String query = "SELECT s.* FROM student s JOIN course_student cs ON s.student_id = cs.student_id WHERE cs.course_id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student();
                    student.setStudentId(rs.getString("student_id"));
                    student.setStudentName(rs.getString("student_name"));
                    student.setBatchId(rs.getString("batch_id"));
                    students.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // Method to get attendance records by date and course ID
    public List<Attendance> getAttendanceByDateAndCourse(String date, String courseId) {
        List<Attendance> attendanceList = new ArrayList<>();
        String query = "SELECT * FROM attendance WHERE date = ? AND course_id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, date);
            stmt.setString(2, courseId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Attendance attendance = new Attendance();
                attendance.setAttendanceId(rs.getString("attendance_id"));
                attendance.setTeacherId(rs.getString("teacher_id"));
                attendance.setStudentId(rs.getString("student_id"));
                attendance.setBatchId(rs.getString("batch_id"));
                attendance.setCourseId(rs.getString("course_id"));
                attendance.setDate(rs.getDate("date"));
                attendance.setStatus(rs.getString("status"));
                attendanceList.add(attendance);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceList;
    }
    
    public List<Attendance> getAttendanceByTeacherId(String displayTeacherId) {
        List<Attendance> attendanceList = new ArrayList<>();
        try {
            
            
            
            Connection conn = DbConnector.getConnection();
            String query = "SELECT * FROM attendance WHERE teacher_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, displayTeacherId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Attendance attendance = new Attendance();
                attendance.setAttendanceId(rs.getString("attendance_id"));
                attendance.setTeacherId(rs.getString("teacher_id"));
                attendance.setStudentId(rs.getString("student_id"));
                attendance.setBatchId(rs.getString("batch_id"));
                attendance.setCourseId(rs.getString("course_id"));
                attendance.setDate(rs.getDate("date"));
                attendance.setStatus(rs.getString("status"));
                attendanceList.add(attendance);
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attendanceList;
    }

    // Method to clear attendance records for a given date, teacher, course, and batch
    public void clearAttendance(String teacherId, String courseId, String batchId, Date date) throws SQLException {
        String sql = "DELETE FROM attendance WHERE teacher_id = ? AND course_id = ? AND batch_id = ? AND date = ?";
        try (Connection connection = DbConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, teacherId);
            statement.setString(2, courseId);
            statement.setString(3, batchId);
            statement.setDate(4, date);
            statement.executeUpdate();
        }
    }
}
