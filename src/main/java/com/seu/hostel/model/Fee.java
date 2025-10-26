package com.seu.hostel.model;

import java.time.LocalDateTime;

public class Fee {
    private int id;
    private int studentId;
    private int studentName;
    private int feeYear;
    private String period; // FIRST_HALF / SECOND_HALF
    private String status;
    private LocalDateTime paidAt;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public int getFeeYear() { return feeYear; }
    public void setFeeYear(int feeYear) { this.feeYear = feeYear; }
    public String getPeriod() { return period; }
    public void setPeriod(String period) { this.period = period; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDateTime getPaidAt() { return paidAt; }
    public void setPaidAt(LocalDateTime paidAt) { this.paidAt = paidAt; }

    public int getStudentName() {
        return studentName;
    }

    public void setStudentName(int studentName) {
        this.studentName = studentName;
    }
}
