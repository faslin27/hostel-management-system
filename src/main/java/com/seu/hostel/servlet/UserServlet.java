package com.seu.hostel.servlet;

import com.seu.hostel.dao.UserDao;
import com.seu.hostel.dao.UserDaoImpl;
import com.seu.hostel.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/profile")
public class UserServlet extends HttpServlet {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User u = (User) session.getAttribute("user");
        User fresh = userDao.findById(u.getId());
        req.setAttribute("userObj", fresh);
        req.getRequestDispatcher("/users/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User u = (User) session.getAttribute("user");

        User toUpdate = userDao.findById(u.getId());
        toUpdate.setName(req.getParameter("name"));
        toUpdate.setRegNo(req.getParameter("regNo"));
        toUpdate.setNic(req.getParameter("nic"));
        toUpdate.setMobile(req.getParameter("mobile"));

        userDao.update(toUpdate);
        session.setAttribute("user", userDao.findById(u.getId()));

        resp.sendRedirect(req.getContextPath() + "/user/profile");
    }
}
