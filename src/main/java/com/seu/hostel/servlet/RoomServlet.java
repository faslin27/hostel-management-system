package com.seu.hostel.servlet;

import com.seu.hostel.dao.*;
import com.seu.hostel.model.Room;
import com.seu.hostel.model.User;

import com.seu.hostel.util.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {
    private final RoomDao roomDao = new RoomDaoImpl();
    private final UserDao userDao = new UserDaoImpl();
    private final StudentDao studentDao = new StudentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!SecurityUtil.isLoggedIn(session)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Room> rooms;

        if ("STUDENT".equals(user.getRole())) {
            // Student should only see their allocated room
            rooms = roomDao.findRoomByStudentId(user.getId());
        } else {
            // Admin/Warden can see all
            rooms = roomDao.findAll();
        }

        for (Room r : rooms) {
            r.setAllocations(roomDao.findStudentsInRoom(r.getId()));
        }

        List<User> students = userDao.findUnallocatedStudents();
        req.setAttribute("rooms", rooms);
        req.setAttribute("students", students);
        req.getRequestDispatcher("/rooms/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!SecurityUtil.isLoggedIn(session)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = req.getParameter("action");

        // Only ADMIN can add rooms
        if ("add".equals(action)) {
            if (!SecurityUtil.hasRole(session, "ADMIN")) {
                resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
                return;
            }
            String roomNumber = req.getParameter("roomNumber");
            int capacity = Integer.parseInt(req.getParameter("capacity"));
            Room r = new Room();
            r.setRoomNumber(roomNumber);
            r.setCapacity(capacity);
            r.setStatus("VACANT");
            roomDao.add(r);
        }

        // Both ADMIN and WARDEN can allocate/unallocate
        if ("allocate".equals(action)) {
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            int studentId = Integer.parseInt(req.getParameter("studentId"));
            boolean ok = roomDao.allocateRoom(roomId, studentId);
            if (ok) {
                studentDao.updateStudentRoom(studentId, roomId);  // ✅ update student's room
                session.setAttribute("msg", "Room allocated successfully.");
            } else {
                session.setAttribute("msg", "Allocation failed.");
            }
        } else if ("unallocate".equals(action)) {
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            int studentId = Integer.parseInt(req.getParameter("studentId"));
            boolean ok = roomDao.unallocateRoom(roomId, studentId);
            if (ok) {
                studentDao.updateStudentRoom(studentId, null);  // ✅ remove student's room
                session.setAttribute("msg", "Room freed.");
            } else {
                session.setAttribute("msg", "Unallocation failed.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/rooms");
    }

}
