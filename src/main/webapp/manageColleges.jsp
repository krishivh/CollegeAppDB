<%@ page import="DAO.CollegeDAO" %>
<%@ page import="model.Colleges" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Manage Colleges</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background-color: #f4f4f9;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    a {
      text-decoration: none;
      font-size: 1em;
      margin-top: 20px;
      color: #007bff;
    }

    a:hover {
      color: #0056b3;
    }

    h1, h2 {
      color: #333;
      margin-bottom: 10px;
    }

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

    td input, td button {
      margin: 5px 0;
    }

    form {
      width: 100%;
      max-width: 500px;
      margin-bottom: 20px;
    }

    label {
      font-weight: 500;
      color: #555;
    }

    input[type="text"], input[type="number"], input[type="hidden"] {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 8px;
    }

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

    button.delete {
      background-color: red;
    }

    button.delete:hover {
      background-color: darkred;
    }
  </style>
</head>
<body>
<a href="dashboard.jsp"><i class="fas fa-arrow-left"></i> Back</a>
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
          break;

        case "delete":
          int deleteCollegeID = Integer.parseInt(request.getParameter("collegeID"));
          collegeDAO.deleteCollege(deleteCollegeID, userID);
          break;

        case "update":
          int collegeID = Integer.parseInt(request.getParameter("collegeID"));
          String updatedName = request.getParameter("name");
          String updatedLocation = request.getParameter("location");
          int updatedYearFounded = Integer.parseInt(request.getParameter("yearFounded"));
          float updatedAverageGPA = Float.parseFloat(request.getParameter("averageGPA"));
          collegeDAO.updateCollege(collegeID, updatedName, updatedLocation, updatedYearFounded, updatedAverageGPA, userID);
          break;

        case "search":
          String keyword = request.getParameter("searchKeyword");
          request.setAttribute("searchResults", collegeDAO.searchCollegesByName(keyword, userID));
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
  <label for="name">College Name:</label>
  <input type="text" id="name" name="name" required>
  <label for="location">Location:</label>
  <input type="text" id="location" name="location" required>
  <label for="yearFounded">Year Founded:</label>
  <input type="number" id="yearFounded" name="yearFounded" min="0" required>
  <label for="averageGPA">Average GPA:</label>
  <input type="number" step="0.01" id="averageGPA" name="averageGPA" required>
  <button type="submit" name="action" value="add"><i class="fas fa-plus"></i> Add College</button>
</form>

<h2>Search Colleges</h2>
<form method="post" action="manageColleges.jsp">
  <label for="searchKeyword">Search by College Name:</label>
  <input type="text" id="searchKeyword" name="searchKeyword" required>
  <button type="submit" name="action" value="search"><i class="fas fa-search"></i> Search</button>
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
        <button type="submit" name="action" value="update"><i class="fas fa-save"></i> Save</button>
      </form>
    </td>
    <td>
      <form method="post" action="manageColleges.jsp" style="display: inline;">
        <input type="hidden" name="collegeID" value="<%= college.getCollegeID() %>">
        <button type="submit" name="action" value="delete" class="delete"><i class="fas fa-trash"></i> Delete</button>
      </form>
    </td>
  </tr>
  <% } %>
</table>
</body>
</html>
