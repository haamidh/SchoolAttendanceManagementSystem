package app.classes.model;

public class Student {
    private String studentId;
    private String studentName;
    private String batchId;
    private String courseId;
    private String address;
    private String phoneNumber;

    // Getters and Setters

    public Student() {
    }

    public Student(String studentId, String studentName, String batchId, String courseId, String address, String phoneNumber) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.batchId = batchId;
        this.courseId = courseId;
        this.address = address;
        this.phoneNumber = phoneNumber;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
}
