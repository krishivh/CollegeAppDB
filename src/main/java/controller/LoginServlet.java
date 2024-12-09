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

        //retrieve email and password from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //create a new UserDAO instance for login validation
        UserDAO userDAO = new UserDAO();
        User loggedInUser = null;  //initialize the User object to store the logged-in user

        try {
            loggedInUser = userDAO.loginUser(email, password);  //return User object
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);  //handle execption
        }

        if (loggedInUser != null) {  //check if the user object is not null (successful login)
            //create or retrieve the session for the logged-in user
            HttpSession session = request.getSession(true);  //returning true ensures a new session is created if one does not exist

            //store the userID in the session so it can be used in other requests
            session.setAttribute("userID", loggedInUser.getUserID());

            //store other user details (e.g., user name, email) for further use
            session.setAttribute("userName", loggedInUser.getFirstName() + " " + loggedInUser.getLastName());

            //redirect the user to the dashboard page after successful login (dashboard with links to manage colleges and tasks pages)
            response.sendRedirect("dashboard.jsp");
        } else {
            //if login fails
            request.setAttribute("errorMessage", "Invalid email or password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp"); //redirection
            dispatcher.forward(request, response);
        }
    }
}

