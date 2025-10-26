package com.seu.hostel.servlet;

import com.seu.hostel.dao.VisitorDao;
import com.seu.hostel.dao.VisitorDaoImpl;
import com.seu.hostel.model.User;
import com.seu.hostel.model.Visitor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/visitors")
public class VisitorServlet extends HttpServlet {
    private final VisitorDao visitorDao = new VisitorDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = (User) req.getSession().getAttribute("user");
        List<Visitor> visitors = u.getRole().equals("STUDENT") ?
                visitorDao.findByStudent(u.getId()) : visitorDao.findAll();

        req.setAttribute("visitors", visitors);
        req.getRequestDispatcher("/visitors/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = (User) req.getSession().getAttribute("user");

        Visitor v = new Visitor();
        v.setName(req.getParameter("name"));
        v.setNic(req.getParameter("nic"));
        v.setContact(req.getParameter("contact"));
        v.setVisitDate(LocalDateTime.parse(req.getParameter("visitDate")));

        visitorDao.save(v);
        req.getSession().setAttribute("msg", "Visitor registered successfully.");

        resp.sendRedirect(req.getContextPath() + "/visitors");
    }
}
