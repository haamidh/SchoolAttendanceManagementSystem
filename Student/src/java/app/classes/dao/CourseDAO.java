package app.classes.dao;

import app.classes.model.Course;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT * FROM courses";

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getString("course_id"));
                course.setCourseName(rs.getString("course_name"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    public String displayCourseName(String teacherId) {
        String query = "SELECT c.course_name\n"
                + "FROM courses c\n"
                + "JOIN teachers t ON c.course_id = t.course_id\n"
                + "WHERE t.teacher_id = ?";
        String courseName = null;

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, teacherId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {  // Move to the first result
                courseName = rs.getString("course_name");  // Retrieve the teacher_id from the ResultSet
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courseName;  // Return the teacher_id (or null if not found)
    }
    
    public String displayCourseId(String teacherId) {
        String query = "SELECT course_id FROM teachers WHERE teacher_id = ?";
        String courseId = null;

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, teacherId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {  // Move to the first result
                courseId = rs.getString("course_id");  // Retrieve the teacher_id from the ResultSet
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courseId;  // Return the teacher_id (or null if not found)
    }

    public void addCourse(Course course) {
        String query = "INSERT INTO courses (course_id, course_name) VALUES (?, ?)";

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, course.getCourseId());
            stmt.setString(2, course.getCourseName());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCourse(String courseId) {
        String query = "DELETE FROM courses WHERE course_id = ?";

        try (Connection conn = DbConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, courseId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Course> getCoursesByTeacher(String teacherId) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.course_id, c.course_name "
                     + "FROM courses c "
                     + "JOIN teachers t ON c.course_id = t.course_id "
                     + "WHERE t.teacher_id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, teacherId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setCourseId(rs.getString("course_id"));
                    course.setCourseName(rs.getString("course_name"));
                    courses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
}
