<%@ page import="DAO.ApplicationDAO" %>
<%@ page import="DAO.CollegeDAO" %>
<%@ page import="model.Applications" %>
<%@ page import="model.Colleges" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Applications</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        /* page layout and typography */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* global link styles */
        a {
            text-decoration: none;
            font-size: 1em;
            margin-top: 20px;
            color: #007bff;
        }

        a:hover {
            color: #0056b3;
        }

        /* headings */
        h1, h2 {
            color: #333;
            margin-bottom: 10px;
        }

        /* form layout */
        form {
            width: 100%;
            max-width: 500px;
            margin-bottom: 20px;
        }

        label {
            font-weight: 500;
            color: #555;
            display: block;
            margin-bottom: 5px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
        }

        /* buttons */
        button {
            padding: 10px 15px;
            border: none;
            border-radius: 8px;
            background-color: #007bff;
            color: white;
            font-size: 1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* table layout */
        table {
            width: 90%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        td button {
            margin: 0;
        }

        .delete {
            background-color: red;
        }

        .delete:hover {
            background-color: darkred;
        }

        /* message box */
        .message {
            margin-bottom: 15px;
            padding: 10px;
            width: 90%;
            text-align: center;
            border-radius: 8px;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <!-- back link to the dashboard -->
    <a href="dashboard.jsp"><i class="fas fa-arrow-left"></i> Back</a>
    <h1>Manage Applications</h1>

    <%
        // initialize session and DAOs
        HttpSession session1 = request.getSession(false);
        if (session == null || session1.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userID = (Integer) session.getAttribute("userID");
        ApplicationDAO applicationDAO = new ApplicationDAO();
        CollegeDAO collegeDAO = new CollegeDAO();

        // fetch colleges and applications for user
        List<Colleges> collegesList = collegeDAO.getCollegesByUserID(userID);
        List<Applications> applicationsList = applicationDAO.getApplicationsByUserID(userID);

        // handle actions (add, update, delete)
        String message = null;
        String messageType = "success";
        String action = request.getParameter("action");

        try {
            if (action != null) {
                switch (action) {
                    case "add":
                        applicationDAO.addApplication(
                                request.getParameter("collegeName"),
                                request.getParameter("submissionStatus"),
                                request.getParameter("applicationDeadline"),
                                request.getParameter("applicationType"),
                                userID
                        );
                        response.sendRedirect("manageApplications.jsp?message=Application added successfully!");
                        return;

                    case "delete":
                        int applicationID = Integer.parseInt(request.getParameter("applicationID"));
                        applicationDAO.deleteApplication(applicationID, userID);
                        response.sendRedirect("manageApplications.jsp?message=Application deleted successfully!");
                        return;

                    case "update":
                        applicationDAO.updateApplication(
                                Integer.parseInt(request.getParameter("applicationID")),
                                request.getParameter("collegeName"),
                                request.getParameter("submissionStatus"),
                                request.getParameter("applicationDeadline"),
                                request.getParameter("applicationType"),
                                userID
                        );
                        response.sendRedirect("manageApplications.jsp?message=Application updated successfully!");
                        return;

                    default:
                        message = "Unknown action!";
                        messageType = "error";
                        break;
                }
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            messageType = "error";
        }
    %>

    <!-- show success or error messages -->
    <% if (message != null) { %>
    <div class="message <%= messageType %>"><%= message %></div>
    <% } %>

    <!-- form to add new applications -->
    <h2>Add a New Application</h2>
    <form method="post" action="manageApplications.jsp">
        <label for="collegeName">College:</label>
        <select name="collegeName" id="collegeName" required>
            <% for (Colleges college : collegesList) { %>
            <option value="<%= college.getName() %>"><%= college.getName() %></option>
            <% } %>
        </select>

        <label for="submissionStatus">Submission Status:</label>
        <select name="submissionStatus" id="submissionStatus" required>
            <option value="Done">Done</option>
            <option value="Not Complete">Not Complete</option>
            <option value="In Progress">In Progress</option>
        </select>

        <label for="applicationDeadline">Application Deadline:</label>
        <input type="date" id="applicationDeadline" name="applicationDeadline" required>

        <label for="applicationType">Application Type:</label>
        <select name="applicationType" id="applicationType" required>
            <option value="Early Decision">Early Decision</option>
            <option value="Regular Decision">Regular Decision</option>
        </select>

        <button type="submit" name="action" value="add"><i class="fas fa-plus"></i> Add Application</button>
    </form>

    <!-- table showing existing applications -->
    <h2>You
