package com.seu.hostel.dao;

import com.seu.hostel.model.User;
import java.util.List;

public interface UserDao {
    User findByUsernameAndPassword(String username, String passwordHash);
    User findById(int id);
    void update(User user);
    void save(User user);
    List<User> findAllByRole(String role);
    public List<User> findUnallocatedStudents();
}
