package com.seu.hostel.servlet;

import com.seu.hostel.dao.FeeDao;
import com.seu.hostel.dao.FeeDaoImpl;
import com.seu.hostel.dao.UserDao;
import com.seu.hostel.dao.UserDaoImpl;
import com.seu.hostel.model.Fee;
import com.seu.hostel.model.Student;
import com.seu.hostel.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/fees")
public class FeeServlet extends HttpServlet {
    private final FeeDao feeDao = new FeeDaoImpl();
    private final UserDao userDao = new UserDaoImpl();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = (User) req.getSession().getAttribute("user");
        List<Fee> fees;

        if (u.getRole().equals("STUDENT")) {
            fees = feeDao.findByStudent(u.getId());
            List<User> students = userDao.findAllByRole("STUDENT"); // 👉 make sure this DAO method exists
            req.setAttribute("students", students);
        } else {
            fees = feeDao.findAll();
            // Only admin & warden need student list
            List<User> students = userDao.findAllByRole("STUDENT"); // 👉 make sure this DAO method exists
            req.setAttribute("students", students);
        }

        req.setAttribute("fees", fees);
        req.getRequestDispatcher("/fees/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Fee f = new Fee();
            f.setStudentId(Integer.parseInt(req.getParameter("studentId")));
            f.setFeeYear(Integer.parseInt(req.getParameter("feeYear")));
            f.setPeriod(req.getParameter("period"));
            f.setStatus("PENDING");
            feeDao.addFee(f);
            req.getSession().setAttribute("msg", "Fee record added.");
        } else if ("pay".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            feeDao.markPaid(id);
            req.getSession().setAttribute("msg", "Fee marked as paid.");
        }

        resp.sendRedirect(req.getContextPath() + "/fees");
    }
}
