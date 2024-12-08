package controller;

import model.User;
import DAO.UserDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/home")
public class RegisterServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(RegisterServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            logger.info("Entering doPost method.");
            User user = new User();

            // Remove userID assignment as it is auto-incremented by the database
            // Assume passwords are stored
            user.setFirstName(request.getParameter("firstName"));
            user.setLastName(request.getParameter("lastName"));
            user.setEmail(request.getParameter("email"));
            user.setPassword(request.getParameter("password")); // Assuming you have a field for this
            user.setPhone(request.getParameter("phone"));
            user.setHighSchool(request.getParameter("highSchool"));
            user.setGPA(Float.parseFloat(request.getParameter("gpa")));

            UserDAO userDAO = new UserDAO();
            int result = userDAO.registerUser(user);

            if (result == 1) {
                logger.info("User registered successfully.");
                response.sendRedirect("login.jsp");
            } else {
                logger.warning("Failed to register user.");
                response.sendRedirect("register.jsp");
            }
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Failed to parse a number", e);
            response.sendRedirect("error.jsp");
        } catch (IOException e) {
            logger.log(Level.SEVERE, "IO Error", e);
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Unexpected Error", e);
            response.sendRedirect("error.jsp");
        }
    }
}