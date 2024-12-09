<%@ page import="DAO.TaskDAO" %>
<%@ page import="model.Tasks" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Date" %>

<html>
<head>
  <title>Manage Tasks</title>
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

    form {
      width: 100%;
      max-width: 500px;
      margin-bottom: 20px;
    }

    label {
      font-weight: 500;
      color: #555;
      display: block;
      margin-bottom: 5px;
    }

    input, button {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 1em;
    }

    button {
      background-color: #007bff;
      color: white;
      border: none;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    button:hover {
      background-color: #0056b3;
    }

    .delete {
      background-color: red;
    }

    .delete:hover {
      background-color: darkred;
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

    td button {
      margin: 0;
    }
  </style>
</head>
<body>
<a href="dashboard.jsp"><i class="fas fa-arrow-left"></i> Back</a>
<h1>Manage Tasks</h1>

<%
  HttpSession session1 = request.getSession(false);
  Integer userID = (Integer) session1.getAttribute("userID");

  if (userID == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  TaskDAO taskDAO = new TaskDAO();
  String action = request.getParameter("action");

  if (action != null) {
    try {
      switch (action) {
        case "add":
          taskDAO.addTask(
                  request.getParameter("taskName"),
                  Date.valueOf(request.getParameter("dueDate")),
                  userID
          );
          out.println("<p style='color: green;'>Task added successfully!</p>");
          break;

        case "delete":
          taskDAO.deleteTask(Integer.parseInt(request.getParameter("taskID")), userID);
          out.println("<p style='color: green;'>Task deleted successfully!</p>");
          break;

        case "update":
          taskDAO.updateTask(
                  Integer.parseInt(request.getParameter("taskID")),
                  request.getParameter("taskName"),
                  Date.valueOf(request.getParameter("dueDate")),
                  userID
          );
          out.println("<p style='color: green;'>Task updated successfully!</p>");
          break;
      }
    } catch (Exception e) {
      out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
    }
  }

  List<Tasks> tasks = taskDAO.getAllTasksByUser(userID);
%>

<h2>Add a New Task</h2>
<form method="post" action="manageTasks.jsp">
  <label for="taskName">Task Name:</label>
  <input type="text" id="taskName" name="taskName" required>

  <label for="dueDate">Due Date:</label>
  <input type="date" id="dueDate" name="dueDate" required>

  <button type="submit" name="action" value="add"><i class="fas fa-plus"></i> Add Task</button>
</form>

<h2>Your Tasks</h2>
<table>
  <tr>
    <th>Task Name</th>
    <th>Due Date</th>
    <th>Edit</th>
    <th>Delete</th>
  </tr>
  <% for (Tasks task : tasks) { %>
  <tr>
    <td><%= task.getTaskName() %></td>
    <td><%= task.getDueDate() %></td>
    <td>
      <form method="post" action="manageTasks.jsp" style="display: inline;">
        <input type="hidden" name="taskID" value="<%= task.getTaskID() %>">
        <input type="text" name="taskName" value="<%= task.getTaskName() %>" required>
        <input type="date" name="dueDate" value="<%= task.getDueDate().toString() %>" required>
        <button type="submit" name="action" value="update"><i class="fas fa-save"></i> Save</button>
      </form>
    </td>
    <td>
      <form method="post" action="manageTasks.jsp" style="display: inline;">
        <input type="hidden" name="taskID" value="<%= task.getTaskID() %>">
        <button type="submit" name="action" value="delete" class="delete"><i class="fas fa-trash"></i> Delete</button>
      </form>
    </td>
  </tr>
  <% } %>
</table>
</body>
</html>
