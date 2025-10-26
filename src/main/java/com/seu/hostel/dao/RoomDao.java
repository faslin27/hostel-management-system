package com.seu.hostel.dao;

import com.seu.hostel.model.Room;
import com.seu.hostel.model.RoomAllocation;
import com.seu.hostel.model.User;

import java.util.List;

public interface RoomDao {
    List<Room> findAll();
    Room findById(int id);
    void add(Room room);
    void update(Room room);
    void updateStatus(int roomId, String status);

    // allocation operations
    boolean allocateRoom(int roomId, int studentId);
    boolean unallocateRoom(int roomId, int studentId);
    List<User> findStudentsInRoom(int roomId);
    public List<Room> findRoomByStudentId(int studentId);

}
