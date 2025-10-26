package com.seu.hostel.util;

import com.seu.hostel.model.User;
import jakarta.servlet.http.HttpSession;

public class SecurityUtil {
    public static boolean hasRole(HttpSession session, String role) {
        User u = (User) session.getAttribute("user");
        return u != null && u.getRole().equals(role);
    }

    public static boolean isLoggedIn(HttpSession session) {
        return session.getAttribute("user") != null;
    }
}
