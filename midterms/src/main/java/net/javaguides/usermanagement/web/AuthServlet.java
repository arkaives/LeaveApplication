package net.javaguides.usermanagement.web;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.javaguides.usermanagement.dao.UserDAO;
import net.javaguides.usermanagement.model.User;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User newUser = new User(username, password);
        try {
            boolean userExists = userDAO.userExists(username); // Check if user already exists
            if (userExists) {
                // User already exists, set error attribute and forward to register page
                request.setAttribute("registerError", "Username already exists. Please choose a different one.");
                request.getRequestDispatcher("auth.jsp").forward(request, response);
            } else {
                userDAO.registerUser(newUser);
                // Registration successful, redirect to login page
                response.sendRedirect("auth.jsp");
            }
        } catch (SQLException e) {
            // Registration failed, log error and forward to register page with error
            e.printStackTrace();
            request.setAttribute("registerError", "Registration failed due to a database error.");
            request.getRequestDispatcher("auth.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = userDAO.validateUser(username, password);
        if (user != null) {
            // Login successful, set session attribute and redirect
            request.getSession().setAttribute("user", user);
            response.sendRedirect("leave-list");
        } else {
            // Login failed, set error attribute and forward to login page
            request.setAttribute("loginError", "Invalid username or password. Please try again.");
            request.getRequestDispatcher("auth.jsp").forward(request, response);
        }
    }
}
