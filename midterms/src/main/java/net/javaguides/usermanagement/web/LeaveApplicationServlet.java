package net.javaguides.usermanagement.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.javaguides.usermanagement.dao.LeaveApplicationDAO;
import net.javaguides.usermanagement.model.LeaveApplication;

@WebServlet("/leave-list")
public class LeaveApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LeaveApplicationDAO leaveApplicationDAO;

    public void init() {
        leaveApplicationDAO = new LeaveApplicationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            String action = request.getParameter("action");
            try {
                if (action == null) {
                    listLeave(request, response);
                } else {
                    switch (action) {
                        case "new":
                            showNewForm(request, response);
                            break;
                        case "insert":
                            insertLeave(request, response);
                            break;
                        case "delete":
                            deleteLeave(request, response);
                            break;
                        case "edit":
                            showEditForm(request, response);
                            break;
                        case "update":
                            updateLeave(request, response);
                            break;
                        case "logout":
                            logout(request, response);
                            break;
                        default:
                            listLeave(request, response);
                            break;
                    }
                }
            } catch (SQLException ex) {
                throw new ServletException(ex);
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void listLeave(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<LeaveApplication> listLeave = leaveApplicationDAO.selectAllLeaves();
        request.setAttribute("listLeave", listLeave);
        request.getRequestDispatcher("leave-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("leave-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        LeaveApplication existingLeave = leaveApplicationDAO.selectLeave(id);
        request.setAttribute("leave", existingLeave);
        request.getRequestDispatcher("leave-form.jsp").forward(request, response);
    }

    private void insertLeave(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String name = request.getParameter("name");
        String leaveType = request.getParameter("leaveType");
        String status = request.getParameter("status");
        LeaveApplication newLeave = new LeaveApplication(name, leaveType, status);
        leaveApplicationDAO.insertLeave(newLeave);
        response.sendRedirect("leave-list");
    }

    private void updateLeave(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String leaveType = request.getParameter("leaveType");
        String status = request.getParameter("status");
        LeaveApplication leave = new LeaveApplication(id, name, leaveType, status);
        leaveApplicationDAO.updateLeave(leave);
        response.sendRedirect("leave-list");
    }

    private void deleteLeave(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        leaveApplicationDAO.deleteLeave(id);
        response.sendRedirect("leave-list");
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}
