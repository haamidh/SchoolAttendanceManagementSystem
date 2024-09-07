<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - BrightMind Institute</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f9fc;
        }
        .container {
            padding: 60px 15px;
        }
        h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 40px;
            color: #333;
        }
        .contact-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
            transition: transform 0.3s ease;
        }
        .contact-card:hover {
            transform: translateY(-10px);
        }
        .contact-info {
            margin-bottom: 15px;
        }
        .contact-info i {
            color: #5c7cfa;
            margin-right: 10px;
        }
        .contact-title {
            font-weight: bold;
            color: #555;
        }
        .contact-text {
            color: #777;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="index.jsp">
                <img src="BrightMind2.png" alt="" style="height: 60px;">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    
                    
                    <li class="nav-item active">
                        <a class="nav-link" href="contact.jsp">Contact</a>
                    </li>
                    
                    <li class="nav-item ">
                        <a class="nav-link" href="aboutus.jsp">About us</a>
                    </li>
                </ul>
            </div>
        </nav>
    <div class="container">
        <h2>Contact Us</h2>
        <div class="row">
            <!-- Head of Institute -->
            <div class="col-md-6">
                <div class="contact-card">
                    <h4 class="contact-title">Head of Institute</h4>
                    <div class="contact-info">
                        <i class="fas fa-user"></i> Dr. John Smith
                    </div>
                    <div class="contact-info">
                        <i class="fas fa-phone"></i> +94 11 633 3535 
                    </div>
                    <div class="contact-info">
                        <i class="fas fa-envelope"></i> john.smith@brightmind.edu
                    </div>
                    <div class="contact-info">
                        <i class="fas fa-map-marker-alt"></i> 21, BrightMind Institute, Malabe, Sri Lanka
                    </div>
                </div>
            </div>
            <!-- Lead of Teachers -->
            <div class="col-md-6">
                <div class="contact-card">
                    <h4 class="contact-title">Lead of Teachers</h4>
                    <div class="contact-info">
                        <i class="fas fa-user"></i> Mrs. Emily Johnson
                    </div>
                    <div class="contact-info">
                        <i class="fas fa-phone"></i> +94 11 654 3210
                    </div>
                    <div class="contact-info">
                        <i class="fas fa-envelope"></i> emily.johnson@brightmind.edu
                    </div>
                    <div class="contact-info">
                        <i class="fas fa-map-marker-alt"></i> 21, BrightMind Institute, Malabe, Sri Lanka
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
