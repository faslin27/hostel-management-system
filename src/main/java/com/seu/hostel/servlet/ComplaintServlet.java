package com.seu.hostel.servlet;

import com.seu.hostel.dao.ComplaintDao;
import com.seu.hostel.dao.ComplaintDaoImpl;
import com.seu.hostel.model.Complaint;
import com.seu.hostel.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/complaints")
public class ComplaintServlet extends HttpServlet {

    private final ComplaintDao complaintDao = new ComplaintDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Complaint> complaints = complaintDao.findAll();
        req.setAttribute("complaints", complaints);
        req.getRequestDispatcher("/complaints/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("submit".equals(action)) {
            User user = (User) req.getSession().getAttribute("user");
            Complaint c = new Complaint();
            c.setTitle(req.getParameter("title"));
            c.setDescription(req.getParameter("description"));
            c.setCreatedBy(user.getId());
            complaintDao.save(c);
            req.getSession().setAttribute("msg", "Complaint submitted successfully.");
        }

        if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");
            String note = req.getParameter("note");

            complaintDao.updateStatus(id, status, note);
            req.getSession().setAttribute("msg", "Complaint status updated successfully.");
            resp.sendRedirect(req.getContextPath() + "/complaints");
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/complaints");
    }

}
