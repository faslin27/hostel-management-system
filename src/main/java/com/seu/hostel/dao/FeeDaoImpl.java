package com.seu.hostel.dao;

import com.seu.hostel.model.Fee;
import com.seu.hostel.util.ConnectionManager;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class FeeDaoImpl implements FeeDao {

    @Override
    public void addFee(Fee fee) {
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO fees(student_id, fee_year, period, status, paid_at) VALUES(?,?,?,?,CURRENT_TIMESTAMP())");
            ps.setInt(1, fee.getStudentId());
            ps.setInt(2, fee.getFeeYear());
            ps.setString(3, fee.getPeriod());
            ps.setString(4, fee.getStatus());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    private Fee map(ResultSet rs) throws Exception {
        Fee f = new Fee();
        f.setId(rs.getInt("id"));
        f.setStudentId(rs.getInt("student_id"));
        f.setFeeYear(rs.getInt("fee_year"));
        f.setPeriod(rs.getString("period"));


        String period = rs.getString("period");
        String displayPeriod;
        switch (period) {
            case "FIRST_HALF":
                displayPeriod = "First 6 Months";
                break;
            case "SECOND_HALF":
                displayPeriod = "Second 6 Months";
                break;
            default:
                displayPeriod = "Unknown";
        }
        f.setPeriod(displayPeriod);

        f.setStatus(rs.getString("status"));
        Timestamp ts = rs.getTimestamp("paid_at");
        if (ts != null) {
            LocalDateTime dateTime = ts.toLocalDateTime();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            f.setPaidAt(Timestamp.valueOf(dateTime.format(formatter)).toLocalDateTime());
        }
        return f;
    }


    @Override
    public List<Fee> findAll() {
        List<Fee> list = new ArrayList<>();
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement("SELECT * FROM fees ORDER BY id");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<Fee> findByStudent(int studentId) {
        List<Fee> list = new ArrayList<>();
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement("SELECT * FROM fees WHERE student_id=? ORDER BY id");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public void markPaid(int id) {
        try (Connection c = ConnectionManager.getConnection()) {
            PreparedStatement ps = c.prepareStatement(
                    "UPDATE fees SET status='PAID', paid_at=CURRENT_TIMESTAMP() WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }



}
