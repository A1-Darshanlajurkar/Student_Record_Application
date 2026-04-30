package com.student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/students", "/students/add", "/students/delete"})
public class StudentServlet extends HttpServlet {

    private final StudentDAO dao = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/students/delete".equals(path)) {
            String idParam = req.getParameter("id");
            if (idParam != null) {
                try {
                    dao.deleteStudent(Integer.parseInt(idParam));
                    req.getSession().setAttribute("message", "Student deleted successfully.");
                } catch (SQLException | NumberFormatException e) {
                    req.getSession().setAttribute("error", "Failed to delete student: " + e.getMessage());
                }
            }
            resp.sendRedirect(req.getContextPath() + "/students");
            return;
        }

        // Default: list all students
        try {
            List<Student> students = dao.getAllStudents();
            req.setAttribute("students", students);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/students.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name      = sanitize(req.getParameter("name"));
        String rollNo    = sanitize(req.getParameter("rollNo"));
        String className = sanitize(req.getParameter("className"));
        String city      = sanitize(req.getParameter("city"));

        // Basic server-side validation
        if (name.isEmpty() || rollNo.isEmpty() || className.isEmpty() || city.isEmpty()) {
            req.getSession().setAttribute("error", "All fields are required.");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        Student s = new Student(name, rollNo, className, city);
        try {
            dao.addStudent(s);
            req.getSession().setAttribute("message", "Student '" + name + "' added successfully!");
        } catch (SQLException e) {
            String msg = e.getMessage().contains("Duplicate")
                    ? "Roll No. '" + rollNo + "' already exists."
                    : "Database error: " + e.getMessage();
            req.getSession().setAttribute("error", msg);
        }
        resp.sendRedirect(req.getContextPath() + "/students");
    }

    // Strip leading/trailing whitespace; prevent null pointer
    private String sanitize(String value) {
        return value == null ? "" : value.trim();
    }
}
