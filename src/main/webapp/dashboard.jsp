<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        /*setting base styles for the body*/
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
       /*styling the heading*/
        h1 {
            color: #333;
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        /*styling links globally*/
        a {
            text-decoration: none;
            font-size: 16px;
        }

        /*back button link*/
        .back-link {
            position: absolute;
            top: 20px;
            left: 20px;
            color: #007bff;
            font-size: 1.2em;
            display: flex;
            align-items: center;
        }

        .back-link i {
            margin-right: 5px;
        }
        /*unordered list*/
        ul {
            list-style: none;
            padding: 0;
        }
        /*indiv list items*/
        ul li {
            margin: 15px 0;
        }

        /*links within list*/
        ul li a {
            display: flex;
            align-items: center;
            font-size: 1.2em;
            color: #333;
            background-color: #e0e7ff;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
            width: 250px;
            justify-content: center;
        }

        ul li a:hover {
            background-color: #c7d2fe;
            color: #0056b3;
        }

        /*adding spacing for icons within links*/
        ul li a i {
            margin-right: 10px;
        }

        .logout-link {
            background-color: #ffcccc;
        }

        .logout-link:hover {
            background-color: #ff9999;
        }
    </style>
</head>
<body>
<a href="login.jsp" class="back-link">
    <i class="fas fa-arrow-left"></i> Back
</a>
<h1>Welcome, User!</h1>
<ul>
    <li><a href="manageColleges.jsp"><i class="fas fa-school"></i> Manage Colleges</a></li>
    <li><a href="manageApplications.jsp"><i class="fas fa-file-alt"></i> Manage Applications</a></li>
    <li><a href="manageTasks.jsp"><i class="fas fa-tasks"></i> Manage Tasks</a></li>
    <li><a href="LogoutServlet" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
</ul>
</body>
</html>
