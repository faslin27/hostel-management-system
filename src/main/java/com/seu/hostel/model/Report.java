package com.seu.hostel.model;

public class Report {
    private int totalRooms;
    private int totalStudents;
    private int occupiedBeds;
    private int availableBeds;
    private int pendingFees;
    private int paidFees;
    private int complaintsPending;
    private int complaintsResolved;
    private int visitorCount;

    // getters & setters
    public int getTotalRooms() { return totalRooms; }
    public void setTotalRooms(int totalRooms) { this.totalRooms = totalRooms; }
    public int getTotalStudents() { return totalStudents; }
    public void setTotalStudents(int totalStudents) { this.totalStudents = totalStudents; }
    public int getOccupiedBeds() { return occupiedBeds; }
    public void setOccupiedBeds(int occupiedBeds) { this.occupiedBeds = occupiedBeds; }
    public int getAvailableBeds() { return availableBeds; }
    public void setAvailableBeds(int availableBeds) { this.availableBeds = availableBeds; }
    public int getPendingFees() { return pendingFees; }
    public void setPendingFees(int pendingFees) { this.pendingFees = pendingFees; }
    public int getPaidFees() { return paidFees; }
    public void setPaidFees(int paidFees) { this.paidFees = paidFees; }
    public int getComplaintsPending() { return complaintsPending; }
    public void setComplaintsPending(int complaintsPending) { this.complaintsPending = complaintsPending; }
    public int getComplaintsResolved() { return complaintsResolved; }
    public void setComplaintsResolved(int complaintsResolved) { this.complaintsResolved = complaintsResolved; }
    public int getVisitorCount() { return visitorCount; }
    public void setVisitorCount(int visitorCount) { this.visitorCount = visitorCount; }
}
