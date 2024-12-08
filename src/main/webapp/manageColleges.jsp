<%@ page import="DAO.CollegeDAO" %>
<%@ page import="model.Colleges" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<html>
<head>
  <title>Manage Colleges</title>
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
<h1>Manage Colleges</h1>

<%
  Integer userID = (Integer) session.getAttribute("userID");

  if (userID == null) {
    response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
    return;
  }

  CollegeDAO collegeDAO = new CollegeDAO();

  // Process form actions (Add, Edit, Delete)
  String action = request.getParameter("action");
  if (action != null) {
    try {
      switch (action) {
        case "add": // Add a new college
          String name = request.getParameter("name");
          String location = request.getParameter("location");
          int yearFounded = Integer.parseInt(request.getParameter("yearFounded")); // Ensure it's an integer
          float averageGPA = Float.parseFloat(request.getParameter("averageGPA")); // Ensure it's a float

          collegeDAO.addCollege(name, location, yearFounded, averageGPA, userID); // Pass userID
          out.println("<p style='color: green;'>College added successfully!</p>");
          break;

        case "delete": // Delete a college
          int deleteCollegeID = Integer.parseInt(request.getParameter("collegeID"));
          collegeDAO.deleteCollege(deleteCollegeID, userID); // Pass userID to ensure ownership
          out.println("<p style='color: green;'>College deleted successfully!</p>");
          break;

        case "update": // Edit a college
          String collegeIDParam = request.getParameter("collegeID");
          String updatedName = request.getParameter("name");
          String updatedLocation = request.getParameter("location");
          String yearFoundedParam = request.getParameter("yearFounded");
          String averageGPAParam = request.getParameter("averageGPA");

          if (collegeIDParam != null && !collegeIDParam.isEmpty() &&
                  updatedName != null && !updatedName.isEmpty() &&
                  updatedLocation != null && !updatedLocation.isEmpty() &&
                  yearFoundedParam != null && !yearFoundedParam.isEmpty() &&
                  averageGPAParam != null && !averageGPAParam.isEmpty()) {

            int editCollegeID = Integer.parseInt(collegeIDParam);
            int updatedYearFounded = Integer.parseInt(yearFoundedParam);  // Ensure this is an integer
            float updatedAverageGPA = Float.parseFloat(averageGPAParam);  // Ensure this is a float

            collegeDAO.updateCollege(editCollegeID, updatedName, updatedLocation, updatedYearFounded, updatedAverageGPA, userID); // Pass userID to ensure ownership
            out.println("<p style='color: green;'>College updated successfully!</p>");
          } else {
            out.println("<p style='color: red;'>All fields are required and must be filled correctly.</p>");
          }
          break;
      }
    } catch (Exception e) {
      out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
    }
  }

  // Fetch and display all colleges for the logged-in user
  List<Colleges> colleges = collegeDAO.getCollegesByUserID(userID); // Fetch colleges for the logged-in user
%>

<!-- Form to Add a New College -->
<h2>Add a New College</h2>
<form method="post" action="manageColleges.jsp">
  <label for="name">College Name:</label><br>
  <input type="text" id="name" name="name" required><br><br>

  <label for="location">Location:</label><br>
  <input type="text" id="location" name="location" required><br><br>

  <label for="yearFounded">Year Founded</label><br>
  <input type="number" id="yearFounded" name="yearFounded" min="0" step="1" required><br><br>


  <label for="averageGPA">Average GPA:</label><br>
  <input type="number" step="0.01" id="averageGPA" name="averageGPA" required><br><br>

  <button type="submit" name="action" value="add">Add College</button>
</form>

<!-- Display List of Colleges -->
<h2>Your Colleges</h2>
<table>
  <tr>
    <th>Name</th>
    <th>Location</th>
    <th>Year Founded</th>
    <th>Average GPA</th>
    <th>Edit</th>
    <th>Delete</th>
  </tr>
  <% for (Colleges college : colleges) { %>
  <tr>
    <td style="display: none;"><%= college.getCollegeID() %></td>
    <td><%= college.getName() %></td>
    <td><%= college.getLocation() %></td>
    <td><%= college.getYearFounded() %></td>
    <td><%= college.getAverageGPA() %></td>
    <td>
      <!-- Edit Form -->
      <form method="post" action="manageColleges.jsp" style="display: inline;">
        <input type="hidden" name="collegeID" value="<%= college.getCollegeID() %>">
        <input type="text" name="name" value="<%= college.getName() %>" required>
        <input type="text" name="location" value="<%= college.getLocation() %>" required>
        <input type="number" name="yearFounded" value="<%= college.getYearFounded() %>" step="1" required>
        <input type="number" step="0.01" name="averageGPA" value="<%= college.getAverageGPA() %>" required>
        <button type="submit" name="action" value="update">Save</button>
      </form>
    </td>
    <td>
      <!-- Delete Form -->
      <form method="post" action="manageColleges.jsp" style="display: inline;">
        <input type="hidden" name="collegeID" value="<%= college.getCollegeID() %>">
        <button type="submit" name="action" value="delete" style="background-color: red; color: white;">Delete</button>
      </form>
    </td>
  </tr>
  <% } %>
</table>
</body>
</html>
