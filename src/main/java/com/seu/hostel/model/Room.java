package com.seu.hostel.model;

import java.util.ArrayList;
import java.util.List;

public class Room {
    private int id;
    private String roomNumber;
    private int capacity;
    private String status; // VACANT or OCCUPIED
    private int filled;
    private int remaining;
    private List<User> allocations = new ArrayList<>();


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getFilled() {
        return filled;
    }

    public void setFilled(int filled) {
        this.filled = filled;
    }

    public int getRemaining() {
        return remaining;
    }

    public void setRemaining(int remaining) {
        this.remaining = remaining;
    }

    public List<User> getAllocations() {
        return allocations;
    }

    public void setAllocations(List<User> allocations) {
        this.allocations = allocations;
    }
}
