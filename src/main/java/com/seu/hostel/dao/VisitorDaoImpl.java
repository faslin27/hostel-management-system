package com.seu.hostel.dao;

import com.seu.hostel.model.Visitor;
import com.seu.hostel.util.ConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VisitorDaoImpl implements VisitorDao {
    @Override
    public void save(Visitor v) {
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO visitors(name, nic, contact, visit_date) VALUES(?,?,?,?)");
            ps.setString(1, v.getName());
            ps.setString(2, v.getNic());
            ps.setString(3, v.getContact());
            ps.setTimestamp(4, Timestamp.valueOf(v.getVisitDate()));
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public List<Visitor> findAll() {
        List<Visitor> list = new ArrayList<>();
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement("SELECT * FROM visitors ORDER BY visit_date DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<Visitor> findByStudent(int studentId) {
        List<Visitor> list = new ArrayList<>();
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement("SELECT * FROM visitors WHERE student_id=? ORDER BY visit_date DESC");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    private Visitor map(ResultSet rs) throws Exception {
        Visitor v = new Visitor();
        v.setId(rs.getInt("id"));
        v.setName(rs.getString("name"));
        v.setNic(rs.getString("nic"));
        v.setContact(rs.getString("contact"));
        v.setVisitDate(rs.getTimestamp("visit_date").toLocalDateTime());
        return v;
    }
}
