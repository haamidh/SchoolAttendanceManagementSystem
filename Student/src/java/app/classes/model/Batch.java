package app.classes.model;

public class Batch {
    private String batchId;
    private String batchName;
    private int year; // Added year field

    // Getters and Setters

    public Batch() {
    }

    public Batch(String batchId, String batchName, int year) {
        this.batchId = batchId;
        this.batchName = batchName;
        this.year = year;
    }

    public String getBatchId() {
        return batchId;
    }

    public void setBatchId(String batchId) {
        this.batchId = batchId;
    }

    public String getBatchName() {
        return batchName;
    }

    public void setBatchName(String batchName) {
        this.batchName = batchName;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }
}
