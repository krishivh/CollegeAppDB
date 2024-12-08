<!DOCTYPE html>
<html>
<head>
  <title>Student Registration</title>
</head>
<body>
<h1>Register as a Student</h1>
<form action="${pageContext.request.contextPath}/home" method="post">
<%--  <label for="userID">UserID:</label>--%>
<%--  <input type="text" id="userID" name="userID" required><br>--%>

  <label for="firstName">First Name:</label>
  <input type="text" id="firstName" name="firstName" required><br>

  <label for="lastName">Last Name:</label>
  <input type="text" id="lastName" name="lastName" required><br>

  <label for="email">Email:</label>
  <input type="email" id="email" name="email" required><br>

  <label for="phone">Phone:</label>
  <input type="text" id="phone" name="phone" required><br>

  <label for="password">Password:</label>
  <input type="password" id="password" name="password" required><br>

  <label for="highSchool">High School:</label>
  <input type="text" id="highSchool" name="highSchool" required><br>

  <label for="gpa">GPA:</label>
  <input type="number" id="gpa" step="0.01" min="0.00" max="4.00" name="gpa" required><br>

  <button type="submit">Register</button>
</form>
</body>
</html>