package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidate the current session to log out the user
        HttpSession session = request.getSession(false); // Retrieve the existing session, do not create a new one
        if (session != null) {
            session.invalidate(); // Invalidate the session
        }

        // Redirect to the login page
        response.sendRedirect("login.jsp");
    }
}


