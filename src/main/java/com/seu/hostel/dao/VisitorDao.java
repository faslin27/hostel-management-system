package com.seu.hostel.dao;

import com.seu.hostel.model.Visitor;
import java.util.List;

public interface VisitorDao {

    void save(Visitor visitor);

    List<Visitor> findAll();

    List<Visitor> findByStudent(int studentId);
}
