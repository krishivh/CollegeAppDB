<%@ page import="DAO.TaskDAO" %>
<%@ page import="model.Tasks" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Date" %>
<html>
<head>
  <title>Manage Tasks</title>
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
    h1 {
      text-align: center;
    }
  </style>
</head>
<body>
<a href="dashboard.jsp" style="text-decoration: none; font-size: 16px;">&#8592; Back</a>
<h1>Manage Tasks</h1>

<%
  HttpSession session1 = request.getSession(false);
  Integer userID = (Integer) session.getAttribute("userID");

  if (userID == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  TaskDAO taskDAO = new TaskDAO();

  // Process form actions (Add, Edit, Delete)
  String action = request.getParameter("action");
  if (action != null) {
    try {
      switch (action) {
        case "add":
          String taskName = request.getParameter("taskName");
          Date dueDate = Date.valueOf(request.getParameter("dueDate"));
          taskDAO.addTask(taskName, dueDate, userID);
          System.out.println("Task added successfully!");
          break;

        case "delete":
          int deleteTaskID = Integer.parseInt(request.getParameter("taskID"));
          taskDAO.deleteTask(deleteTaskID, userID);
          System.out.println("Task deleted successfully!");
          break;

        case "update":
          int updateTaskID = Integer.parseInt(request.getParameter("taskID"));
          String updatedTaskName = request.getParameter("taskName");
          Date updatedDueDate = Date.valueOf(request.getParameter("dueDate"));
          taskDAO.updateTask(updateTaskID, updatedTaskName, updatedDueDate, userID);
          System.out.println("Task updated successfully!");
          break;
      }
    } catch (Exception e) {
      System.out.println("Error: " + e.getMessage());
    }
  }

  // Fetch and display all tasks for the logged-in user
  List<Tasks> tasks = taskDAO.getAllTasksByUser(userID);
%>

<!-- Form to Add a New Task -->
<h2>Add a New Task</h2>
<form method="post" action="manageTasks.jsp">
  <label for="taskName">Task Name:</label>
  <input type="text" id="taskName" name="taskName" required><br><br>

  <label for="dueDate">Due Date:</label>
  <input type="date" id="dueDate" name="dueDate" required><br><br>

  <button type="submit" name="action" value="add">Add Task</button>
</form>

<!-- Display List of Tasks -->
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
        <button type="submit" name="action" value="update">Save</button>
      </form>
    </td>
    <td>
      <form method="post" action="manageTasks.jsp" style="display: inline;">
        <input type="hidden" name="taskID" value="<%= task.getTaskID() %>">
        <button type="submit" name="action" value="delete" style="background-color: red; color: white;">Delete</button>
      </form>
    </td>
  </tr>
  <% } %>
</table>
</body>
</html>
