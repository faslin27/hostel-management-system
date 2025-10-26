package com.seu.hostel.dao;

import com.seu.hostel.model.Complaint;
import java.util.List;

public interface ComplaintDao {
    void save(Complaint c);
    List<Complaint> findAll();
    void updateStatus(int id, String status);
    public void updateStatus(int id, String status, String note);
}
