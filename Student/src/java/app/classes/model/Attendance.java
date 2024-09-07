package app.classes.model;

import java.util.Date;

public class Attendance {
    private String attendanceId;
    private String teacherId;
    private String studentId;
    private String batchId;
    private String courseId;
    private Date date;
    private String status;

    // Getters and Setters

    public Attendance() {
    }

    public Attendance(String attendanceId, String teacherId, String studentId, String batchId, String courseId, Date date, String status) {
        this.attendanceId = attendanceId;
        this.teacherId = teacherId;
        this.studentId = studentId;
        this.batchId = batchId;
        this.courseId = courseId;
        this.date = date;
        this.status = status;
    }

    public String getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(String attendanceId) {
        this.attendanceId = attendanceId;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getBatchId() {
        return batchId;
    }

    public void setBatchId(String batchId) {
        this.batchId = batchId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAttendanceDate() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
