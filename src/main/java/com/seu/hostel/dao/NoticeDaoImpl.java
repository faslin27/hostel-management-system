package com.seu.hostel.dao;

import com.seu.hostel.model.Notice;
import com.seu.hostel.util.ConnectionManager;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class NoticeDaoImpl implements NoticeDao {
    @Override
    public void save(Notice n) {
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO notices(title, description,created_by,created_at) VALUES(?,?,?,CURRENT_TIMESTAMP())");
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getDescription());
            ps.setString(3, n.getCreatedBy());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public List<Notice> findAll() {
        List<Notice> list = new ArrayList<>();
        String sql = "SELECT id, title, description, created_by ,created_at FROM notices ORDER BY created_at DESC";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Notice n = new Notice();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("title"));
                n.setDescription(rs.getString("description"));
                n.setCreatedBy(rs.getString("created_by"));

                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) {
                    LocalDateTime dateTime = ts.toLocalDateTime();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    n.setCreatedAt(Timestamp.valueOf(dateTime.format(formatter)));
                }
                list.add(n);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
