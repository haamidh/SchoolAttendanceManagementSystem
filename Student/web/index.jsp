<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="app.classes.dao.*" %>
<%@page import="app.classes.model.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BrightMind Institute - Attendance Management</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="index,jsp">
                <img src="BrightMind2.png" alt="" style="height: 60px;">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home</a>
                    </li>
                   
                    <li class="nav-item">
                        <a class="nav-link" href="contact.jsp">Contact</a>
                        
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="aboutus.jsp">About us</a>
                    </li>
                </ul>
            </div>
        </nav>

        <header class="hero-section">
            <div class="container text-center">
                <div class="transbox">
                    <h1>Welcome to BrightMind Institute</h1>
                <p>Your success is our priority</p>
                </div>
                
                <a href="login.jsp?role=admin" class="btn btn-primary">Admin</a>
                <a href="login.jsp?role=teacher" class="btn btn-success">Teacher</a>
            </div>
        </header>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
