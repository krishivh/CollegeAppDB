<%@ page import="DAO.CollegeDAO" %>
<%@ page import="model.Colleges" %>
<html>
<head>
  <title>Update College</title>
</head>
<body>
<h1>Update College</h1>
<form method="post" action="manageColleges.jsp">
  <input type="hidden" name="collegeId" value="<%= request.getParameter("collegeId") %>">
  <label for="name">Name:</label>

  <input type="text" id="name" name="name" value="<%= request.getParameter("name") %>" required><br>

  <label for="location">Location:</label>
  <input type="text" id="location" name="location" value="<%= request.getParameter("location") %>" required><br>

  <label for="averageGpa">Average GPA:</label>
  <input type="text" id="averageGpa" name="averageGpa" value="<%= request.getParameter("averageGpa") %>" required><br>

  <label for="yearFounded">Year Founded:</label>
  <input type="number" id="yearFounded" name="yearFounded" value="<%= request.getParameter("yearFounded") %>" required><br>

  <button type="submit" name="action" value="update">Update College</button>
</form>
</body>
</html>