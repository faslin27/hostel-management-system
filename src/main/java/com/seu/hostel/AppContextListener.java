package com.seu.hostel;

import com.seu.hostel.util.ConnectionManager;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Connection;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try (Connection conn = ConnectionManager.getConnection()) {
            System.out.println("✅ Connected to MySQL successfully: " + conn.getMetaData().getURL());
        } catch (Exception e) {
            System.err.println("❌ Failed to connect to MySQL:");
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("🧹 Application stopped, releasing resources if any...");
    }
}
