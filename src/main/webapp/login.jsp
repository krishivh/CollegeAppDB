<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Login</h2>
<form action="login" method="post">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>
    <br><br>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>
    <br><br>
    <input type="submit" value="Login">
</form>

<%-- Display error message if login failed --%>
<c:if test="${not empty errorMessage}">
    <p style="color:red;">${errorMessage}</p>
</c:if>

<%-- Add a button or link to register.jsp --%>
<br><br>
<form action="register.jsp" method="get">
    <input type="submit" value="Create Account">
</form>

</body>
</html>