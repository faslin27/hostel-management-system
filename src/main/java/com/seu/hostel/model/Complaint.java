package com.seu.hostel.model;

import java.time.LocalDateTime;

public class Complaint {
    private int id;
    private String title;
    private String description;
    private String status;
    private int createdBy;
    private String createdByName;
    private String createdByRegNo;
    private LocalDateTime createdAt;
    private String note;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }

    public String getCreatedByName() { return createdByName; }
    public void setCreatedByName(String createdByName) { this.createdByName = createdByName; }

    public String getCreatedByRegNo() { return createdByRegNo; }
    public void setCreatedByRegNo(String createdByRegNo) { this.createdByRegNo = createdByRegNo; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Complaint{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                ", createdBy=" + createdBy +
                ", createdByName='" + createdByName + '\'' +
                ", createdByRegNo='" + createdByRegNo + '\'' +
                ", createdAt=" + createdAt +
                ", note='" + note + '\'' +
                '}';
    }
}
