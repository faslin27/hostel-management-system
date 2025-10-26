package com.seu.hostel.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionManager {
    private static final String URL = "jdbc:mysql://sql12.freesqldatabase.com:3306/sql12804534?useSSL=false&serverTimezone=UTC";
    private static final String USER = "sql12804534"; // your MySQL username
    private static final String PASSWORD = "DIzIT8zfk3"; // your MySQL password

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
