package com.seu.hostel.dao;

import com.seu.hostel.model.Notice;

import java.util.List;

public interface NoticeDao {
    public void save(Notice n);
    public List<Notice> findAll();
}