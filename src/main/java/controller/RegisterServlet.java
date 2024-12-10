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

            //getter to retrieve password
            String password = request.getParameter("password");

            //validate if password works with requirements for security
            if (!isValidPassword(password)) {
                logger.warning("Password validation failed.");
                request.setAttribute("errorMessage", "Password must be at least 7 characters long, contain one uppercase letter, one number, and one special character.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
                dispatcher.forward(request, response);
                return;
            }

            //populate the user object
            user.setFirstName(request.getParameter("firstName"));
            user.setLastName(request.getParameter("lastName"));
            user.setEmail(request.getParameter("email"));
            user.setPassword(password);
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
                request.setAttribute("errorMessage", "Failed to register user. Please try again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
                dispatcher.forward(request, response);
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

    //criteria for password: one uppercase, at least 7 characters, one special character
    //validates if criteria is met
    private boolean isValidPassword(String password) {
        String passwordPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!])(?=\\S+$).{7,}$";
        return password != null && password.matches(passwordPattern);
    }
}
