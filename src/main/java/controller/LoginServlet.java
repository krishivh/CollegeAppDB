package controller;

import DAO.UserDAO;
import model.User;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve email and password from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Create a new UserDAO instance for login validation
        UserDAO userDAO = new UserDAO();
        User loggedInUser = null;  // Initialize the User object to store the logged-in user

        try {
            loggedInUser = userDAO.loginUser(email, password);  // Now it returns a User object
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);  // Handle the exception (maybe log it in the real-world app)
        }

        if (loggedInUser != null) {  // Check if the user object is not null (successful login)
            // Create or retrieve the session for the logged-in user
            HttpSession session = request.getSession(true);  // `true` ensures a new session is created if one does not exist

            // Store the userID in the session so it can be used in other requests
            session.setAttribute("userID", loggedInUser.getUserID());

            // Optionally store other user details (e.g., user name, email) for further use
            session.setAttribute("userName", loggedInUser.getFirstName() + " " + loggedInUser.getLastName());

            // Redirect the user to the dashboard page after successful login
            response.sendRedirect("dashboard.jsp");
        } else {
            // Set an error message and forward to the login page if login fails
            request.setAttribute("errorMessage", "Invalid email or password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
}

