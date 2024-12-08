<%@ page import="DAO.CollegeDAO" %>
<%@ page import="model.Colleges" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Manage Colleges</title>
  <style>
    h1 {
      text-align: center;
    }
    table {
      width: 80%;
      margin-top: 20px;
      border-collapse: collapse;
    }
    th, td {
      border: 1px solid black;
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
<br><br>

<h1>Manage Colleges</h1>

<%
  Integer userID = (Integer) session.getAttribute("userID");

  if (userID == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  CollegeDAO collegeDAO = new CollegeDAO();

  String action = request.getParameter("action");
  if (action != null) {
    try {
      switch (action) {
        case "add":
          String name = request.getParameter("name");
          String location = request.getParameter("location");
          int yearFounded = Integer.parseInt(request.getParameter("yearFounded"));
          float averageGPA = Float.parseFloat(request.getParameter("averageGPA"));
          collegeDAO.addCollege(name, location, yearFounded, averageGPA, userID);
          System.out.println("College added successfully!");
          break;

        case "delete":
          int deleteCollegeID = Integer.parseInt(request.getParameter("collegeID"));
          collegeDAO.deleteCollege(deleteCollegeID, userID);
          System.out.println("College deleted successfully!");
          break;

        case "update":
          int collegeID = Integer.parseInt(request.getParameter("collegeID"));
          String updatedName = request.getParameter("name");
          String updatedLocation = request.getParameter("location");
          int updatedYearFounded = Integer.parseInt(request.getParameter("yearFounded"));
          float updatedAverageGPA = Float.parseFloat(request.getParameter("averageGPA"));
          collegeDAO.updateCollege(collegeID, updatedName, updatedLocation, updatedYearFounded, updatedAverageGPA, userID);
          System.out.println("College updated successfully!");
          break;

        case "search":
          String keyword = request.getParameter("searchKeyword");
          request.setAttribute("searchResults", collegeDAO.searchCollegesByName(keyword));
          break;
      }
    } catch (Exception e) {
      System.out.println("Error: " + e.getMessage());
    }
  }

  List<Colleges> colleges = collegeDAO.getCollegesByUserID(userID);
%>

<h2>Add a New College</h2>
<form method="post" action="manageColleges.jsp">
  <label for="name">College Name:</label><br>
  <input type="text" id="name" name="name" required><br><br>
  <label for="location">Location:</label><br>
  <input type="text" id="location" name="location" required><br><br>
  <label for="yearFounded">Year Founded:</label><br>
  <input type="number" id="yearFounded" name="yearFounded" min="0" required><br><br>
  <label for="averageGPA">Average GPA:</label><br>
  <input type="number" step="0.01" id="averageGPA" name="averageGPA" required><br><br>
  <button type="submit" name="action" value="add">Add College</button>
</form>

<h2>Search Colleges</h2>
<form method="post" action="manageColleges.jsp">
  <label for="searchKeyword">Search by College Name:</label><br>
  <input type="text" id="searchKeyword" name="searchKeyword" required><br><br>
  <button type="submit" name="action" value="search">Search</button>
</form>

<%
  List<Colleges> searchResults = (List<Colleges>) request.getAttribute("searchResults");
  if (searchResults != null) {
%>
<h2>Search Results</h2>
<table>
  <tr>
    <th>Name</th>
    <th>Location</th>
    <th>Year Founded</th>
    <th>Average GPA</th>
  </tr>
  <% for (Colleges college : searchResults) { %>
  <tr>
    <td><%= college.getName() %></td>
    <td><%= college.getLocation() %></td>
    <td><%= college.getYearFounded() %></td>
    <td><%= college.getAverageGPA() %></td>
  </tr>
  <% } %>
</table>
<% } %>

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
    <td><%= college.getName() %></td>
    <td><%= college.getLocation() %></td>
    <td><%= college.getYearFounded() %></td>
    <td><%= college.getAverageGPA() %></td>
    <td>
      <form method="post" action="manageColleges.jsp" style="display: inline;">
        <input type="hidden" name="collegeID" value="<%= college.getCollegeID() %>">
        <input type="text" name="name" value="<%= college.getName() %>" required>
        <input type="text" name="location" value="<%= college.getLocation() %>" required>
        <input type="number" name="yearFounded" value="<%= college.getYearFounded() %>" required>
        <input type="number" step="0.01" name="averageGPA" value="<%= college.getAverageGPA() %>" required>
        <button type="submit" name="action" value="update">Save</button>
      </form>
    </td>
    <td>
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