package com.seu.hostel.servlet;

import com.seu.hostel.dao.UserDao;
import com.seu.hostel.dao.UserDaoImpl;
import com.seu.hostel.model.User;
import com.seu.hostel.util.HashUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String hashed = HashUtil.sha256(password);

        User u = userDao.findByUsernameAndPassword(username, hashed);
        if (u != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("user", u);
            switch (u.getRole()) {
                case "ADMIN": resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp"); break;
                case "WARDEN": resp.sendRedirect(req.getContextPath() + "/warden/dashboard.jsp"); break;
                default: resp.sendRedirect(req.getContextPath() + "/student/dashboard.jsp");
            }
        } else {
            req.setAttribute("error", "Invalid credentials");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
