package com.seu.hostel.dao;

import com.seu.hostel.model.Fee;
import java.sql.ResultSet;
import java.util.List;

public interface FeeDao {

    void addFee(Fee fee);

    List<Fee> findAll();

    List<Fee> findByStudent(int studentId);

    void markPaid(int id);
}
