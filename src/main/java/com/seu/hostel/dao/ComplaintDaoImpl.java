package com.seu.hostel.dao;

import com.seu.hostel.model.Complaint;
import com.seu.hostel.util.ConnectionManager;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDaoImpl implements ComplaintDao {

    @Override
    public void save(Complaint c) {
        String sql = "INSERT INTO complaints(title, description, status, created_by) VALUES (?, ?, 'PENDING', ?)";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getTitle());
            ps.setString(2, c.getDescription());
            ps.setInt(3, c.getCreatedBy());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Complaint> findAll() {
        List<Complaint> list = new ArrayList<>();
        String sql =
                "SELECT c.id, c.title, c.description, c.status, c.created_at, " +
                        "u.name as created_by_name, u.reg_no as created_by_regno, u.id as created_by ,c.note " +
                        "FROM complaints c " +
                        "JOIN users u ON c.created_by = u.id " +
                        "ORDER BY c.created_at DESC";

        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Complaint comp = new Complaint();
                comp.setId(rs.getInt("id"));
                comp.setTitle(rs.getString("title"));
                comp.setDescription(rs.getString("description"));
                comp.setStatus(rs.getString("status"));
                comp.setCreatedBy(rs.getInt("created_by"));
                comp.setCreatedByName(rs.getString("created_by_name"));
                comp.setCreatedByRegNo(rs.getString("created_by_regno"));
                comp.setNote(rs.getString("note"));

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) {
                    LocalDateTime dateTime = ts.toLocalDateTime();

                    // Format to string
                    String formatted = dateTime.format(formatter);
                    // Parse back using the same formatter
                    LocalDateTime parsed = LocalDateTime.parse(formatted, formatter);
                    comp.setCreatedAt(parsed);
                }


                list.add(comp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void updateStatus(int id, String status) {
        String sql = "UPDATE complaints SET status = ? WHERE id = ?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateStatus(int id, String status, String note) {
        String sql = "UPDATE complaints SET status = ?, note = ? WHERE id = ?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, note);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
