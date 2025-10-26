package com.seu.hostel.servlet;

import com.seu.hostel.dao.StudentDao;
import com.seu.hostel.model.Room;
import com.seu.hostel.model.Student;
import com.seu.hostel.model.User;
import com.seu.hostel.util.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    private final StudentDao studentDao = new StudentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!SecurityUtil.isLoggedIn(session)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        if ("STUDENT".equals(user.getRole())) {
            Student student = studentDao.findByUserId(user.getId());
            System.out.println("Student: " + student);
            req.setAttribute("student", student);
            req.getRequestDispatcher("/student/studentProfile.jsp").forward(req, resp);
        }
        else {
            List<Student> students = studentDao.findAll();
            req.setAttribute("students", students);
            req.getRequestDispatcher("/student/list.jsp").forward(req, resp);        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!SecurityUtil.isLoggedIn(session)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId = Integer.parseInt(req.getParameter("id"));
        String mobile = req.getParameter("mobile");
        String emergency = req.getParameter("emergencyNumber");
        String address = req.getParameter("address");

        studentDao.updateContactDetails(userId, mobile, emergency, address);

        resp.sendRedirect(req.getContextPath() + "/students");
    }

}
