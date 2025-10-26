package com.seu.hostel.servlet;

import com.seu.hostel.dao.ReportDao;
import com.seu.hostel.dao.ReportDaoImpl;
import com.seu.hostel.model.Report;
import com.seu.hostel.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    private final ReportDao reportDao = new ReportDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = (User) req.getSession().getAttribute("user");

        // only Admin/Warden can access reports
        if (!("ADMIN".equals(u.getRole()) || "WARDEN".equals(u.getRole()))) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        Report report = reportDao.generateReport();
        req.setAttribute("report", report);
        req.getRequestDispatcher("/reports/list.jsp").forward(req, resp);
    }
}
