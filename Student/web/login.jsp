<%@ page import="app.classes.dao.*" %>
<%@ page import="app.classes.model.*" %>
<%
    String role = request.getParameter("role");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (role != null && username != null && password != null) {
        System.out.println("Role: " + role);
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);

        UserDAO userDAO = new UserDAO();
        User user = userDAO.validateUser(username, password, role);

        if (user != null) {
            session.setAttribute("user", user);
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin_home.jsp");
            } else if ("teacher".equals(user.getRole())) {
                response.sendRedirect("teacher_home.jsp?username="+username);
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f7f9fc;
            font-family: 'Arial', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .container {
            max-width: 400px;
            width: 100%;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }
        h2 {
            margin-bottom: 20px;
            font-weight: bold;
            color: #333;
            text-align: center;
        }
        .form-group label {
            font-weight: 500;
            color: #555;
        }
        .form-control {
            border-radius: 25px;
            padding: 10px 15px;
            border: 1px solid #ced4da;
        }
        .btn {
            border-radius: 25px;
            padding: 10px 20px;
            background-color: #5c7cfa;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #3b5bdb;
        }
        .text-danger {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Login</h2>
    <form action="login.jsp" method="post">
        <div class="form-group">
            <label for="role">Role</label>
            <select class="form-control" name="role" id="role">
                <option value="admin">Admin</option>
                <option value="teacher">Teacher</option>
            </select>
        </div>
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" name="username" id="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" name="password" id="password" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Login</button>
        <%
            String error = request.getParameter("error");
            if (error != null) {
                out.println("<p class='text-danger text-center'>" + error + "</p>");
            }
        %>
    </form>
</div>

<script>
    // Set the role based on the URL parameter
    const urlParams = new URLSearchParams(window.location.search);
    const role = urlParams.get('role');
    if (role) {
        document.getElementById('role').value = role;
    }
</script>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
