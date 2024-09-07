package app.classes.model;

public class Teacher {
    private String teacherId;
    private String teacherName;
    private String username;
    private String password;
    private String courseId;

    // Constructors, Getters, and Setters

    public Teacher() {
    }

    public Teacher(String teacherId, String teacherName, String username, String password, String courseId) {
        this.teacherId = teacherId;
        this.teacherName = teacherName;
        this.username = username;
        this.password = password;
        this.courseId = courseId;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }
}
