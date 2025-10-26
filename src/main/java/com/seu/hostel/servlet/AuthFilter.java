package com.seu.hostel.servlet;

import com.seu.hostel.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.*;

@WebFilter("/*")
public class AuthFilter implements Filter {

    // map URL prefix -> allowed roles
    private final Map<String, Set<String>> accessMap = new LinkedHashMap<>();

    @Override
    public void init(FilterConfig filterConfig) {
        // public pages (login, static, etc.) should be accessible without login
        // protected areas:
        accessMap.put("/admin", Set.of("ADMIN"));         // if you have /admin pages
        accessMap.put("/user", Set.of("ADMIN","WARDEN"));
        accessMap.put("/rooms", Set.of("ADMIN","WARDEN"));
        accessMap.put("/students", Set.of("ADMIN","WARDEN","STUDENT"));
        accessMap.put("/fees", Set.of("ADMIN","WARDEN","STUDENT"));
        accessMap.put("/complaints", Set.of("ADMIN","WARDEN","STUDENT"));
        accessMap.put("/notices", Set.of("ADMIN","WARDEN","STUDENT"));
        accessMap.put("/visitors", Set.of("ADMIN","WARDEN","STUDENT"));
        accessMap.put("/reports", Set.of("ADMIN","WARDEN"));
        accessMap.put("/hostel", Set.of("ADMIN","WARDEN"));
        // add other mappings as needed
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) req;
        HttpServletResponse s = (HttpServletResponse) res;
        String path = r.getRequestURI().substring(r.getContextPath().length());

        // allow static resources and login pages
        if (path.startsWith("/static") || path.startsWith("/css") || path.startsWith("/js") || path.startsWith("/login") || path.equals("/") ) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = r.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            // not logged in
            s.sendRedirect(r.getContextPath() + "/login.jsp");
            return;
        }

        // find first matching rule in accessMap
        for (Map.Entry<String, Set<String>> e : accessMap.entrySet()) {
            String prefix = e.getKey();
            if (path.startsWith(prefix)) {
                Set<String> allowed = e.getValue();
                if (!allowed.contains(user.getRole())) {
                    // forbidden
                    s.sendRedirect(r.getContextPath() + "/unauthorized.jsp");
                    return;
                }
                break; // allowed, continue
            }
        }

        chain.doFilter(req, res);
    }

    @Override
    public void destroy() { }
}
