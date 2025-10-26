package com.seu.hostel.dao;

import com.seu.hostel.model.Student;
import com.seu.hostel.model.User;
import com.seu.hostel.util.ConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDao {

    public List<Student> findAll() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT s.*, u.username, u.name, u.reg_no, u.nic, u.mobile " +
                "FROM students s JOIN users u ON s.user_id = u.id WHERE u.role='STUDENT'";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(list);
        return list;
    }

    public Student findByUserId(int userId) {
        String sql = "SELECT s.*, u.username, u.name, u.reg_no, u.nic, u.mobile, ra.* " +
                "FROM students s " +
                "JOIN users u ON s.user_id = u.id " +
                "LEFT JOIN room_allocations ra ON s.student_id = ra.student_id " +
                "WHERE s.user_id = ?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Student findByUserName(String userName) {
        String sql = "SELECT s.*, u.username, u.name, u.reg_no, u.nic, u.mobile , ra. " +
                "FROM students s JOIN users u ON s.user_id = u.id JOIN room_allocations ra on s.student_id = ra.student_id WHERE s.username=?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private Student map(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setStudentId(rs.getInt("student_id"));
        s.setUserId(rs.getInt("user_id"));
        s.setFaculty(rs.getString("faculty"));
        s.setCourse(rs.getString("course"));
        s.setDepartment(rs.getString("department"));
        s.setHostelName(rs.getString("hostel_name"));
        s.setEmergencyNumber(rs.getString("emergency_number"));
        s.setAddress(rs.getString("address"));
        s.setRoomId(rs.getInt("room_id"));

        User u = new User();
        u.setId(rs.getInt("user_id"));
        u.setUsername(rs.getString("username"));
        u.setName(rs.getString("name"));
        u.setRegNo(rs.getString("reg_no"));
        u.setNic(rs.getString("nic"));
        u.setMobile(rs.getString("mobile"));

        s.setUser(u);
        return s;
    }

    public void updateContactDetails(int userId, String mobile, String emergency, String address) {
        String sql = "UPDATE users SET mobile = ? WHERE id = ?";
        String sql2 = "UPDATE students SET emergency_number = ?, address = ? WHERE user_id = ?";

        try (Connection conn = ConnectionManager.getConnection()) {
            try (PreparedStatement ps1 = conn.prepareStatement(sql);
                 PreparedStatement ps2 = conn.prepareStatement(sql2)) {

                ps1.setString(1, mobile);
                ps1.setInt(2, userId);
                ps1.executeUpdate();

                ps2.setString(1, emergency);
                ps2.setString(2, address);
                ps2.setInt(3, userId);
                ps2.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateStudentRoom(int studentId, Integer roomId) {
        String sql = "UPDATE students SET room_id = ? WHERE user_id = ?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (roomId != null) {
                ps.setInt(1, roomId);
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


}
