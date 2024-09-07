package app.classes.dao;

import app.classes.model.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String query = "SELECT * FROM students";

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Student student = new Student();
                student.setStudentId(rs.getString("student_id"));
                student.setStudentName(rs.getString("student_name"));
                student.setBatchId(rs.getString("batch_id"));
                student.setCourseId(rs.getString("course_id"));
                student.setAddress(rs.getString("address"));
                student.setPhoneNumber(rs.getString("phone_number"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public void addStudent(Student student) {
        String query = "INSERT INTO students (student_id, student_name, batch_id, course_id, address, phone_number) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, student.getStudentId());
            stmt.setString(2, student.getStudentName());
            stmt.setString(3, student.getBatchId());
            stmt.setString(4, student.getCourseId());
            stmt.setString(5, student.getAddress());
            stmt.setString(6, student.getPhoneNumber());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteStudent(String studentId) {
        String query = "DELETE FROM students WHERE student_id = ?";

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, studentId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateStudent(Student student) {
        String query = "UPDATE students SET student_name = ?, batch_id = ?, course_id = ?, address = ?, phone_number = ? WHERE student_id = ?";

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, student.getStudentName());
            stmt.setString(2, student.getBatchId());
            stmt.setString(3, student.getCourseId());
            stmt.setString(4, student.getAddress());
            stmt.setString(5, student.getPhoneNumber());
            stmt.setString(6, student.getStudentId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Student> getStudentsByCourse(String courseId) {
        List<Student> students = new ArrayList<>();
        String query = "SELECT s.student_id, s.student_name FROM students s JOIN course_students cs ON s.student_id = cs.student_id WHERE cs.course_id = ?";

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student();
                    student.setStudentId(rs.getString("student_id"));
                    student.setStudentName(rs.getString("student_name"));
                    students.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
    
    public List<Student> getStudentsByCourseAndBatch(String courseId, String batchId) {
        List<Student> students = new ArrayList<>();
        String query = "SELECT s.student_id, s.student_name "
                     + "FROM students s "
                     + "WHERE s.course_id = ? AND s.batch_id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, courseId);
            stmt.setString(2, batchId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student();
                    student.setStudentId(rs.getString("student_id"));
                    student.setStudentName(rs.getString("student_name"));
                    students.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
}
