package com.seu.hostel.dao;

import com.seu.hostel.model.User;
import com.seu.hostel.util.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {
    @Override
    public User findByUsernameAndPassword(String username, String passwordHash) {
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, passwordHash);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public User findById(int id) {
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement("SELECT * FROM users WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public void update(User user) {
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement(
                    "UPDATE users SET name=?, reg_no=?, nic=?, mobile=? WHERE id=?");
            ps.setString(1, user.getName());
            ps.setString(2, user.getRegNo());
            ps.setString(3, user.getNic());
            ps.setString(4, user.getMobile());
            ps.setInt(5, user.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void save(User user) {
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO users(username,password,role,name,reg_no,nic,mobile) VALUES(?,?,?,?,?,?,?)");
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());
            ps.setString(4, user.getName());
            ps.setString(5, user.getRegNo());
            ps.setString(6, user.getNic());
            ps.setString(7, user.getMobile());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public List<User> findAllByRole(String role) {
        List<User> list = new ArrayList<>();
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement("SELECT * FROM users WHERE role=? ORDER BY id");
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    private User map(ResultSet rs) throws Exception {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setRole(rs.getString("role"));
        u.setName(rs.getString("name"));
        u.setRegNo(rs.getString("reg_no"));
        u.setNic(rs.getString("nic"));
        u.setMobile(rs.getString("mobile"));
        return u;
    }

    @Override
    public List<User> findUnallocatedStudents() {
        List<User> list = new ArrayList<>();
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement(
                    "SELECT * FROM users WHERE role='STUDENT' " +
                            "AND id NOT IN (SELECT student_id FROM room_allocations WHERE active=TRUE)"
            );
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

}
