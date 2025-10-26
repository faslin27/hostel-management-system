package com.seu.hostel.dao;

import com.seu.hostel.model.Room;
import com.seu.hostel.model.User;
import com.seu.hostel.util.ConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDaoImpl implements RoomDao {

    @Override
    public List<Room> findAll() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.*, " +
                "(SELECT COUNT(*) FROM room_allocations ra WHERE ra.room_id=r.id AND ra.active=TRUE) AS filled " +
                "FROM rooms r ORDER BY id";
        try (Connection c = ConnectionManager.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Room r = mapRoom(rs);
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Room findById(int id) {
        try (Connection c = ConnectionManager.getConnection()) {
            return findById(c, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private Room findById(Connection c, int id) throws SQLException {
        String sql = "SELECT r.*, " +
                "(SELECT COUNT(*) FROM room_allocations ra WHERE ra.room_id=r.id AND ra.active=TRUE) AS filled " +
                "FROM rooms r WHERE id=?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRoom(rs);
        }
        return null;
    }

    @Override
    public void add(Room room) {
        try (Connection c = ConnectionManager.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "INSERT INTO rooms(room_number, capacity, status) VALUES(?,?,?)")) {
            ps.setString(1, room.getRoomNumber());
            ps.setInt(2, room.getCapacity());
            ps.setString(3, "VACANT");
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Room room) {
        try (Connection c = ConnectionManager.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "UPDATE rooms SET room_number=?, capacity=?, status=? WHERE id=?")) {
            ps.setString(1, room.getRoomNumber());
            ps.setInt(2, room.getCapacity());
            ps.setString(3, room.getStatus());
            ps.setInt(4, room.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateStatus(Connection c, int roomId, String status) throws SQLException {
        try (PreparedStatement ps = c.prepareStatement("UPDATE rooms SET status=? WHERE id=?")) {
            ps.setString(1, status);
            ps.setInt(2, roomId);
            ps.executeUpdate();
        }
    }

    @Override
    public void updateStatus(int roomId, String status) {
        try (Connection c = ConnectionManager.getConnection()) {
            updateStatus(c, roomId, status);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean allocateRoom(int roomId, int studentId) {
        try (Connection c = ConnectionManager.getConnection()) {
            c.setAutoCommit(false);

            Room room = findById(c, roomId);
            if (room == null || room.getFilled() >= room.getCapacity()) {
                c.rollback();
                return false;
            }

            try (PreparedStatement psIns = c.prepareStatement(
                    "INSERT INTO room_allocations(room_id, student_id, allocated_at, active) VALUES(?,?,CURRENT_TIMESTAMP(),TRUE)")) {
                psIns.setInt(1, roomId);
                psIns.setInt(2, studentId);
                psIns.executeUpdate();
            }

            if (room.getFilled() + 1 >= room.getCapacity()) {
                updateStatus(c, roomId, "FULL");
            }

            c.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean unallocateRoom(int roomId, int studentId) {
        try (Connection c = ConnectionManager.getConnection()) {
            c.setAutoCommit(false);

            try (PreparedStatement psUpd = c.prepareStatement(
                    "UPDATE room_allocations SET active=FALSE WHERE room_id=? AND student_id=? AND active=TRUE")) {
                psUpd.setInt(1, roomId);
                psUpd.setInt(2, studentId);
                int updated = psUpd.executeUpdate();

                if (updated > 0) {
                    Room room = findById(c, roomId);
                    if (room != null && room.getFilled() < room.getCapacity()) {
                        updateStatus(c, roomId, "VACANT");
                    }
                }

                c.commit();
                return updated > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> findStudentsInRoom(int roomId) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.* FROM room_allocations ra " +
                "JOIN users u ON ra.student_id=u.id " +
                "WHERE ra.room_id=? AND ra.active=TRUE";
        try (Connection c = ConnectionManager.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setName(rs.getString("name"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Room> findRoomByStudentId(int studentId) {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.* FROM rooms r " +
                "JOIN room_allocations a ON r.id = a.room_id " +
                "WHERE a.student_id = ? AND a.active = TRUE";
        try (Connection c = ConnectionManager.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRoom(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Room mapRoom(ResultSet rs) throws SQLException {
        Room r = new Room();
        r.setId(rs.getInt("id"));
        r.setRoomNumber(rs.getString("room_number"));
        r.setCapacity(rs.getInt("capacity"));
        int filled = 0;
        try {
            filled = rs.getInt("filled");
        } catch (SQLException ignore) {}
        r.setFilled(filled);
        r.setRemaining(r.getCapacity() - filled);
        r.setStatus(filled >= r.getCapacity() ? "FULL" : "VACANT");
        return r;
    }
}

