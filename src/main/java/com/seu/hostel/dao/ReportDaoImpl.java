package com.seu.hostel.dao;

import com.seu.hostel.model.Report;
import com.seu.hostel.util.ConnectionManager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class ReportDaoImpl implements ReportDao {
    @Override
    public Report generateReport() {
        Report r = new Report();
        try (Connection c = ConnectionManager.getConnection();
             Statement st = c.createStatement()) {

            // total rooms
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM rooms");
            if (rs.next()) r.setTotalRooms(rs.getInt(1));

            // occupied & available beds
            rs = st.executeQuery("SELECT SUM(capacity) FROM rooms");
            int totalBeds = (rs.next()) ? rs.getInt(1) : 0;
            rs = st.executeQuery("SELECT COUNT(*) FROM room_allocations WHERE active=TRUE");
            int occupied = (rs.next()) ? rs.getInt(1) : 0;
            r.setOccupiedBeds(occupied);
            r.setAvailableBeds(totalBeds - occupied);

            // students
            rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='STUDENT'");
            if (rs.next()) r.setTotalStudents(rs.getInt(1));

            // fees
            rs = st.executeQuery("SELECT COUNT(*) FROM fees WHERE status='PENDING'");
            if (rs.next()) r.setPendingFees(rs.getInt(1));
            rs = st.executeQuery("SELECT COUNT(*) FROM fees WHERE status='PAID'");
            if (rs.next()) r.setPaidFees(rs.getInt(1));

            // complaints
            rs = st.executeQuery("SELECT COUNT(*) FROM complaints WHERE status='PENDING'");
            if (rs.next()) r.setComplaintsPending(rs.getInt(1));
            rs = st.executeQuery("SELECT COUNT(*) FROM complaints WHERE status='RESOLVED'");
            if (rs.next()) r.setComplaintsResolved(rs.getInt(1));

            // visitors
            rs = st.executeQuery("SELECT COUNT(*) FROM visitors");
            if (rs.next()) r.setVisitorCount(rs.getInt(1));

        } catch (Exception e) { e.printStackTrace(); }
        return r;
    }
}
