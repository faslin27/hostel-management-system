package com.seu.hostel.servlet;

import com.seu.hostel.dao.NoticeDao;
import com.seu.hostel.dao.NoticeDaoImpl;
import com.seu.hostel.model.Notice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/notices")
public class NoticeServlet extends HttpServlet {
    private final NoticeDao noticeDao = new NoticeDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Notice> notices = noticeDao.findAll();
        req.setAttribute("notices", notices);
        req.getRequestDispatcher("/notices/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String createdBy = req.getParameter("createdBy");

        Notice n = new Notice();
        n.setTitle(title);
        n.setDescription(description);
        n.setCreatedBy(createdBy);
        noticeDao.save(n);

        req.getSession().setAttribute("msg", "Notice posted successfully.");
        resp.sendRedirect(req.getContextPath() + "/notices");
    }


}
