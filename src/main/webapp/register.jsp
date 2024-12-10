<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Register</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .register-container {
      background-color: #ffffff;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 8px;
      text-align: center;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 400px;
    }

    h2 {
      margin-bottom: 15px;
      font-size: 1.5em;
      color: #333;
    }

    label {
      display: block;
      margin: 10px 0 5px; /* spacing for labels */
      text-align: left;
      font-size: 0.9em;
      color: #555;
    }

    input {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 1em;
    }

    input[type="submit"] {
      width: 100%;
      padding: 10px;
      background-color: #28a745;
      border: none;
      color: white;
      font-size: 1em;
      cursor: pointer;
      border-radius: 4px;
    }

    input[type="submit"]:hover {
      background-color: #218838;
    }

    .error-message {
      color: red;
      font-size: 0.9em;
      margin-bottom: 10px;
    }

    a {
      display: block;
      margin-top: 10px;
      font-size: 0.9em;
      color: #007bff;
      text-decoration: none;
    }

    a:hover {
      color: #0056b3;
    }
  </style>
</head>
<body>
<div class="register-container">
  <h2>Create an Account</h2>
  <%-- display error message if validation fails --%>
  <c:if test="${not empty errorMessage}">
    <p class="error-message">${errorMessage}</p>
  </c:if>
  <form action="home" method="post">
    <label for="firstName">First Name:</label>
    <input type="text" id="firstName" name="firstName" required>
    <label for="lastName">Last Name:</label>
    <input type="text" id="lastName" name="lastName" required>
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>
    <label for="phone">Phone:</label>
    <input type="text" id="phone" name="phone" required>
    <label for="highSchool">High School:</label>
    <input type="text" id="highSchool" name="highSchool" required>
    <label for="gpa">GPA:</label>
    <input type="number" id="gpa" name="gpa" step="0.01" min="0" max="4" required>
    <input type="submit" value="Register">
  </form>
  <a href="login.jsp">Already have an account? Login</a>
</div>
</body>
</html>
