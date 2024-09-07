package app.classes.dao;

import app.classes.model.Teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {

    public List<Teacher> getAllTeachers() {
        List<Teacher> teachers = new ArrayList<>();
        String query = "SELECT * FROM teachers";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setTeacherId(rs.getString("teacher_id"));
                teacher.setTeacherName(rs.getString("teacher_name"));
                teacher.setUsername(rs.getString("username"));
                teacher.setPassword(rs.getString("password"));
                teacher.setCourseId(rs.getString("course_id"));
                teachers.add(teacher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }

    public void addTeacher(Teacher teacher) {
        String query = "INSERT INTO teachers (teacher_id, teacher_name, username, password, course_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, teacher.getTeacherId());
            stmt.setString(2, teacher.getTeacherName());
            stmt.setString(3, teacher.getUsername());
            stmt.setString(4, teacher.getPassword());
            stmt.setString(5, teacher.getCourseId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTeacher(String teacherId) {
        String query = "DELETE FROM teachers WHERE teacher_id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, teacherId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateTeacher(Teacher teacher) {
        String query = "UPDATE teachers SET teacher_name = ?, username = ?, password = ?, course_id = ? WHERE teacher_id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, teacher.getTeacherName());
            stmt.setString(2, teacher.getUsername());
            stmt.setString(3, teacher.getPassword());
            stmt.setString(4, teacher.getCourseId());
            stmt.setString(5, teacher.getTeacherId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public String displayTeacherId(String username) {
    String query = "SELECT teacher_id FROM teachers WHERE username = ?";
    String teacherId = null;

    try (Connection conn = DbConnector.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {
        
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {  // Move to the first result
            teacherId = rs.getString("teacher_id");  // Retrieve the teacher_id from the ResultSet
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return teacherId;  // Return the teacher_id (or null if not found)
}

}
