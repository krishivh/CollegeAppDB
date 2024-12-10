<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        /* overall page styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* container styling for the login form */
        .login-container {
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* page heading */
        h2 {
            margin-bottom: 15px;
            font-size: 1.5em;
            color: #333;
        }

        /* form labels */
        label {
            display: block;
            margin: 10px 0 5px;
            text-align: left;
            font-size: 0.9em;
            color: #555;
        }

        /* input fields */
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
        }

        /* the submit button */
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            color: white;
            font-size: 1em;
            cursor: pointer;
            border-radius: 4px;
        }

        /* hover effect for the submit button */
        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        /* registration link */
        .register-link {
            display: block;
            margin-top: 10px;
            font-size: 0.9em;
            color: #007bff;
            text-decoration: none;
        }

        /* hover effect for the registration link */
        .register-link:hover {
            color: #0056b3;
        }

        /* error messages */
        .error-message {
            color: red;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- container for the login form and related elements -->
    <div class="login-container">
        <!-- page heading -->
        <h2>Login</h2>
        <!-- login form with email and password fields -->
        <form action="login" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <input type="submit" value="Login">
        </form>

        <!-- error message displayed if login fails -->
        <c:if test="${not empty errorMessage}">
            <p class="error-message">${errorMessage}</p>
        </c:if>

        <!-- link to the registration page -->
        <a href="register.jsp" class="register-link">Create an Account</a>
    </div>
</body>
</html>
