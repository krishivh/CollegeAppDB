<%@ page import="DAO.ApplicationDAO" %>
<%@ page import="model.Colleges" %>
<%@ page import="model.Applications" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="DAO.CollegeDAO" %>

<html>
<head>
    <title>Manage Applications</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        form {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<a href="dashboard.jsp" style="text-decoration: none; font-size: 16px;">&#8592; Back</a>
<h1>Manage Applications</h1>

<%
    // Ensure the user is logged in
    HttpSession existingSession = request.getSession(false);
    if (existingSession == null || existingSession.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return; // Stop further processing
    }

    int userID = (Integer) existingSession.getAttribute("userID");

    // Initialize DAO for fetching colleges and managing applications
    ApplicationDAO applicationDAO = new ApplicationDAO();
    CollegeDAO collegeDAO = new CollegeDAO();

    // Fetch the list of colleges for this user
    List<Colleges> collegesList = collegeDAO.getCollegesByUserID(userID);

    // Process form actions (Add, Edit, Delete)
    String action = request.getParameter("action");
    if (action != null) {
        try {
            switch (action) {
                case "add": // Add a new application
                    String collegeID = request.getParameter("collegeID");
                    String submissionStatus = request.getParameter("submissionStatus");
                    String applicationDeadline = request.getParameter("applicationDeadline");
                    String applicationType = request.getParameter("applicationType");

                    // Add application
                    applicationDAO.addApplication(Integer.parseInt(collegeID), submissionStatus, applicationDeadline, applicationType, userID);
                    out.println("<p style='color: green;'>Application added successfully!</p>");
                    break;

                case "delete": // Delete an application
                    int applicationID = Integer.parseInt(request.getParameter("applicationID"));
                    applicationDAO.deleteApplication(applicationID, userID);
                    out.println("<p style='color: green;'>Application deleted successfully!</p>");
                    break;

                case "update": // Edit an application
                    // Fetch updated values for application
                    int appID = Integer.parseInt(request.getParameter("applicationID"));
                    String updatedSubmissionStatus = request.getParameter("submissionStatus");
                    String updatedApplicationDeadline = request.getParameter("applicationDeadline");
                    String updatedApplicationType = request.getParameter("applicationType");

                    applicationDAO.updateApplication(appID, updatedSubmissionStatus, updatedApplicationDeadline, updatedApplicationType, userID);
                    out.println("<p style='color: green;'>Application updated successfully!</p>");
                    break;
            }
        } catch (Exception e) {
            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        }
    }

    // Fetch the list of applications for the logged-in user
    List<Applications> applications = applicationDAO.getApplicationsByUserID(userID);
%>

<!-- Form to Add a New Application -->
<h2>Add a New Application</h2>
<form method="post" action="manageApplications.jsp">
    <label for="collegeID">College:</label><br>
    <select name="collegeID" id="collegeID" required>
        <% for (Colleges college : collegesList) { %>
        <option value="<%= college.getCollegeID() %>"><%= college.getName() %></option>
        <% } %>
    </select><br><br>

    <label for="submissionStatus">Submission Status:</label><br>
    <!-- Submission Status Dropdown -->
    <select name="submissionStatus" required>
        <option value="Done">Done</option>
        <option value="Not Complete">Not Complete</option>
        <option value="In Progress">In Progress</option>
    </select><br><br>

    <label for="applicationDeadline">Application Deadline:</label><br>
    <input type="date" id="applicationDeadline" name="applicationDeadline" required><br><br>

    <label for="applicationType">Application Type:</label><br>
    <!-- Application Type Dropdown -->
    <select name="applicationType" required>
        <option value="Early Decision">Early Decision</option>
        <option value="Regular Decision">Regular Decision</option>
    </select><br><br>

    <button type="submit" name="action" value="add">Add Application</button>
</form>

<!-- Display List of Applications -->
<h2>Your Applications</h2>
<table>
    <tr>
        <th>College Name</th>
        <th>Submission Status</th>
        <th>Application Deadline</th>
        <th>Application Type</th>
        <th>Edit</th>
        <th>Delete</th>
    </tr>
    <% for (Applications application1 : applications) { %>
    <tr>
        <td><%= application1.getCollegeName() %></td>
        <td><%= application1.getSubmissionStatus() %></td>
        <td><%= application1.getApplicationDeadline() %></td>
        <td><%= application1.getApplicationType() %></td>
        <td>
            <!-- Edit Form -->
            <form method="post" action="manageApplications.jsp" style="display: inline;">
                <input type="hidden" name="applicationID" value="<%= application1.getApplicationID() %>">

                <!-- Submission Status Dropdown for Edit -->
                <select name="submissionStatus" required>
                    <option value="Done" <%= "Done".equals(application1.getSubmissionStatus()) ? "selected" : "" %>>Done</option>
                    <option value="Not Complete" <%= "Not Complete".equals(application1.getSubmissionStatus()) ? "selected" : "" %>>Not Complete</option>
                    <option value="In Progress" <%= "In Progress".equals(application1.getSubmissionStatus()) ? "selected" : "" %>>In Progress</option>
                </select><br><br>

                <input type="date" name="applicationDeadline" value="<%= application1.getApplicationDeadline() %>" required>

                <!-- Application Type Dropdown for Edit -->
                <select name="applicationType" required>
                    <option value="Early Decision" <%= "Early Decision".equals(application1.getApplicationType()) ? "selected" : "" %>>Early Decision</option>
                    <option value="Regular Decision" <%= "Regular Decision".equals(application1.getApplicationType()) ? "selected" : "" %>>Regular Decision</option>
                </select><br><br>

                <button type="submit" name="action" value="update">Save</button>
            </form>
        </td>
        <td>
            <!-- Delete Form -->
            <form method="post" action="manageApplications.jsp" style="display: inline;">
                <input type="hidden" name="applicationID" value="<%= application1.getApplicationID() %>">
                <button type="submit" name="action" value="delete" style="background-color: red; color: white;">Delete</button>
            </form>
        </td>
    </tr>
    <% } %>
</table>

</body>
</html>
